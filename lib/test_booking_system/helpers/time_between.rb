# frozen_string_literal: true

module TestBookingSystem
  module Helpers
    def time_between?(args)
      args[:time].seconds_since_midnight >= args[:from].seconds_since_midnight &&
        args[:time].seconds_since_midnight <= args[:to].seconds_since_midnight
    end
  end
end
