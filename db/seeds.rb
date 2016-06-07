# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "__Add options"

Propert.create code: 'name_site', name: 'Name this site', value: 'Parking' if Propert.find_by_code('name_site').nil?
Propert.create code: 'name_company', name: 'Company name', value: 'RIO inc.' if Propert.find_by_code('name_company').nil?
Propert.create code: 'host_name', name: 'host', value: 'localhost' if Propert.find_by_code('host_name').nil?
Propert.create code: 'port_namber', name: 'port', value: '3000' if Propert.find_by_code('port_namber').nil?

puts "__Add type parking"
TypeParking.create Name:'Открытая площадка' if TypeParking.find_by_Name('Открытая площадка').nil?
TypeParking.create Name:'Капитальный гараж' if TypeParking.find_by_Name('Капитальный гараж').nil?
TypeParking.create Name:'Огороженная парковка' if TypeParking.find_by_Name('Огороженная парковка').nil?

puts "__Add area"
Area.create name:'Омская область' if Area.find_by_name('Омская область').nil?

puts "__Add sity & town"
CityTown.create name:'Омск', area_id: Area.find_by_name('Омская область').id if CityTown.find_by_name('Омск').nil?
CityTown.create name:'Тарский р-н', area_id: Area.find_by_name('Омская область').id if CityTown.find_by_name('Тарский р-н').nil?

puts "__Add district"
District.create name: 'Кировский район', city_town_id: CityTown.find_by_name('Омск').id if District.find_by_name('Кировский район').nil?
District.create name: 'Совецкий район', city_town_id: CityTown.find_by_name('Омск').id if District.find_by_name('Совецкий район').nil?
District.create name: 'г.Тара', city_town_id: CityTown.find_by_name('Тарский р-н').id if District.find_by_name('г.Тара').nil?

puts "__Add period"
Period.create name: 'На длительный срок' if Period.find_by_name('На длительный срок').nil?
Period.create name: 'Посуточно' if Period.find_by_name('Посуточно').nil?

puts "__Add role"
Role.create name: 'Client' if Role.find_by_name('Client').nil?
Role.create name: 'Admin' if Role.find_by_name('Admin').nil?

puts "__Add user"
#User.create fio: "Иванов Иван Иванович", email: "i.ivaniv@hotmail.com", phone: '8-804-578-34-54', role_id: Role.find_by_name('Client').id, login: 'Ivanov', password: "1" if User.find_by_fio("Иванов Иван Иванович").nil?
#User.create fio: "Администратор", email: "i.ivaniv@hotmail.com", phone: '8-864-344-34-51', role_id: Role.find_by_name('Admin').id, login: 'admin', password: "2" if User.find_by_fio("Администратор").nil?