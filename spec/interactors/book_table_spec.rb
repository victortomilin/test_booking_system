# frozen_string_literal: true

# TODO: Well, I have described a main use cases according requirements but
#       I think use cases could be much more. I think the test file is too large
#       and would be great to reduce amount of lines through splitting tests by
#       suitable contexts and extract to separated files.
#
# TODO: I have covered only interaptor in functional test style,
#       but I would prefer to do unit test per each part of app such as models,
#       validators, helpers etc.
#
# TODO: Might be better to use a fabricator to reproduce an entities in DB.
#
# TODO: Get to start using mocking and stubbing instead of reproducing
#       a use cases directly through the real entities.
#
# TODO: Too many magic numbers

RSpec.describe TestBookingSystem::Interactors::BookTable do
  it 'should book a table for the user at the restaurant' do
    date = 10.days.from_now.beginning_of_day + 11.hours
    result = book_at 'Blue Oyster', date
    expect(result).to be_a_success
    expect(result.reservation).to be_present
  end

  it 'should be declined by reason that user trying to book a tables in different restaurants at the same time' do
    date = 10.days.from_now.beginning_of_day + 11.hours
    user = TestBookingSystem::Models::User.create

    book_for_user_at user, date, 'Blue Oyster'
    result = book_for_user_at user, date, 'Rick and Morty Bar'

    expect(result).to be_a_failure
  end

  it 'should be declined by reason that duration is not multiple to 30 minutes' do
    date = 10.days.from_now.beginning_of_day + 11.hours
    result = book_at 'Blue Oyster', date, 175
    expect(result).to be_a_failure
  end

  it 'should calculate a proper end date of the reservation' do
    expected_end_date = DateTime.parse('2019-07-20 18:00:00 +0300')
    date = DateTime.parse('2019-07-20 17:30:00 +0300')
    result = book_at 'Blue Oyster', date, 30

    expect(result.reservation.end_date).to eq(expected_end_date)
  end

  it 'should be declined by reason that user trying to book a tables which is already booked' do
    date = 10.days.from_now

    first_user = TestBookingSystem::Models::User.create
    second_user = TestBookingSystem::Models::User.create

    restaurant = TestBookingSystem::Models::Restaurant.create name: 'Blue Oyster'
    table = TestBookingSystem::Models::Table.create number: 1, restaurant: restaurant

    TestBookingSystem::Interactors::BookTable.call(
      user: first_user,
      table: table,
      date: date,
      duration: 180
    )

    result = TestBookingSystem::Interactors::BookTable.call(
      user: second_user,
      table: table,
      date: date + 30.minutes,
      duration: 180
    )

    expect(result).to be_a_failure
  end

  it 'should be invalid because user wants to book the table in restaurant at the close time' do
    result = book_at 'Blue Oyster', 10.days.from_now.beginning_of_day + 9.hours
    expect(result).to be_a_failure
  end

  it 'should be invalid because user wants to book the table in restaurant at the day off' do
    date = 10.days.from_now
    user = TestBookingSystem::Models::User.create
    restaurant = TestBookingSystem::Models::Restaurant.create name: 'Blue Oyster'
    table = TestBookingSystem::Models::Table.create number: 1, restaurant: restaurant
    result = TestBookingSystem::Interactors::BookTable.call(user: user, table: table, date: date, duration: 180)

    expect(result).to be_a_failure
  end

  def book_at(restaurant_name, date, duration = 180)
    user = TestBookingSystem::Models::User.create
    book_for_user_at user, date, restaurant_name, duration
  end

  def book_for_user_at(user, date, restaurant_name, duration = 180)
    restaurant = TestBookingSystem::Models::Restaurant.create name: restaurant_name
    restaurant.schedules.create(
      day_of_week: date.wday,
      open_time: Time.new(1, 1, 1, 10, 30, 0),
      close_time: Time.new(1, 1, 1, 22, 30, 0)
    )
    table = TestBookingSystem::Models::Table.create number: 1, restaurant: restaurant
    TestBookingSystem::Interactors::BookTable.call(user: user, table: table, date: date, duration: duration)
  end
end
