# frozen_string_literal: true

module TestBookingSystem
  module Models
    class User < ActiveRecord::Base
      has_many :reservations
      has_many :tables, through: :reservations
    end
  end
end
