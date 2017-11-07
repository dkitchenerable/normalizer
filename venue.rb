require_relative 'section'
require_relative 'baseball_validator'
require 'csv'

class Venue
  IngestionError = Class.new(StandardError)

  def initialize(validator_type=BaseballValidator)
    @section_map = {}
    @validator = BaseballValidator.new
  end

  def create_from_file(csv_path)
    begin
      CSV.foreach(csv_path, headers: true) do |row|
        ingest_row(row)
      end
    rescue StandardError => e
      raise IngestionError.new("CSV Issue: #{e.message}")
    end
  end

  def get_normalized(section, row)
    valid_section = @validator.get_valid_section(section, section_map)
    row_id = @validator.get_valid_row(valid_section, row)
    if valid_section && row_id
      return [valid_section.id, row_id, "true"]
    else
      return [nil, nil, false]
    end
  end

  private

  attr_reader :section_map

  def ingest_row(row)
    section = section_map[row["section_name"]]
    section_id = row["section_id"]
    section = Section.new(row["section_id"]) if !section
    section.add_row(row["row_id"], row["row_name"])
    section_map[row["section_name"]] = section
  end
end
