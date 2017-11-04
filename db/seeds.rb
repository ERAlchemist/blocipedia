#require 'random_data'
require 'faker'

10.times do 
    user= User.new(
        email: Faker::Internet.email,
        password: "password",
        role: "standard"
        )
    user.save!
end

users = User.all
2.times do
    users.each do |user|
        Wiki.create!(
            title: Faker::Hipster.sentence,
            body: Faker::Hipster.paragraph,
            private: false,
            user: user
            )
    end
end

def norris_fake_paragraph
    paragraph = ""
    5.times do
        paragraph += Faker::ChuckNorris.fact
    end
    paragraph
end

2.times do
    users.each do |user|
        Wiki.create!(
            title: Faker::ChuckNorris.fact,
            body: norris_fake_paragraph,
            private: false,
            user: user
            )
    end
end


wikis = Wiki.all

puts "Seed finished"
puts "#{users.count} users created"
puts "#{wikis.count} wikis created"