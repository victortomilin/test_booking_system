# frozen_string_literal: true

module TestBookingSystem
  module Models
    class Reservation < ActiveRecord::Base
      attribute :start_date, :datetime
      attribute :end_date, :datetime

      attr_accessor :duration

      belongs_to :user
      belongs_to :table

      has_one :restaurant, through: :table
    end
  end
end
