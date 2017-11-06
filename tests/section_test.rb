require 'test/unit'
require_relative '../section'

class SectionTest < Test::Unit::TestCase
  def setup
    @section = Section.new(1)
  end

  def teardown
  end

  def test_initialize_section_id
    assert_equal(1, @section.id)
  end

  def test_initialize_section_row_map
    assert_equal({}, row_map)
  end

  def test_add_row_correctness
    @section.add_row("1", "foo-bar")
    assert(row_map.has_key?("foo-bar"))
    assert_equal(row_map["foo-bar"], "1")
  end

  def test_get_row_correctness
    @section.add_row("1", "foo-bar")
    assert_equal(@section.get_row("foo-bar"), "1")
  end

  def test_valid_row_false
    @section.add_row("1", "foo-bar")
    assert_equal(false, @section.valid_row?("foo-bar-false"))
  end

  def test_valid_row_true
    @section.add_row("1", "foo-bar")
    assert(@section.valid_row?("foo-bar"))
  end

  private

  def row_map
    @section.send(:row_map)
  end
end
