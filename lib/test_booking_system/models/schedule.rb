# frozen_string_literal: true

module TestBookingSystem
  module Models
    # TODO: I guess this is not quite good name for entity,
    #       might be better to use "business hours" or something like that
    class Schedule < ActiveRecord::Base
      attribute :open_time, :time
      attribute :close_time, :time

      belongs_to :restaurant

      validates :day_of_week, uniqueness: { scope: :restaurant }
    end
  end
end
