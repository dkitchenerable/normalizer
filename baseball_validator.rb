class BaseballValidator
  def get_valid_section(section, section_map)
    fetch_section(section, section_map)
  end

  def get_valid_row(section, row)
    section ? section.get_row(row) : nil
  end

  private

  def fetch_section(section, section_map)
    venue_section ||=
        (
          by_full_name(section, section_map) ||
          by_digit(section, section_map)
        )
    venue_section
  end

  def by_full_name(section, map)
    map[section]
  end

  def by_digit(section, map)
    digit = section.scan(/\d/).join('')
    map[digit]
  end

end
