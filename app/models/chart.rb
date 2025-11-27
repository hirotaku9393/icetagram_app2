class Chart < ApplicationRecord
  belongs_to :ice_cream, optional: true
  belongs_to :user, optional: true
  validates :sweetness, :freshness, :richness, :calorie, :ingredient_richness, :chart_type, presence: true

  enum :chart_type, {
      official: "official",
      user: "user",
      user_post: "user_post"
  }

  def to_vector
    [ sweetness, freshness, richness, calorie, ingredient_richness ].map(&:to_i)
  end
end
