class Mountain < ApplicationRecord
	belongs_to :user
	has_many :comments
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true, length: {minimum: 20}
	validates :altitude, presence: true

	# setea altitude a 0 antes de que sea creado, esto para evitar que sea nulo
	before_save :set_visits_count

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end


	private

	def set_visits_count
		self.visits_count ||= 0
	end
end
