# frozen_string_literal: true

module TestBookingSystem
  module Models
    class Schedule < ActiveRecord::Base
      attribute :open_time, :time
      attribute :close_time, :time

      belongs_to :restaurant

      validates :day_of_week, uniqueness: { scope: :restaurant }
    end
  end
end
