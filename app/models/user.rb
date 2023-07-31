class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :emp_id, presence: true, format: { with: /\A[a-zA-Z]{2}\d{4}\z/, message: "ID should be 2 letters followed by 4 digits" }
         has_many :expenses, dependent: :destroy
         has_many :expense_reports, dependent: :destroy
         enum status: {
          present: 0,
          terminated: 1
         }
end
