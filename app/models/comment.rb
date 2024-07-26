# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :contact_message

  validates :body, presence: true
end
