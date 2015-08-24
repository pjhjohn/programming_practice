# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def encrypt(message)
  require 'digest'
  sha256 = Digest::SHA256.new
  digest = sha256.base64digest message
  return digest
end
def date_of(ms)
  return DateTime.strptime((ms.to_f/1000).to_s, '%s')
end

User.new(username: 'admin', password: encrypt('admin'), is_admin: true).save
User.new(username: '박준호', password: encrypt('wnsgh00')).save
User.new(username: 'shpark', password: encrypt('1234'), is_admin: true).save
Post.new(user_id: 1, title: "SEED공지", body: "공지내용", is_announcement: true).save
Post.new(user_id: 2, title: "SEED글", body: "내용이내용내용하군요!").save
event = Event.new(title: "수강신청 변경기간", klass: "event-important", start: date_of(1441033200000), finish: date_of(1441616400000))
event.save
event.url = "#{event.url}/#{event.id}"
event.save
event = Event.new(title: "2학기 개강", klass: "event-important", start: date_of(1441033200000), finish: date_of(1441119600000))
event.save
event.url = "#{event.url}/#{event.id}"
event.save