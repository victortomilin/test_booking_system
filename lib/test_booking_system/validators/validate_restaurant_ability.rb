# frozen_string_literal: true

module TestBookingSystem
  module Validators
    class ValidateRestaurantAbility
      include ActiveModel::Validations
      include TestBookingSystem::Helpers

      validate :restaurant_will_works_at_booking_time
      validate :restaurant_open_at_booking_time

      def initialize(reservation)
        @start_date = reservation.start_date
        @end_date = reservation.end_date
        @restaurant = reservation.restaurant
      end

      private

      attr_reader :start_date, :end_date, :restaurant

      def restaurant_will_works_at_booking_time
        return unless schedule_by_booking_date.blank?

        errors.add :restaurant, "Restaurant #{restaurant.name} will be off at #{start_date}"
      end

      def restaurant_open_at_booking_time
        schedule = schedule_by_booking_date
        return unless schedule.present?
        return if time_between?(time: start_date, from: schedule.open_time, to: schedule.close_time)

        errors.add :restaurant, "Restaurant #{restaurant.name} will be closed at #{start_date}"
      end

      def schedule_by_booking_date
        restaurant.schedules.where(day_of_week: start_date.wday).first
      end
    end
  end
end
