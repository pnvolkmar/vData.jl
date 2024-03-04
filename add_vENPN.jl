using CSV, DataFrames, DataFramesMeta

dir = "C:/2020CERMyrtle/"

# vENPN ===============================

filename = "vENPN.dat"
floc = joinpath(dir, "InputData", "vData", filename)
df = CSV.read(floc, DataFrame; delim=';')
@subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
  "Year" => unique(df.Year),
  "Area" => unique(df.Area),
  "Fuel" => ["Hydrogen", "Biodiesel", "Ethanol"],
  "Units" => raw"Real 2019 CN$/mmBtu",
  "Data" => 20.0
)
out = vcat(df, add)

out = @orderby(out, :Year, :Fuel)
CSV.write(floc, out; delim=';')

# vFPBaseF ==========================

filename = "vFPBaseF.dat"
floc = joinpath(dir, "InputData", "vData", filename)
df = CSV.read(floc, DataFrame; delim=';')
@subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
  "Year" => unique(df.Year),
  "Area" => unique(df.Area),
  "Fuel" => ["Hydrogen", "Ethanol", "Biodiesel"],
  "Sector" => unique(df.Sector),
  "Units" => raw"Real 2019 CN$/mmBtu",
  "Data" => 30.0
)
out = vcat(df, add)

out = @orderby(out, :Year, :Area, :Fuel, :Sector)
CSV.write(floc, out; delim=';')

# vFPTaxF ==========================

filename = "vFPTaxF.dat"
floc = joinpath(dir, "InputData", "vData", filename)
df = CSV.read(floc, DataFrame; delim=';')
@subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
  "Year" => unique([df.Year; 2020:2030]),
  "Area" => unique(df.Area),
  "Fuel" => ["Hydrogen", "Ethanol", "Biodiesel"],
  "Sector" => unique(df.Sector),
  "Units" => raw"Real 2019 CN$/mmBtu",
  "Data" => 2.0
)
out = vcat(df, add)

out = @orderby(out, :Year, :Area, :Fuel, :Sector)
CSV.write(floc, out; delim=';')

# vFPSMF ==========================

filename = "vFPSMF.dat"
floc = joinpath(dir, "InputData", "vData", filename)
df = CSV.read(floc, DataFrame; delim=';')
@subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
  "Year" => unique([df.Year; 2020:2030]),
  "Area" => unique(df.Area),
  "Fuel" => ["Hydrogen", "Ethanol", "Biodiesel"],
  "Sector" => unique(df.Sector),
  "Units" => raw"CN$/CN$",
  "Data" => 0.25
)
out = vcat(df, add)

out = @orderby(out, :Year, :Area, :Fuel, :Sector)
CSV.write(floc, out; delim=';')

sum(df.Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"]))
