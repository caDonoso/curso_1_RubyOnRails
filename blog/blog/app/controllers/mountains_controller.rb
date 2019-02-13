class MountainsController < ApplicationController
	# Puede ser after_action
	# Lo que hace before_action es analizar antes de ejecutar una accion,
	#para este caso se utiliza para validad si un usuario ha iniciado sesion antes
	#de agragar un cerro.
	# authenticate_user! hace lo siguiente

	# def validate_user
	#	 redirect_to new_user_session_path, info: "Necesitas iniciar sesión"
	# end
	#


	before_action :authenticate_user!, except: [:index]

	# set_mountain lo que hace es que antes de cualquier accion, hace:
	# @mountain = Mountain.find(params[:id]), esto para hacer Refactor y eliminar codigo repetido.
	# No se añade el parametro 'publish' para que dicha accion tenga el id de la montaña a publicar.
	before_action :set_mountain, except: [:index, :new, :create]

	#####################################################################################
	# El usuario normal solo puede ver las montañas agregadas por los editores y admin. #
	#####################################################################################

	#Aca van los callbacks que verifican que el usuario pueda realizar las acciones correspondientes
	# tales como eliminar, crear, editar, ver, etc.

	# El editor además de ver las montañas, podrá crear o editar una.
	before_action :authenticate_editor!, only: [:new, :create, :update, :edit]

	# El admin tendrá tambien las funciones del editor, pero especificamente puede destruir también.
	before_action :authenticate_admin!, only: [:destroy, :publish, :unpublish]

	#GET /mountains
	def index
		#Se utiliza el scope 'publicados' del modelo Mountain
		# para enadenar se puede utilizar 'Mountain.publicados.ultimos'
		@mountains = Mountain.paginate(page: params[:page], per_page: 3).publicados

	end

	#GET /mountains/1
	def show
		@mountain.update_visits_count
		@comment = Comment.new
	end

	#GET /mountains/new
	def new
		# no esta en la base de datos aun
		@mountain = Mountain.new
		@categories = Category.all
	end

	#POST /mountains
	def create
		#INSERT INTO
		@mountain = current_user.mountains.new(mountain_params)
		@mountain.categories = params[:categories]
		if @mountain.save
			redirect_to "/", success: "Cerro agregado con éxito."
		else
			render :new
		end
	end

	def destroy
		#DELETE FROM mountains
				
		@mountainName = @mountain.name
		if @mountain.destroy
			redirect_to mountains_path, success: "Cerro '#{@mountainName}'' eliminado con éxito."
		else
			redirect_to mountains_path, danger: "No se pudo eliminar el Cerro '#{@mountainName}'."
		end
	end

	def update
		# UPDATE
		# @mountain.update_attributes({name: 'nuevo nombre'})
		
		if @mountain.update(mountain_params)
			redirect_to "/mountains", success: "Datos del cerro modificados con éxito."
		else
			render :edit
		end
	end

	def edit
		
	end

	def publish
		if @mountain.publish!
			redirect_to "/mountains", success: "Cerro publicado con éxito."
		end
		
	end

	def unpublish
		if @mountain.unpublish!
			redirect_to "/mountains", success: "Cerro mandado a borradores con éxito."
		end
	end

	private

	def set_mountain
		@mountain = Mountain.find(params[:id])
	end
	

	#STRONG PARAMS
	def mountain_params
		params.require(:mountain).permit(:name,:description,:altitude, :cover, :categories)
	end
end