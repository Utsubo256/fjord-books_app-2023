# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end
  validate :avatar_content_type

  private

  def avatar_content_type
    valid_extensions = %w[image/jpeg image/png image/gif]
    return unless avatar.attached?
    return if valid_extensions.include?(avatar.content_type)

    errors.add(:avatar, :invalid_format)
  end
end
