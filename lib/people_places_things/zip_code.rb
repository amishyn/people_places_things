module PeoplePlacesThings
  class ZipCode
    class UnsupportedFormat < StandardError; end
    
    attr_accessor :base, :plus_four, :raw
  
    def initialize(str)
      self.raw = str
      tokens = str.strip.match(/^(\d{5})(-\d{4})?$/)[0].split('-') rescue nil
      raise UnsupportedFormat if !tokens

      self.base = tokens.first
      self.plus_four = tokens[1] rescue nil
    end
  
    def to_s
      [self.base, self.plus_four].compact.join('-')
    end
  end
end