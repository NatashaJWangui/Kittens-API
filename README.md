# NJW Kittens API 🐱

This is part of the APIs Project in The Odin Project's Ruby on Rails Curriculum. Find it at https://www.theodinproject.com

A RESTful API and web application for managing adorable kittens. Demonstrates how to build Rails applications that serve both HTML views and JSON API responses for modern web development.

## Features

- **Full CRUD Operations**: Create, read, update, and delete adorable kittens
- **Dual-Purpose Application**: Serves both HTML web interface and JSON API
- **RESTful API Design**: Clean, predictable endpoints following REST principles
- **Content Negotiation**: Same URLs serve different formats based on Accept headers
- **Image Support**: Upload and display cute kitten photos
- **Data Validation**: Comprehensive validation for all kitten attributes
- **Professional UI**: Beautiful burgundy-themed responsive interface
- **API Documentation**: Built-in documentation for developers

## Technologies Used

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **PostgreSQL**: Production-grade database
- **RESTful Architecture**: HTTP methods and status codes
- **Content Negotiation**: Accept headers for format selection
- **JSON Rendering**: Structured data responses
- **Image Integration**: URL-based photo management
- **Responsive Design**: Mobile-friendly interface

## Application Architecture

### Dual-Purpose Design
This application serves two types of clients:
1. **Human Users**: HTML views with forms and navigation
2. **API Clients**: JSON data for programmatic access

### Data Model

```ruby
# Kitten Model
class Kitten < ApplicationRecord
  # Attributes
  - name: string (2-50 characters, required)
  - age: integer (1-30 months, required)
  - cuteness: integer (1-10 scale, required)
  - softness: integer (1-10 scale, required)
  - image_url: string (valid HTTP/HTTPS URL, optional)
  
  # Methods
  - age_description: "Baby kitten", "Young kitten", etc.
  - cuteness_level: "Adorable", "Very Cute", "Extremely Cute", etc.
  - softness_level: "Soft", "Very Soft", "Fluffy", "Cloud-like!", etc.
  - display_image: Returns image URL or nil
end
```

### Database Schema

```sql
CREATE TABLE kittens (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INTEGER NOT NULL CHECK (age > 0 AND age < 30),
  cuteness INTEGER NOT NULL CHECK (cuteness >= 1 AND cuteness <= 10),
  softness INTEGER NOT NULL CHECK (softness >= 1 AND softness <= 10),
  image_url VARCHAR,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);
```

## Installation

### Prerequisites
- Ruby 3.0 or higher
- Rails 7.0 or higher
- PostgreSQL 12 or higher
- Git

### Setup
1. **Clone the repository**
   ```bash
   git clone https://github.com/NatashaJWangui/Kittens-API.git
   cd kittens-api
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Database setup**
   ```bash
   # Start PostgreSQL service
   # macOS: brew services start postgresql
   # Ubuntu: sudo service postgresql start
   
   # Create and setup database
   rails db:create
   rails db:migrate
   rails db:seed  # Creates adorable sample kittens
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Visit the application**
   - **Web Interface**: `http://localhost:3000`
   - **API Endpoint**: `http://localhost:3000/kittens.json`

## API Documentation

### Base URL
```
http://localhost:3000
```

### Content Negotiation
The same URLs serve different formats based on the `Accept` header:
- **HTML**: `Accept: text/html` (default)
- **JSON**: `Accept: application/json`

### Available Endpoints

| HTTP Method | Endpoint | Description | HTML View | JSON Response |
|-------------|----------|-------------|-----------|---------------|
| GET | `/kittens` | List all kittens | ✅ Index page | ✅ JSON array |
| GET | `/kittens/:id` | Get specific kitten | ✅ Show page | ✅ JSON object |
| GET | `/kittens/new` | New kitten form | ✅ Form page | ❌ N/A |
| POST | `/kittens` | Create new kitten | ✅ Redirect | ❌ CSRF protected |
| GET | `/kittens/:id/edit` | Edit kitten form | ✅ Form page | ❌ N/A |
| PUT/PATCH | `/kittens/:id` | Update kitten | ✅ Redirect | ❌ CSRF protected |
| DELETE | `/kittens/:id` | Delete kitten | ✅ Redirect | ❌ CSRF protected |

