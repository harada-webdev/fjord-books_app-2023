# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :memo, presence: true
  validates :author, presence: true
end
