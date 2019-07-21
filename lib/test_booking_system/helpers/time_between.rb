# frozen_string_literal: true

module TestBookingSystem
  # TODO: This solution looks pretty ugly to be honest.
  #       I would like to rethinking around scheduling system and make
  #      it much more flexible and convenient.

  module Helpers
    def time_between?(args)
      args[:time].seconds_since_midnight >= args[:from].seconds_since_midnight &&
        args[:time].seconds_since_midnight <= args[:to].seconds_since_midnight
    end
  end
end
