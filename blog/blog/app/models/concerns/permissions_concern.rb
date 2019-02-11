module PermissionsConcern
	extend ActiveSupport::Concern
	
	def is_normal_user?
		self.permission_level >= 1
	end

	def is_editor?
		self.permission_level >= 2
	end

	#El editor tiene tanto las funciones de un usuario normal como tambien de un editor,
	# ademas de sus propias funciones, por eso el >= 3.
	def is_admin?
		self.permission_level >= 3
	end
end