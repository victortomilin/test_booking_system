# frozen_string_literal: true

module TestBookingSystem
  module Interactors
    class BookTable
      include Interactor

      def call
        if reservation_valid? && reservation.save
          context.reservation = reservation
        else
          context.fail!
        end
      end

      private

      def reservation
        Models::Reservation.new do |r|
          r.user = context.user
          r.table = context.table
          r.start_date = context.date.utc
          r.duration = context.duration
          r.end_date = end_date_of_reservation.utc
        end
      end

      def reservation_valid?
        restaurant_available? && table_available?
      end

      def restaurant_available?
        validator ||= Validators::ValidateRestaurantAbility.new reservation
        validator.valid?
      end

      def table_available?
        validator ||= Validators::ValidateTableBookingAbility.new reservation
        validator.valid?
      end

      def end_date_of_reservation
        context.date + context.duration.minutes
      end
    end
  end
end
