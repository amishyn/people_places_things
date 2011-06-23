module PeoplePlacesThings
  class State
    class UnsupportedFormat < StandardError; end
    
    attr_accessor :sym, :raw
  
    def initialize(str)
      self.raw = str
      token = str.strip.downcase
    
      if FORWARD.has_key?(token.to_sym)
        self.sym = token.to_sym
      elsif REVERSE.has_key?(token)
        self.sym = REVERSE[token]
      end
    
      raise UnsupportedFormat if !self.sym
    end
  
    def to_s(fmt = :full)
      raise UnsupportedFormat if !OUTPUT_FORMATS.include?(fmt)
      fmt == :full ? FORWARD[self.sym].capitalize : self.sym.to_s.upcase
    end
  
    OUTPUT_FORMATS = [:abbr, :full]
  
    private

    FORWARD = {
      :al => "alabama",
    	:ak => "alaska",
    	:az => "arizona",
    	:ar => "arkansas",
    	:ca => "california",
    	:co => "colorado",
    	:ct => "connecticut",
    	:de => "delaware",
    	:dc => "district of columbia",
    	:fl => "florida",
    	:ga => "georgia",
    	:hi => "hawaii",
    	:id => "idaho",
    	:il => "illinois",
    	:in => "indiana",
    	:ia => "iowa",
    	:ks => "kansas",
    	:ky => "kentucky",
    	:la => "louisiana",
    	:me => "maine",
    	:md => "maryland",
    	:ma => "massachusetts",
    	:mi => "michigan",
    	:mn => "minnesota",
    	:ms => "mississippi",
    	:mo => "missouri",
    	:mt => "montana",
    	:ne => "nebraska",
    	:nv => "nevada",
    	:nh => "new hampshire",
    	:nj => "new jersey",
    	:nm => "new mexico",
    	:ny => "new york",
    	:nc => "north carolina",
    	:nd => "north dakota",
    	:oh => "ohio",
    	:ok => "oklahoma",
    	:or => "oregon",
    	:pa => "pennsylvania",
    	:ri => "Rhode island",
    	:sc => "south carolina",
    	:sd => "south dakota",
    	:tn => "tennessee",
    	:tx => "texas",
    	:ut => "utah",
    	:vt => "vermont",
    	:va => "virginia",
    	:wa => "washington",
    	:wv => "west virginia",
    	:wi => "wisconsin",
    	:wy => "wyoming",
  	}
	
  	REVERSE = FORWARD.inject({}) {|r, f| r[f[1]] = f[0]; r}
  end
end