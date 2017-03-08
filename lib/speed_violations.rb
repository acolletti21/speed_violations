require "speed_violations/version"
require 'unirest'

module SpeedViolations
  class Violation
    def initialize(hash)
      @address = hash["address"],
      @camera_id = hash["camera_id"],
      @violation_date = hash["violation_date"],
      @violation_count = hash["violations"]
    end

    def self.all
      violations_array = Unirest.get("https://data.cityofchicago.org/resource/3v4z-xnbf.json?$limit=100").body
      return_hashes_as_objects(violations_array)
    end

    def self.search(search_term)
      violations_array = Unirest.get("https://data.cityofchicago.org/resource/3v4z-xnbf.json?$q=#{search_term}").body
      return_hashes_as_objects(violations_array)
    end

    private
      def self.return_hashes_as_objects(array_of_hashes)
        violations = []
        array_of_hashes.each do |violations_hash|
          violations << Violation.new(violations_hash)
        end
      violations
    end

  end
end







