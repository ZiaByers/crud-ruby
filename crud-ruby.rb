require 'httparty'
require 'pry'

BASE_URL = 'http://json-server.devpointlabs.com/api/v1'

def print_user(user)
  puts "id: #{user['id']}"
  puts "First Name: #{user['first_name']}"
  puts "Last Name: #{user['last_name']}"
  puts "Phone Number: #{user['phone_number']}"
  puts ''
end

def all_users
  users = HTTParty.get("#{BASE_URL}/users")

  users.each do |user|
    print_user(user)
  end
end

def single_user
  puts "Enter desired ID"
  id = gets.to_i

  user = HTTParty.get("#{BASE_URL}/users/#{id}")

  error_message = user.parsed_response["message"]

  if error_message
    puts error_message
  else
    print_user(user)
  end

end

def create_user
  puts "Enter First Name"
  first_name = gets.strip

  puts "Enter Last Name"
  last_name = gets.strip

  puts "Enter Phone Number"

  phone_number = gets.strip

  user = {
    first_name: first_name,
    last_name: last_name,
    phone_number: phone_number
  }

  response = HTTParty.post("#{BASE_URL}/users", body: user)

  puts response
end

while true
  puts """
  1. List all users
  2. Find user by id
  3. Create new user
  4. Update user by id
  5. Delete user by id
  6. Quit
  """
  input = gets.strip.to_i

  case input
    when 1
      all_users
    when 2
      single_user
    when 3
      create_user
    when 4
      puts "Haven't made this method yet"
    when 5
      puts "Haven't made this method yet"
    when 6
      puts "See ya"
      exit 0
    else
      puts "Invalid input, try again."
  end
end
