class Section

  attr_reader :id

  def initialize(section_id)
    @id = section_id
    @row_map = {}
  end

  def add_row(row_id, row_name)
    row_map[row_name] = row_id
  end

  def get_row(row)
    row_map[row]
  end

  def valid_row?(row)
    row_map.has_key?(row)
  end

  private

  attr_reader :row_map
end
