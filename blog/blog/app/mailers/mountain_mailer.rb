class MountainMailer < ApplicationMailer

	#Se hará de forma in-line, no asincrono.
	def new_mountain(mountain)
		@mountain = mountain

		User.all.each do |user|
			mail(to: user.email, subject: "Nuevo cerro en blog")
		end
	end
end
