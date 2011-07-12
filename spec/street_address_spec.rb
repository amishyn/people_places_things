require 'spec/helper'

describe StreetAddress do

  it "should parse blank" do
    addr = StreetAddress.new ""
    addr.number.should == nil
    addr.name.should == nil
    addr.to_s.should == ""
  end

  it "should parse number street" do
    addr = StreetAddress.new "123 Main Street"
    addr.number.should == '123'
    addr.name.should == 'Main'
    addr.suffix.should == :street
  end
  
  it "should parse number street even with 1/2" do
    addr = StreetAddress.new "123 1/2 Main Street"
    addr.number.should == '123'
    addr.name.should == 'Main'
    addr.suffix.should == :street
  end
  
  it "should parse number with letter" do
    addr = StreetAddress.new "204-B Main Street"
    addr.number.should == '204-B'
    addr.name.should == 'Main'
    addr.suffix.should == :street
  end
  
  it "should parse pre direction" do 
    addr = StreetAddress.new "123 E Main Street"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'Main'
    addr.suffix.should == :street
  end

  it "should parse post direction" do 
    addr = StreetAddress.new "123 Main Street NE"
    addr.number.should == '123'
    addr.name.should == 'Main'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
  end
  
  it "should parse pre and post direction" do 
    addr = StreetAddress.new "123 E Main Street North"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'Main'
    addr.suffix.should == :street
    addr.post_direction.should == :north
  end
  
  it "should parse street names that look like directions" do 
    addr = StreetAddress.new "123 E E St"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
  end

  it "should parse street names that look like directions, with post directions" do 
    addr = StreetAddress.new "123 E E St NE"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
  end
  
  it "should parse abbreviations" do 
    addr = StreetAddress.new "123 e. 1st ave"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'first'
    addr.suffix.should == :avenue
  end
  
  it "should parse suites" do
    addr = StreetAddress.new "123 E E St NE Ste 23"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
    addr.unit_type.should == :suite
    addr.unit.should == '23'
  end

  it "should parse apartments" do
    addr = StreetAddress.new "123 E E St NE Apartment 4"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
    addr.unit_type.should == :apartment
    addr.unit.should == '4'
  end
  
  it "should parse numbers" do
    addr = StreetAddress.new '123 E E St NE # 5'
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
    addr.unit_type.should == :number
    addr.unit.should == '5'
  end
  
  it "should parse numbers without spaces" do
    addr = StreetAddress.new '123 E E St NE #5'
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
    addr.unit_type.should == :number
    addr.unit.should == '5'
  end
  
  it "should parse no number" do 
    addr = StreetAddress.new "Westside Highway"
    addr.number.should == nil
    addr.name.should == 'Westside'
    addr.suffix.should == :highway
  end

  it "should parse directional street with suffix" do 
    addr = StreetAddress.new "12 north avenue"
    addr.number.should == '12'
    addr.name.should == 'north'
    addr.suffix.should == :avenue
  end
  
  it "should parse directional street without suffix" do 
    addr = StreetAddress.new "12 north"
    addr.number.should == '12'
    addr.name.should == 'north'
  end

  it "should parse directional street with postdir" do 
    addr = StreetAddress.new "12 north w"
    addr.number.should == '12'
    addr.name.should == 'north'
    addr.post_direction.should == :west
  end
  
  it "should parse directional street with postdir and unit" do 
    addr = StreetAddress.new "12 n sw apt. 2"
    addr.number.should == '12'
    addr.name.should == 'n'
    addr.post_direction.should == :southwest
    addr.unit_type.should == :apartment
    addr.unit.should == '2'
  end
  
  it "should handle commas" do
    addr = StreetAddress.new "123 E E St NE, suite 23"
    addr.number.should == '123'
    addr.pre_direction.should == :east
    addr.name.should == 'E'
    addr.suffix.should == :street
    addr.post_direction.should == :northeast
    addr.unit_type.should == :suite
    addr.unit.should == '23'
  end
  
  it 'should hadle numbers without space' do
    addr = StreetAddress.new "845 Market St, #Fe6"
    addr.number.should == '845'
    addr.name.should == 'Market'
    addr.suffix.should == :street
    addr.unit_type.should == :number
    addr.unit.should == 'Fe6'
  end
  
  it "should support long form" do
    StreetAddress.string_for(:northwest, :long).should == 'northwest'
  end
  
  it "should support short form" do
    StreetAddress.string_for(:road, :short).should == 'rd'
  end
  
  it "should support short form when none exists" do
    StreetAddress.string_for(:oaks, :short).should == StreetAddress.string_for(:oaks, :long)
  end
  
  it "should save raw" do
    StreetAddress.new('123 Main st.').raw.should == '123 Main st.'
  end
  
  it 'should process ordinal numbers' do
    s = StreetAddress.new('747 3rd st.')
    s.to_s.should == "747 third street"
    s.name.should == "third"
  end

  it 'should process ordinal numbers' do
    StreetAddress.new('747 20th st.').to_s.should == "747 twentieth street"
  end

  it 'should process ordinal numbers' do
    StreetAddress.new('747 123rd st.').to_s.should == "747 one hundred and twenty-third street"
  end

  
end
