# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :club
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :test

  private

  def test
    self.club ||= Club.first
  end
end
