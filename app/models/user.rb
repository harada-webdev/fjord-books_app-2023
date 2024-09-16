# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  validate :avatar_type

  private

  def avatar_type
    return unless avatar.attached?
    return if avatar.blob.content_type.in?(%('image/jpeg image/gif'))

    errors.add(:avatar, :restricted_image_file_format)
  end
end
