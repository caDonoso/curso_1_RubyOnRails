class Mountain < ApplicationRecord
	include AASM

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :has_categories, dependent: :destroy
	has_many :categories, through: :has_categories, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true, length: {minimum: 20}
	validates :altitude, presence: true

	#El archivo después de subirse tendrá dos otras copias con esas dimensiones.
	#Ruby agregará un atributo al form automaticamente (enctype="multipart/form-data")
	has_attached_file :cover, styles: {medium: "1280x720", thumb: "800x600"}

	#Se valida el archivo que los usuarios podrán subir
	#/\Aimage\/.*\Z/ es una expresion regular para que el usuario pueda subir jpeg, PNG, gif, etc.
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	# setea altitude a 0 antes de que sea creado, esto para evitar que sea nulo
	before_save :set_visits_count
	after_create :save_categories

	#Custom setter ya que el metodo termina con un '='
	def categories=(value)
		@categories = value
	end


	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	scope :publicados, -> {where(state: "published")}

	scope :borradores, -> {where(state: "in_draft")}

	scope :ultimos, -> {order("created_at DESC").limit(10)}

	aasm column:"state" do

		#Toda montaña que sea crea se inicializa con draft (borrador)
		state :in_draft, initial: true
		state :published


		# Eventos que sirven para que se puedan cambiar estados
		event :publish do
			transitions from: :in_draft, to: :published
		end

		event :unpublish do
			transitions from: :published, to: :in_draft
		end
	end

	private

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, mountain_id: self.id)
		end
	end

	def set_visits_count
		self.visits_count ||= 0
	end
end
