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

#puts "__Add role"
#Role.create name: 'Client' if Role.find_by_name('Client').nil?
#Role.create name: 'Admin' if Role.find_by_name('Admin').nil?

#puts "__Add user"
#User.create fio: "Иванов Иван Иванович", email: "i.ivaniv@hotmail.com", phone: '8-804-578-34-54', role_id: Role.find_by_name('Client').id, login: 'Ivanov', password: "1" if User.find_by_fio("Иванов Иван Иванович").nil?
#User.create fio: "Администратор", email: "i.ivaniv@hotmail.com", phone: '8-864-344-34-51', role_id: Role.find_by_name('Admin').id, login: 'admin', password: "2" if User.find_by_fio("Администратор").nil?

