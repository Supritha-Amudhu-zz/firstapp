require 'digest'
class User < ActiveRecord::Base
	has_many :microposts, :dependent => :destroy

	attr_accessor :encrypt_password
	attr_accessible :name, :email, :password, :encrypt_password, :password_confirmation
	validates_presence_of :name, :email, :password

	validates_length_of :name, :maximum => 50

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates_format_of :email, :with => EmailRegex
	validates_uniqueness_of :email, :case_sensitive => false

	validates_confirmation_of :password
	validates_length_of :password, :within => 6..40
	validates_confirmation_of :password_confirmation
	validates_length_of :password_confirmation, :within => 6..40

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password(submitted_password)
	end

	def remember_me!
		self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
		save_without_validation
	end

	def feed
		Micropost.all(:conditions => ["user_id = ?", id])
	end


	private
	def encrypt_password
		unless password.nil?
			self.salt = make_salt
			self.encrypt_password = encrypt(password)
		end
	end

	def encrypt(string)
		secure_hash("#{salt}#{string}")
	end

	def make_salt
		secure_hash("#{Time.now.utc}#{password}")
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

end
