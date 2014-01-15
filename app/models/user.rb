class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :cpf, :email
  validates_uniqueness_of :email, :cpf
  validates_format_of :cpf, with: /\A\d{11}\z/
  validates_format_of :email, with: Devise.email_regexp

end
