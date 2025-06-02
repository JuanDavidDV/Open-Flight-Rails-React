class Airline < ApplicationRecord
  has_many :reviews

  def avg_score
    reviews.average(:score).round(2).to_f
  end

  before_create :slugify
  # Takes airlines name and converts it into a URL safe slug, and then sets is a the slug value
  def slugify
    self.slug = name.parameterize
  end
end
