class User < ApplicationRecord
  ## Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :confirmable, :trackable, :lockable

  validates :first_name, :last_name, :email, presence: true, length: { maximum: 100 }
end
