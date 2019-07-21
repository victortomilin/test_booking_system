# frozen_string_literal: true

module TestBookingSystem
  module Models
    class Table < ActiveRecord::Base
      belongs_to :restaurant

      validates :number, uniqueness: { scope: :restaurant }
    end
  end
end
