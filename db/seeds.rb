# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
class Seed

  def initialize
    create_users
  end

  def create_users
    10.times do |n|
      user = User.create!(name: Faker::Name.name, image: Faker::Avatar.image)
      10.times do
        skill = user.skills.create(nickname: Faker::Hacker.adjective)
        goal = skill.goals.create(skill: skill, num_sessions: rand(1..5), session_length: 30)
        3.times do
          skill.sessions.create(duration: 30)
        end
      end
    end
  end

end

Seed.new
