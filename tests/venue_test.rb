require 'test/unit'
require_relative '../venue'

class VenueTest < Test::Unit::TestCase
  def setup
    @venue = Venue.new
  end

  def teardown
  end

  def test_initialize_seat_map
    assert_equal({}, @venue.send(:seat_map))
  end

  def test_create_from_file_error
    assert_raise Venue::IngestionError do
      @venue.create_from_file("foo/bar/path")
    end
  end

  def test_create_from_file
  end

end
