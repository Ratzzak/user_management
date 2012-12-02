class PasswordUtils

	def self.create_random_password
		((0...6).map{65.+(rand(26)).chr} + (1..2).map{"!@#%&*_".split("").sample}).shuffle.join	
	end

end
