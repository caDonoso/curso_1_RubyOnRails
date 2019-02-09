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


	before_action :authenticate_user!, except: [:show, :index]

	# set_mountain lo que hace es que antes de cualquier accion, hace:
	# @mountain = Mountain.find(params[:id]), esto para hacer Refactor y eliminar codigo repetido.
	before_action :set_mountain, except: [:index, :new, :create]

	#GET /mountains
	def index
		@mountains = Mountain.all
	end

	#GET /mountains/1
	def show
		@mountain.update_visits_count
	end

	#GET /mountains/new
	def new
		# no esta en la base de datos aun
		@mountain = Mountain.new
	end

	#POST /mountains
	def create
		#INSERT INTO
		@mountain = current_user.mountains.new(mountain_params)
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
			redirect_to "/mountains", success: "Cerro '#{@mountainName}'' eliminado con éxito."
		else
			redirect_to "/mountains", danger: "No se pudo eliminar el Cerro '#{@mountainName}'."
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

	private

	def set_mountain
		@mountain = Mountain.find(params[:id])
	end
	

	#STRONG PARAMS
	def mountain_params
		params.require(:mountain).permit(:name,:description,:altitude)
	end
end