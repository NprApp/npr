# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

RecordType.find_or_create name: "Bleeding", code: "bleeding"
RecordType.find_or_create name: "Fertile", code: "fertile"
RecordType.find_or_create name: "Infertile", code: "infertile"

MucusType.find_or_create symbol: "10KL" do |type|
  type.fertile = true
  type.peak_type = true
end
MucusType.find_or_create symbol: "8KL" do |type|
  type.fertile = true
  type.peak_type = true
end
