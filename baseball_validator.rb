class BaseballValidator

  MAPPED_INITIALS = {
    "LG" => "Loge Box",
    "RS" => "Reserve",
    "FD" => "Field Box",
    "PR" => "Right Field Pavilion",
    "PL" => "Left Field Pavilion",
    "TD" => "Top Deck",
    "CL" => "Club",
    "DG" => "Dugout Club"
  }

  MAPPED_PARTIAL_NAMES = {
    "reserve" => "Reserve",
    "loge box" => "Loge Box",
    "loge" => "Loge Box",
    "preferred field" => "Field Box",
    "field box" => "Field Box",
    "top deck" => "Top Deck",
    "pavilion" => ["Right Field Pavilion", "Left Field Pavilion"]
  }

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
          by_digit(section, section_map) ||
          by_initials(section, section_map) ||
          by_partial(section, section_map)
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

  def by_initials(section, map)
    temp_section = section.dup
    digit = section.scan(/\d/).join('')
    temp_section.slice!(digit)
    mapped = MAPPED_INITIALS[temp_section.strip]
    map["#{mapped} #{digit}"]
  end

  def by_partial(section, map)
    digit = section.scan(/\d/).join('')
    temp = nil
    MAPPED_PARTIAL_NAMES.each_pair do |k, values|
      values = [values] if values.is_a? String
      values.each do |v| 
        temp = map["#{v} #{digit}"] if section.downcase.include?(k)
      end
      break if temp
    end
    temp
  end

end
