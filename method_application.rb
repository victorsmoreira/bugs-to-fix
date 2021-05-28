# frozen_string_literal: true

require 'json'
require_relative './app/bugs_to_fix'

# Load JSON file with bug records
input_bugs = File.read('./resources/bugs.json')
bugs_array = (JSON.parse(input_bugs))['Bugs']

# Method application
selected_bugs = bugs_to_fix(bugs_array)

puts 'Urgent bugs ID (dued) (!!!):'
print_bugs_id(selected_bugs, :expired)
puts "\nID of bugs to fix today:"
print_bugs_id(selected_bugs, :fix_today)
