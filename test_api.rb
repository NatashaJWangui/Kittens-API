require 'rest-client'
require 'json'

BASE_URL = 'http://localhost:3000'

puts "🐱 Testing NJW Kittens API"
puts "=" * 40

# Test 1: Get all kittens
puts "\n📋 Testing GET /kittens"
begin
  response = RestClient.get("#{BASE_URL}/kittens", accept: :json)
  kittens = JSON.parse(response.body)
  puts "✅ Success! Found #{kittens.length} kittens"
  puts "📄 Sample kitten: #{kittens.first['name']}" if kittens.any?
rescue => e
  puts "❌ Error: #{e.message}"
end

# Test 2: Get specific kitten
puts "\n🐾 Testing GET /kittens/1"
begin
  response = RestClient.get("#{BASE_URL}/kittens/1", accept: :json)
  kitten = JSON.parse(response.body)
  puts "✅ Success! Kitten: #{kitten['name']}"
  puts "📊 Stats: #{kitten['cuteness']}/10 cute, #{kitten['softness']}/10 soft"
rescue => e
  puts "❌ Error: #{e.message}"
end

# Test 3: Test content negotiation
puts "\n🔄 Testing Content Negotiation"
begin
  html_response = RestClient.get("#{BASE_URL}/kittens")
  json_response = RestClient.get("#{BASE_URL}/kittens", accept: :json)

  puts "✅ HTML response: #{html_response.headers[:content_type]}"
  puts "✅ JSON response: #{json_response.headers[:content_type]}"
rescue => e
  puts "❌ Error: #{e.message}"
end

# Test 4: Error handling (invalid ID)
puts "\n⚠️  Testing Error Handling"
begin
  response = RestClient.get("#{BASE_URL}/kittens/999999", accept: :json)
  puts "❌ Should have failed!"
rescue RestClient::ExceptionWithResponse => e
  puts "✅ Correctly handled error: #{e.response.code}"
end

puts "\n🎉 API testing complete!"
