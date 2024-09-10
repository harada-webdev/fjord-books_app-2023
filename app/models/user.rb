# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, on: %i[create update]
  validates :address, presence: true, on: %i[create update]
  validates :postal_code, presence: true, on: %i[create update]
  validates :bio, presence: true, on: %i[create update]

  paginates_per 2
end
