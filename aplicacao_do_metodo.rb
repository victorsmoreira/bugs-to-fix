# frozen_string_literal: true

require 'json'
require_relative './app/bugs_resolver_hoje'

# Carregar arquivo JSON com extração de bugs do banco
input_bugs = File.read('./resources/extração_bugs.json')
bugs_array = (JSON.parse(input_bugs))['Bugs']

# Utilização do método de priorização
bugs_priorizados = bugs_resolver_hoje(bugs_array)

# Impressão dos resultados no console
puts 'Bugs com prazo vencido (!!!):'
bugs_priorizados['vencidos'].each do |b|
  puts ">>> #{b}"
end

puts "\nBugs com prazo vencendo hoje:"
bugs_priorizados['para_hoje'].each do |b|
  puts ">>> #{b}"
end
