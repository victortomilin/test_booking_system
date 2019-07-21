# frozen_string_literal: true

require 'active_record'
require 'interactor'

require 'test_booking_system/version'

require 'test_booking_system/helpers/time_between'

require 'test_booking_system/models/user'
require 'test_booking_system/models/reservation'
require 'test_booking_system/models/restaurant'
require 'test_booking_system/models/table'
require 'test_booking_system/models/schedule'

require 'test_booking_system/interactors/book_table'

require 'test_booking_system/validators/validate_table_booking_ability'
require 'test_booking_system/validators/validate_restaurant_ability'


module TestBookingSystem
  class Error < StandardError; end
  # Your code goes here...
end
