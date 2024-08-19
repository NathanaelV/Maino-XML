user = User.create!(first_name: 'ikki', last_name: 'Phoenix', email: 'ikki.phoenix@saintseiya.com',
                    password: 'phoenix123')

puts "Usuário #{user.first_name} #{user.last_name} criado."