### Request Examples

#### Get All Kittens (JSON)
```bash
curl -H "Accept: application/json" http://localhost:3000/kittens
```

#### Get Specific Kitten (JSON)
```bash
curl -H "Accept: application/json" http://localhost:3000/kittens/1
```

### Response Format

#### Individual Kitten
```json
{
  "id": 1,
  "name": "Mr. Whiskers",
  "age": 8,
  "cuteness": 9,
  "softness": 8,
  "image_url": "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba",
  "created_at": "2024-01-15T10:30:00.000Z",
  "age_description": "Young kitten",
  "cuteness_level": "Extremely Cute",
  "softness_level": "Fluffy"
}
```

#### Kitten Collection
```json
[
  {
    "id": 1,
    "name": "Mr. Whiskers",
    "age": 8,
    "cuteness": 9,
    "softness": 8,
    "image_url": "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba",
    "age_description": "Young kitten",
    "cuteness_level": "Extremely Cute",
    "softness_level": "Fluffy"
  },
  {
    "id": 2,
    "name": "Princess Fluffy",
    "age": 4,
    "cuteness": 10,
    "softness": 10,
    "image_url": "https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e",
    "age_description": "Young kitten",
    "cuteness_level": "Impossibly Cute!",
    "softness_level": "Cloud-like!"
  }
]
```

### Error Responses

#### 404 Not Found
```json
{
  "error": "Kitten not found"
}
```

#### 422 Unprocessable Entity (Validation Errors)
```json
{
  "errors": {
    "name": ["can't be blank"],
    "age": ["must be greater than 0"],
    "cuteness": ["must be in 1..10"]
  }
}
```

## Testing the API

### Using rest-client Gem

Install the gem:
```bash
gem install rest-client
```

Test in IRB:
```ruby
require 'rest-client'
require 'json'

# Get all kittens
response = RestClient.get("http://localhost:3000/kittens", accept: :json)
kittens = JSON.parse(response.body)
puts "Found #{kittens.length} kittens!"

# Get specific kitten
kitten = RestClient.get("http://localhost:3000/kittens/1", accept: :json)
data = JSON.parse(kitten.body)
puts "#{data['name']} is #{data['cuteness']}/10 cute!"

# Test error handling
begin
  RestClient.get("http://localhost:3000/kittens/999", accept: :json)
rescue RestClient::ExceptionWithResponse => e
  puts "Status: #{e.response.code}"
  error = JSON.parse(e.response.body)
  puts "Error: #{error['error']}"
end
```

### Using curl
```bash
# Get all kittens
curl -H "Accept: application/json" http://localhost:3000/kittens

# Get specific kitten
curl -H "Accept: application/json" http://localhost:3000/kittens/1

# Test different content types
curl -H "Accept: text/html" http://localhost:3000/kittens
curl -H "Accept: application/json" http://localhost:3000/kittens
```

## Web Interface Features

### Kitten Management
- **Grid View**: Beautiful card-based layout showing all kittens
- **Individual Profiles**: Detailed view with large photos and stats
- **Add New Kittens**: Form with image URL, age, cuteness, and softness
- **Edit Kittens**: Update any kitten's information
- **Delete Kittens**: Remove kittens with confirmation dialogs

### User Experience
- **Responsive Design**: Works perfectly on mobile and desktop
- **Image Support**: Display kitten photos or cute placeholders
- **Visual Ratings**: Color-coded badges for cuteness and softness levels
- **Age Categories**: Smart categorization (Baby, Young, Adult, Senior)
- **Flash Messages**: User-friendly success and error notifications
- **Navigation**: Clean, intuitive navigation throughout the app

### Design Features
- **Burgundy Theme**: Elegant wine-colored design scheme
- **Gradient Backgrounds**: Beautiful color transitions
- **Card Layouts**: Modern card-based information display
- **Hover Effects**: Interactive elements with smooth animations
- **Typography**: Clean, readable font choices
- **Spacing**: Generous whitespace for visual comfort

