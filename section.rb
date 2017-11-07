class Section

  attr_reader :id

  def initialize(section_id)
    @id = section_id
    @row_map = {}
  end

  def add_row(row_id, row)
    row_map[formatted_row(row)] = row_id
  end

  def get_row(row)
    row_map[formatted_row(row)]
  end

  private

  attr_reader :row_map

  def formatted_row(unformatted_row)
    if unformatted_row
      unformatted_row.chomp.downcase
    else
      nil
    end
  end
end
