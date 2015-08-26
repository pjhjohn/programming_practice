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
def date_of_ms(ms)
  return DateTime.strptime((ms.to_f/1000).to_s, '%s')
end
def date_of(text)
  return DateTime.strptime(text+"+0900", '%Y%m%d%H%M%S%z')
end
def new_event(title, klass, start, finish)
  body=nil
  event = Event.new(title: title, body: body, klass: klass, start: date_of(start), finish: date_of(finish))
  event.save
  event.url = "#{event.url}/#{event.id}"
  event.save
end

# MASTER
User.new(username: 'admin', password: encrypt('admin'), is_admin: true).save

# ADMIN
User.new(username: '박준호', password: encrypt('wnsgh00')).save
User.new(username: 'shpark', password: encrypt('1234'), is_admin: true).save

# SEED POST
Post.new(user_id: 1, title: "SEED공지", body: "공지내용", is_announcement: true).save
Post.new(user_id: 2, title: "SEED글", body: "내용이내용내용하군요!").save

# SCHDEULES
new_event( "Course Intro", "event-important", "20150901160000", "20150901175000" )
new_event( "Overview (chap 1)", "event-important", "20150908160000", "20150908175000" )
new_event( "Lexical Elements, Operators, and the C system (chap 2)", "event-important", "20150915160000", "20150915175000" )
new_event( "Fundamental Data Types (chap 3)", "event-important", "20150922160000", "20150922175000" )
new_event( "No class (추석)", "event-important", "20150929160000", "20150929175000" )
new_event( "Flow of Control (chap 4)", "event-important", "20151006160000", "20151006175000" )
new_event( "Functions (chap 5)", "event-important", "20151013160000", "20151013175000" )
new_event( "Arrays, Pointers, and Strings (chap 6)", "event-important", "20151020160000", "20151020175000" )
new_event( "Bitwise Operators and Enumeration Types (chap 7), Preprocessor (chap 8)", "event-important", "20151027160000", "20151027175000" )
new_event( "No class (출장)", "event-important", "20151103160000", "20151103175000" )
new_event( "Structures and Unions (chap 9)", "event-important", "20151110160000", "20151110175000" )
new_event( "Function Pointers and Table Lookup (chap 9)", "event-important", "20151117160000", "20151117175000" )
new_event( "Structures and List Processing (chap 10)", "event-important", "20151124160000", "20151124175000" )
new_event( "Input/Output and the Operating System (chap 11)", "event-important", "20151201160000", "20151201175000" )
new_event( "Moving from C to C++ (chap 12)", "event-important", "20151208160000", "20151208175000" )

# PRACTICE
new_event( "Linux 계정 만들기, cloud 설명 (아주 간단한 프로그램을 작성하고 compile)", "event-warning", "20150903160000", "20150903175000" )
new_event( "Unix, Linux, C Shell (Compiler, Text Editor, IO redirection)", "event-warning", "20150910160000", "20150910175000" )

(1..100).each do |i|
  Post.new(user_id: 3, title: "Title##{i}", body: "Body##{i}").save
end