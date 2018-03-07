# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Movement.create(name: "run")
Movement.create(name: "row")
Movement.create(name: "squat")
Movement.create(name: "bench")
Movement.create(name: "deadlift")
Movement.create(name: "clean and jerk")
Movement.create(name: "snatch")

Athlete.create(name: "Sam Strong")
Athlete.create(name: "Wally Wobbles")
Athlete.create(name: "Junior Jumps")
Athlete.create(name: "Peter Power")
