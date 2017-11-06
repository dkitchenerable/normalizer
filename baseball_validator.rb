class BaseballValidator
  def get_valid_section(section, section_map)
    fetch_section(section, section_map)
  end
  
  def get_valid_row(section, row)
    return section.get_row(row)
  end

  private 

  
  def fetch_section(section, section_map)
    digit = section.scan(/\d/).join('')
    venue_section ||= ( section_map[digit] || section_map[section] )
    venue_section
  end
end
