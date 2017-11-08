class BaseballValidator

  MAPPED_NAMES = {
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
    "pavilion" => "Right Field Pavilion",
    "pavilion" => "Left Field Pavilion",
    "field box" => "Field Box",
    "top deck" => "Top Deck",
    "loge" => "Loge Box",
    "loge box" => "Loge Box",
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
          by_reserve(section, section_map)
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
    mapped = MAPPED_NAMES[temp_section.strip]
    map["#{mapped} #{digit}"]
  end

  def by_reserve(section, map)
    digit = section.scan(/\d/).join('')
    if section.downcase.include?("reserve")
      map["Reserve #{digit}"]
    elsif section.downcase.include?("loge box")
      map["Loge Box #{digit}"]
    elsif section.downcase.include?("loge")
      map["Loge Box #{digit}"]
    elsif section.downcase.include?("preferred field")
      map["Field Box #{digit}"]
    elsif section.downcase.include?("field box")
      map["Field Box #{digit}"]
    elsif section.downcase.include?("top deck")
      map["Top Deck #{digit}"]
    elsif section.downcase.include?("pavilion")
      map["Right Field Pavilion #{digit}"] ||
      map["Left Field Pavilion #{digit}"]
    end
  end

  def by_partial(section, map)
    digit = section.scan(/\d/).join('')
    temp = nil
    MAPPED_PARTIAL_NAMES.each_pair do |k, v|
      temp = map["#{v} #{digit}"] if section.downcase.include?(k)
      break if temp
    end
    temp
  end

end