## Data Validation

### Kitten Attributes

#### Name Validation
- **Required**: Must be present
- **Length**: 2-50 characters
- **Type**: String

#### Age Validation
- **Required**: Must be present
- **Range**: 1-30 months
- **Type**: Integer
- **Logic**: Automatically categorizes as Baby/Young/Adult/Senior

#### Cuteness Validation
- **Required**: Must be present
- **Range**: 1-10 scale
- **Type**: Integer
- **Levels**: Adorable → Very Cute → Extremely Cute → Impossibly Cute!

#### Softness Validation
- **Required**: Must be present
- **Range**: 1-10 scale
- **Type**: Integer
- **Levels**: Soft → Very Soft → Fluffy → Cloud-like!

#### Image URL Validation
- **Optional**: Can be blank
- **Format**: Must be valid HTTP/HTTPS URL
- **Type**: String
- **Fallback**: Shows cute emoji placeholder if missing

### Error Handling
- **Client-Side**: Form validation feedback
- **Server-Side**: Model validations with custom messages
- **API Responses**: Proper HTTP status codes and error objects
- **User-Friendly**: Clear, actionable error messages

## Sample Data

The application includes adorable sample kittens:

```ruby
# Sample kittens with real photos
[
  {
    name: "Mr. Whiskers",
    age: 8,
    cuteness: 9,
    softness: 8,
    image_url: "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba"
  },
  {
    name: "Princess Fluffy",
    age: 4,
    cuteness: 10,
    softness: 10,
    image_url: "https://images.unsplash.com/photo-1596854407944-bf87f6fdd49e"
  },
  {
    name: "Luna",
    age: 3,
    cuteness: 9,
    softness: 8,
    image_url: "https://images.unsplash.com/photo-1561948955-570b270e7c36"
  }
]
```

Load sample data:
```bash
rails db:seed
```

## Technical Implementation

### Content Negotiation
```ruby
def index
  @kittens = Kitten.all.order(:name)
  
  respond_to do |format|
    format.html # renders index.html.erb
    format.json { 
      render json: @kittens.as_json(
        only: [:id, :name, :age, :cuteness, :softness, :image_url],
        methods: [:age_description, :cuteness_level, :softness_level]
      )
    }
  end
end
```

### Custom JSON Rendering
```ruby
# Include computed methods in JSON response
render json: @kitten.as_json(
  only: [:id, :name, :age, :cuteness, :softness, :image_url, :created_at],
  methods: [:age_description, :cuteness_level, :softness_level]
)
```

### Strong Parameters
```ruby
private

def kitten_params
  params.require(:kitten).permit(:name, :age, :cuteness, :softness, :image_url)
end
```

### Error Handling
```ruby
rescue_from ActiveRecord::RecordNotFound, with: :kitten_not_found

private

def kitten_not_found
  respond_to do |format|
    format.html { redirect_to kittens_path, alert: "Kitten not found!" }
    format.json { render json: { error: "Kitten not found" }, status: :not_found }
  end
end
```

## Security Considerations

### CSRF Protection
- **Web Forms**: Automatically protected with authenticity tokens
- **API Endpoints**: Read-only (GET) operations available via API
- **Write Operations**: HTML forms only (POST, PUT, DELETE)

### Input Validation
- **Server-Side**: All inputs validated in model layer
- **URL Validation**: Image URLs validated for proper format
- **SQL Injection**: Prevented by ActiveRecord parameterized queries
- **XSS Prevention**: ERB templates auto-escape HTML

### Data Integrity
- **Database Constraints**: Foreign key constraints and check constraints
- **Model Validations**: Comprehensive validation rules
- **Error Handling**: Graceful degradation for invalid data

## Performance Considerations

### Database Optimization
- **Indexing**: Primary keys and frequently queried columns indexed
- **Query Efficiency**: Minimal database calls in controllers
- **Data Loading**: Efficient loading of kitten records

### Caching Opportunities
- **Page Caching**: Static pages could be cached
- **Fragment Caching**: Kitten cards could be cached
- **Database Caching**: Query result caching for popular endpoints

