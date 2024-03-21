using CSV, DataFrames, DataFramesMeta

dir = "C:/2020CERMyrtle/"

# vENPN ===============================

filename = "vENPN.dat"
floc = joinpath(dir, "InputData", "vData_OilRefinery", filename)
floc = joinpath(dir, "InputData", "vData", filename)
df = CSV.read(floc, DataFrame; delim=';')
@subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
  "Year" => unique(df.Year),
  "Area" => unique(df.Area),
  "Fuel" => ["Hydrogen"],
  "Units" => raw"Real 2019 CN$/mmBtu",
  "Data" => 20.0
)

out = vcat(df, add)

add = @subset df :Fuel .== "Heavy Crude Oil"
add.Fuel .= "Biodiesel"
out = vcat(df, add)

add = @subset df :Fuel .== "Light Crude Oil"
add.Fuel .= "Ethanol"
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
  "Fuel" => ["Hydrogen"],
  "Sector" => unique(df.Sector),
  "Units" => raw"Real 2019 CN$/mmBtu",
  "Data" => 0.0
)
out = vcat(df, add)

add = @subset df :Fuel .== "Gasoline"
add.Fuel .= "Ethanol"
out = vcat(df, add)

add = @subset df :Fuel .== "Light Fuel Oil"
add.Fuel .= "Biodiesel"
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
  "Fuel" => ["Hydrogen"],
  "Sector" => unique(df.Sector),
  "Units" => raw"CN$/CN$",
  "Data" => 0.0
)
out = vcat(df, add)

add = @subset df :Fuel .== "Gasoline"
add.Fuel .= "Ethanol"
out = vcat(df, add)

add = @subset df :Fuel .== "Light Fuel Oil"
add.Fuel .= "Biodiesel"
out = vcat(df, add)

out = @orderby(out, :Year, :Area, :Fuel, :Sector)
CSV.write(floc, out; delim=';')

# vFPF ==========================

# filename = "vFPF.dat"
# floc = joinpath(dir, "InputData", "vData", filename)
# df = CSV.read(floc, DataFrame; delim=';')
# @subset! df :Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"])

# add = allcombinations(DataFrame, "Variable" => unique(df.Variable),
#   "Year" => unique([df.Year; 2020:2030]),
#   "Area" => unique(df.Area),
#   "Fuel" => ["Hydrogen"],
#   "Sector" => unique(df.Sector),
#   "Units" => raw"CN$/CN$",
#   "Data" => 0.0
# )
# out = vcat(df, add)

# add = @subset df :Fuel .== "Gasoline"
# add.Fuel .= "Ethanol"
# out = vcat(df, add)

# add = @subset df :Fuel .== "Light Fuel Oil"
# add.Fuel .= "Biodiesel"
# out = vcat(df, add)

# out = @orderby(out, :Year, :Area, :Fuel, :Sector)
# CSV.write(floc, out; delim=';')

sum(df.Fuel .∉ Ref(["Hydrogen", "Ethanol", "Biodiesel"]))
