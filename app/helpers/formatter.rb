CITIES = {
  LA: 'Los Angeles',
  NYC: 'New York City'
}.freeze

def format_city(city)
  CITIES[city.to_sym]
end

def format_birthdate(date)
  DateTime.parse(date).strftime("%-m/%-d/%Y")
end