### Image Handling
- **External URLs**: Images hosted externally (no local storage)
- **Lazy Loading**: Could implement for performance
- **Optimization**: Could add image resizing/optimization

## Future Enhancements

### API Improvements
- **Authentication**: JWT tokens for protected endpoints
- **Rate Limiting**: Prevent API abuse
- **Pagination**: Handle large datasets efficiently
- **Versioning**: API version management (v1, v2, etc.)
- **Write Endpoints**: Allow POST/PUT/DELETE via API

### Feature Additions
- **User Accounts**: Multi-user kitten management
- **Categories**: Kitten breeds, colors, personalities
- **Search**: Find kittens by name, age, cuteness level
- **Favorites**: Like/favorite system for kittens
- **Comments**: User comments on kittens
- **File Upload**: Direct image upload (not just URLs)

### Technical Improvements
- **Real-time Updates**: WebSocket integration
- **Mobile App**: Native iOS/Android applications
- **GraphQL**: Alternative to REST API
- **Docker**: Containerized deployment
- **CI/CD**: Automated testing and deployment

## Deployment

### Heroku Deployment
```bash
# Create Heroku app
heroku create kittens-api

# Add PostgreSQL
heroku addons:create heroku-postgresql:mini

# Deploy
git push heroku main
heroku run rails db:migrate
heroku run rails db:seed

# Set environment variables
heroku config:set RAILS_MASTER_KEY=your_master_key
```

### Environment Variables
- `DATABASE_URL`: PostgreSQL connection string
- `RAILS_MASTER_KEY`: Encryption key for credentials
- `RAILS_ENV`: Environment (production, development)

## Testing

### Manual Testing Checklist

#### Web Interface
- [ ] Can view all kittens in grid layout
- [ ] Can view individual kitten profiles
- [ ] Can create new kittens with valid data
- [ ] Cannot create kittens with invalid data
- [ ] Can edit existing kittens
- [ ] Can delete kittens with confirmation
- [ ] Images display correctly or show placeholders
- [ ] Validation errors display properly
- [ ] Flash messages appear and disappear
- [ ] Navigation links work correctly

#### API Testing
- [ ] GET /kittens returns JSON array
- [ ] GET /kittens/:id returns single kitten JSON
- [ ] Content-Type headers are correct
- [ ] 404 errors return proper JSON
- [ ] Invalid requests return appropriate status codes
- [ ] JSON includes computed methods (age_description, etc.)

#### Cross-Format Testing
- [ ] Same URLs work for both HTML and JSON
- [ ] Accept headers control response format
- [ ] Default requests return HTML
- [ ] JSON requests return JSON

### Automated Testing Examples
```ruby
# Test in Rails console
require 'rest-client'
require 'json'

# Test JSON endpoint
response = RestClient.get("http://localhost:3000/kittens", accept: :json)
kittens = JSON.parse(response.body)
puts "✅ Found #{kittens.length} kittens"

# Test individual kitten
kitten = RestClient.get("http://localhost:3000/kittens/1", accept: :json)
data = JSON.parse(kitten.body)
puts "✅ #{data['name']}: #{data['cuteness_level']}"

# Test error handling
begin
  RestClient.get("http://localhost:3000/kittens/999", accept: :json)
rescue RestClient::ExceptionWithResponse => e
  puts "✅ 404 handled correctly: #{e.response.code}"
end
```

## Contributing

1. Fork the project
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Resources

- [Rails Guides - Rendering JSON](https://guides.rubyonrails.org/layouts_and_rendering.html#rendering-json)
- [Rails API Documentation](https://api.rubyonrails.org/)
- [REST Client Gem](https://github.com/rest-client/rest-client)
- [The Odin Project](https://www.theodinproject.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## License

This project is for educational purposes.

## Acknowledgments

- The Odin Project for the excellent APIs curriculum
- Unsplash for the adorable kitten photos
- Rails community for comprehensive API documentation
- All developers contributing to RESTful API best practices

---

**Project completed as part of The Odin Project - Ruby on Rails Course**

*Where adorable kittens meet professional API development! 🐱💻*