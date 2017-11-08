require 'test/unit'
require_relative '../baseball_validator'
require_relative '../section'
require_relative '../venue'

class BaseballValidatorTest < Test::Unit::TestCase
  def setup
    @service = BaseballValidator.new
    @section = Section.new(1)
    @section.add_row("1", "foo")
    @venue = Venue.new
    @venue.create_from_file("tests/fixtures/dodgerstadium_sections.csv")
  end

  def teardown
  end

  def test_get_valid_row_nil_section
    assert_nil(@service.get_valid_row(nil,"foo"))
  end

  def test_get_valid_row_section
    assert_equal("1", @service.get_valid_row(@section, "foo"))
  end

  def test_get_section_invalid
    assert_nil(@service.get_valid_section("foo", section_map))
  end

  def test_get_section_by_full_name
    assert(@service.get_valid_section("Reserve 8", section_map))
  end

  def test_get_section_by_initials
    assert(@service.get_valid_section("RS8", section_map))
  end

  def test_get_section_by_partial
    assert(@service.get_valid_section("reserve 8", section_map))
  end

  private

  def section_map
    @venue.send(:section_map)
  end
end
