require_relative 'venue'

class Normalizer
    def initialize
      @venue = Venue.new
    end

    ## reads a manifest file
    # manifest should be a CSV containing the following columns
    #     * section_id
    #     * section_name
    #     * row_id
    #     * row_name

    # Arguments:
    #     manifest {[str]} -- /path/to/manifest
    def read_manifest(path_to_manifest)
      @venue.create_from_file(path_to_manifest)
    end


    ## normalize a single (section, row) input
    # Given a (Section, Row) input, returns (section_id, row_id, valid)
    # where
    #     section_id = int or None
    #     row_id = int or None
    #     valid = True or False

    # Arguments:
    #     section {[type]} -- [description]
    #     row {[type]} -- [description]
    def normalize(section, row)
      normalized = @venue.get_normalized(section, row)
      return normalized
    end
end
