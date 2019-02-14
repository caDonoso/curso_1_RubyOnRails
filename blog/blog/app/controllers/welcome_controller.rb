class WelcomeController < ApplicationController
	# El admin podrá acceder al dashboard para publicar montañas
	before_action :authenticate_admin!, only: [:dashboard]

	def index

	end

	def dashboard
		@estadoRecibido = params[:estado]
		if @estadoRecibido === "borradores"
			@mountains = Mountain.paginate(page: params[:page], per_page: 3).borradores
		else
			@mountains = Mountain.paginate(page: params[:page], per_page: 3).publicados
		end
	end
end
