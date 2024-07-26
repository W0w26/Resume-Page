class ContactMessage < ApplicationRecord
  has_many :comment, dependent: :destroy
end
