require_relative 'section'
require 'byebug'
class Venue
  #class IngestionError { StandardError.new() }

  def initialize(rule_type='')
    @seat_map = {} # section_name => section_object
  end

  def create_from_file(csv_path)
    begin
      CSV.foreach(csv_path, headers: true) do |row|
        ingest_row(row)
      end
    rescue CSV::MalformedCSVError => e
      raise IngestionError.new("CSV Issue: #{e.message}")
    end
  end

  def get_normalized(section, row)
    venue_section = fetch_section(section)
    if venue_section && venue_section.valid_row?(row)
      return [venue_section.id, venue_section.get_row(row), true]
    else
      return [nil, nil, false]
    end
  end

  private

  def fetch_section(section)
    digit = section.scan(/\d/).join('')
    venue_section ||= ( @seat_map[digit] || @seat_map[section] )
    venue_section
  end

  def ingest_row(row)
    section = @seat_map[row["section_name"]]
    section_id = row["section_id"]
    section = Section.new(row["section_id"]) if !section
    section.add_row(row["row_id"], row["row_name"])
    @seat_map[row["section_name"]] = section
  end
end
