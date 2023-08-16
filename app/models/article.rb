class Article < ApplicationRecord
include Visible
  has_many :comments, dependent: :destroy
  validates :title, presence: true, acceptance: {accept: "YES"}
  validates :body, presence: true, length: { minimum: 10 }
end

