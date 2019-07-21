# frozen_string_literal: true

module TestBookingSystem
  module Validators
    class ValidateTableBookingAbility
      include ActiveModel::Validations

      validates :start_date, :duration, :user, :table, presence: true
      validate :date_and_place_uniqueness
      validate :duration_is_multiple_of_30_minutes
      validate :booking_table_already_reserved

      def initialize(reservation)
        @start_date = reservation.start_date
        @end_date = reservation.end_date
        @duration = reservation.duration
        @user = reservation.user
        @table = reservation.table
        @restaurant = reservation.restaurant
      end

      private

      attr_reader :start_date, :end_date, :duration, :user, :table

      def date_and_place_uniqueness
        errors.add(:start_date, :restaurant) if booking_at_the_same_time_in_different_places?
      end

      def duration_is_multiple_of_30_minutes
        errors.add(:duration) unless (duration % 30).zero?
      end

      def booking_table_already_reserved
        errors.add(:start_date, :end_date) unless table_is_available?
      end

      def booking_at_the_same_time_in_different_places?
        TestBookingSystem::Models::Reservation
          .joins(table: :restaurant)
          .where('user_id = ? AND start_date = ? AND tables.restaurant_id != ?', user.id, start_date, table.restaurant.id)
          .present?
      end

      def table_is_available?
        TestBookingSystem::Models::Reservation
          .where('table_id = ? AND end_date BETWEEN ? AND ?', table.id, start_date, end_date)
          .empty?
      end
    end
  end
end
