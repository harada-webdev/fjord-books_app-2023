# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/, on: %i[create update],
                                 message: I18n.t('activerecord.errors.messages.password.include_specified_characters') },
                       if: -> { password.present? }
  validates :name, presence: true, on: %i[create update]
  validates :address, presence: true, on: %i[create update]
  validates :postal_code, presence: true, on: %i[create update]
  validates :postal_code, format: { with: /\A\d{3}-?\d{4}\z/ }, on: %i[create update], if: -> { postal_code.present? }
  validates :biography, presence: true, on: %i[create update]

  paginates_per 3
end
