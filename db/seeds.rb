# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seeds = YAML.load(File.read('./db/seeds.yml'))
seeds[:record_types].each do |type|
  record_type = RecordType.find_or_create code: type[:code] do |record|
    record.name = type[:name]
  end
  record_type.name = type[:name]
  record_type.save
end
seeds[:mucus_types].each do |type|
  mucus_type = MucusType.find_or_create symbol: type[:symbol] do |record|
    record.fertile = type[:fertile]
    record.peak_type = type[:peak_type]
  end
  mucus_type.fertile = type[:fertile]
  mucus_type.peak_type = type[:peak_type]
  mucus_type.save
end
