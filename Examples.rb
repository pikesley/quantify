## Example ##

unit = Unit.km                                               #=> #<Quantify::Unit::SI:0xb75c9718 ... >
unit.name                                                    #=> :kilometre
unit.symbol                                                  #=> :kg
unit.dimensions                                              #=> #<Quantify::Dimensions:0xb75c4254 .. >
unit.measures                                                #=> :length
unit.alternatives :name                                      #=> [:metre, :megametre, :gigametre, :terametre, :angstrom,
                                                             #    :astronomical_unit, :baromil, :chain, :dram, :ell, :fathom,
                                                             #    :fermi, :foot_us_survey, :foot, :furlong, :hand, :inch,
                                                             #    :nautical_league, :statute_league, :light_year, :line,
                                                             #    :link, :yard]
other_unit = Unit.hour
other_unit.name                                              #=> :hour
other_unit.symbol                                            #=> :h
other_unit.measures                                          #=> :time
other_unit.alternatives :symbol                              #=> [ :s, :ks, :Ms, :Gs, :Ts, :d, :min ]

another_unit = unit / other_unit                             #=> #<Quantify::Unit::Compound:0xb74af323 ... >
another_unit.name                                            #=> :kilometer_per_hour
another_unit.symbol                                          #=> :km_h^-1
another_unit.measures                                        #=> :veolcity

last_unit = Unit.m
last.unit.measures                                           #=> :length
square = last_unit ** 2                                      #=> #<Quantify::Unit::Compound:0xb446f12f ... >
square.symbol                                                #=> :m^2
square.measures                                              #=> :area

----

# Define quantity - method 1
quantity = Quantity.new(1234.5678, :lb)                      #=> #<Quantify::Quantity:0xjk39d570 ... >
quantity.value                                               #=> 1234.5678
quantity.unit                                                #=> #<Quantify::Unit::NonSI:0xb182124 ... >
quantity.unit.symbol                                         #=> :lb

# Define quantity - method 2
string = quantity.to_s                                       #=> "1234.5678 lb"
quantity = Quantity.parse(string)                            #=> #<Quantify::Quantity:0xj982b4f9 ... >
quantity.to_s                                                #=> "1234.5678 lb"

# Define quantity - method 3
quantity = 1234.5678.lb                                      #=> #<Quantify::Quantity:02387f7340 ... >
quantity.to_s                                                #=> "1234.5678 lb"

# Multiply by scalar
new_quantity = quantity * 4                                  #=> #<Quantify::Quantity:87b37f720 ... >
new_quantity.to_s                                            #=> "4938.2712 lb"

# Convert unit
converted_quantity = new_quantity.to_kg                      #=> #<Quantify::Quantity:0b8787a688 ... >
converted_quantity.to_s                                      #=> "2239.96213731074 kg"

----

# Example application

# Define energy units
kW = Unit.kW                                                 #=> #<Quantify::Unit::SI:0xb7586620 ... >
kW.name                                                      #=> :kilowatt
kW.measures                                                  #=> :power

h = Unit.h                                                   #=> #<Quantify::Unit::NonSI:0xb7582994 ... >
h.symbol                                                     #=> :h
h.measures                                                   #=> :time

# Create compound unit for energy
kWh = kW / h                                                 #=> #<Quantify::Unit::Compound:0xb756b0b4 ... >
kWh.name                                                     #=> :kilowatt_hour
kWh.measures                                                 #=> :energy
kWh.alternatives :symbol                                     #=> [:J, :kJ, :MJ, :GJ, :TJ, :BTU, :cal, :CHU,
                                                             #    :"dyn cm", :eV, :erg, :Eh]
kWh.alternative :name                                        #=> [:joule, :kilojoule, :megajoule, :gigajoule,
                                                             #    :terajoule, :british_thermal_unit, :calorie,
                                                             #    :celsius_heat_unit, :dyne_centimetre, :electron_volt,
                                                             #    :erg, :hartree]

# Create mass unit
kg = Unit.kg                                                 #=> #<Quantify::Unit::SI:0xb758b594 ... >

# Create emission factor compound unit
kg_per_kWh = kg / kWh                                        #=> #<Quantify::Unit::Compound:0xb746f093 ... >
kg_per_kWh.symbol                                            #=> :"kg_kW^-1_h^-1"
kg_per_kWh.name                                              #=> :kilogram_per_kilowatt_hour

# Create emission factor quantity
emission_factor = Quantity.new(0.54, kg_per_kWh)             #=> #<Quantify::Quantity:0xb75cd570 ... >
emission_factor.to_s                                         #=> "0.54 kg kW^-1 h^-1"

# Create consumption quantity
consumption = Quantity.new(9885.5, kWh)                      #=> #<Quantify::Quantity:0xb7j4k3570 ... >
consumption.to_s                                             #=> "9885.5 kW_h"

# Calculate emissions
emissions = consumption * emission_factor                    #=> #<Quantify::Quantity:0xb456g2s70 ... >
emissions.to_s                                               #=> "5338.17 kg"
