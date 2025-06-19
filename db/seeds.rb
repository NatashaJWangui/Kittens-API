# Clear existing data
Kitten.destroy_all

# Create adorable sample kittens with photos
kittens = Kitten.create!([
  {
    name: "Mr. Whiskers",
    age: 8,
    cuteness: 9,
    softness: 8,
    image_url: "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
  },
  {
    name: "Princess Fluffy",
    age: 4,
    cuteness: 10,
    softness: 10,
    image_url: "https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
  },
  {
    name: "Shadow",
    age: 12,
    cuteness: 7,
    softness: 6,
    image_url: "https://images.unsplash.com/photo-1506755855567-92ff770e8d00?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 },
 {
   name: "Mittens",
   age: 6,
   cuteness: 8,
   softness: 9,
   image_url: "https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 },
 {
   name: "Sir Pounce-a-lot",
   age: 10,
   cuteness: 8,
   softness: 7,
   image_url: "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 },
 {
   name: "Luna",
   age: 3,
   cuteness: 9,
   softness: 8,
   image_url: "https://images.unsplash.com/photo-1561948955-570b270e7c36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 },
 {
   name: "Ginger",
   age: 15,
   cuteness: 7,
   softness: 5,
   image_url: "https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 },
 {
   name: "Snowball",
   age: 2,
   cuteness: 10,
   softness: 10,
   image_url: "https://images.unsplash.com/photo-1548247416-ec66f4900b2e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80"
 }
])

puts "Created #{Kitten.count} adorable kittens with photos!"
kittens.each do |kitten|
 puts "- #{kitten.name}: #{kitten.age} months old, #{kitten.cuteness_level}, #{kitten.softness_level}"
end
