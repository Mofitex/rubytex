# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Restaurant.delete_all
Comment.delete_all

user1 = User.create(email: "Mofitex16@gmail.com", password:"12345aA",username: "Mofitex", admin: true)
user2 = User.create(email: "testmail@gmail.com", password:"12345aA",username: "Deki", admin: true)
user3 = User.create(email: "testmail2@gmail.com", password:"1234",username: "PlebUser", admin: false)

rest1 = Restaurant.create(title: "mofitex's pizzas", description: nil, user: user1, address: "calle 1", telephone: 610210293)
rest2 = Restaurant.create(title: "Deki's pizzas", description: nil, user: user2, address: "calle 2", telephone: 693583094)
rest3 = Restaurant.create(title: "qwerty's pizzas", description: nil, user: user3, address: "calle 3", telephone: 602893492)

Comment.create(title: "basura de pizzas", text:"la peor pizza que he probado...", score: 0, user: user1, restaurant: rest1)
Comment.create(title: "asdf", text:"no esta mal, le falta sal", score: 9, user: user2, restaurant: rest2)
Comment.create(title: "la mejor pizza :D", text:"best pizza EUW", score: 10, user: user3, restaurant: rest3)
