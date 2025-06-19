class Kitten < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :age, presence: true, numericality: { greater_than: 0, less_than: 30 }
  validates :cuteness, presence: true, numericality: { in: 1..10 }
  validates :softness, presence: true, numericality: { in: 1..10 }
  validates :image_url, format: { with: URI.regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true

  def age_description
    case age
    when 0..1
      "Baby kitten"
    when 2..6
      "Young kitten"
    when 7..12
      "Adult cat"
    else
      "Senior cat"
    end
  end

  def cuteness_level
    case cuteness
    when 1..3
      "Adorable"
    when 4..6
      "Very Cute"
    when 7..8
      "Extremely Cute"
    when 9..10
      "Impossibly Cute!"
    end
  end

  def softness_level
    case softness
    when 1..3
      "Soft"
    when 4..6
      "Very Soft"
    when 7..8
      "Fluffy"
    when 9..10
      "Cloud-like!"
    end
  end

  def display_image
    image_url.present? ? image_url : nil
  end
end
