require 'test/unit'
require_relative '../venue'

class VenueTest < Test::Unit::TestCase
  def setup
    @venue = Venue.new
  end

  def teardown
  end

  def test_initialize_section_map
    assert_equal({}, section_map)
  end

  def test_create_from_file_error
    assert_raise Venue::IngestionError do
      @venue.create_from_file("foo/bar/path")
    end
  end

  def test_create_from_file
    @venue.create_from_file("tests/fixtures/test_manifest.csv")
    assert_equal(section_map.keys.size, 5, "Should create a key per section")
  end

  def test_get_normalized_no_such_section
    @venue.create_from_file("tests/fixtures/test_manifest.csv")
    fake_section = "faker"
    assert_nil(section_map[fake_section])
  end

  def test_get_normalized_no_such_row
    @venue.create_from_file("tests/fixtures/test_manifest.csv")
    real_section = "133"
    assert(section_map[real_section])
    assert_equal(@venue.get_normalized(real_section, "fakerow"), [nil, nil, false])
  end

  def test_get_normalized_matching_section
    @venue.create_from_file("tests/fixtures/test_manifest.csv")
    real_section = "133"
    real_row = "A"
    assert(section_map[real_section])
    assert(section_map[real_section].valid_row?(real_row))
    assert_equal(@venue.get_normalized(real_section, real_row), ["1", "0", "true"])
  end

  def test_get_normalized_matching_section
    @venue.create_from_file("tests/fixtures/test_manifest.csv")
    real_section = "133"
    real_row = "A"
    assert(section_map[real_section])
    assert(section_map[real_section].valid_row?(real_row))
    assert_equal(@venue.get_normalized(real_section, real_row), ["1", "0", "true"])
  end

  private

  def section_map
    @venue.send(:section_map)
  end
end
