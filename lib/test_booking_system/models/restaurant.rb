# frozen_string_literal: true

module TestBookingSystem
  module Models
    class Restaurant < ActiveRecord::Base
      has_many :tables
      has_many :schedules

      validates :name, uniqueness: true
    end
  end
end
