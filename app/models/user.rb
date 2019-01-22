class User < ApplicationRecord
	has_secure_password
	has_many :tasks, dependent: :destroy
	validates :first_name, :last_name, :email, :password_digest, presence: true
	validates :email, uniqueness: { case_sensitive: false }
end
