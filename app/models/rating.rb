class Rating < ApplicationRecord
  has_many :technical_coach_ratings
  has_many :technical_coaches, through: :technical_coach_ratings
  validates :landing_id, uniqueness: true

  def self.star_percent(star)
    result = filter_by_star(star).count.to_f * (100.to_f/count.to_f)
    result.nan? ? 0 : result.round
  end

  def self.star_count(star)
    filter_by_star(star).count
  end

  def self.filter_by_star(star)
    where("stars = ?", star).order(date: :desc)
  end

  def parse_date
    self.date.strftime("%D")
  end

  def self.get_all_aaq_ratings(month)
    if month != "All"
      self.where("rating_type='AAQ'").where('extract(month from date) = ?', Date::MONTHNAMES.index(month))
    else
      self.where("rating_type='AAQ'")
    end
  end

  def self.get_aaq_average
    one_star = Array.new(get_all_aaq_ratings.filter_by_star(1).length, 1)
    two_star = Array.new(get_all_aaq_ratings.filter_by_star(2).length, 2)
    three_star = Array.new(get_all_aaq_ratings.filter_by_star(3).length, 3)
    four_star = Array.new(get_all_aaq_ratings.filter_by_star(4).length, 4)
    five_star = Array.new(get_all_aaq_ratings.filter_by_star(5).length, 5)
    stars = one_star.concat(two_star).concat(three_star).concat(four_star).concat(five_star)
    total = 0.0
    stars.each {|star| total += star.to_f}
    result = total / stars.length.to_f
    result.round(2)
  end

  def self.get_all_one_on_one_ratings(month)
    if month != "All"
      self.where("rating_type='1:1'").where('extract(month from date) = ?', Date::MONTHNAMES.index(month))
    else
      self.where("rating_type='1:1'")
    end
  end

  def self.get_one_on_one_average
    one_star = Array.new(get_all_one_on_one_ratings.filter_by_star(1).length, 1)
    two_star = Array.new(get_all_one_on_one_ratings.filter_by_star(2).length, 2)
    three_star = Array.new(get_all_one_on_one_ratings.filter_by_star(3).length, 3)
    four_star = Array.new(get_all_one_on_one_ratings.filter_by_star(4).length, 4)
    five_star = Array.new(get_all_one_on_one_ratings.filter_by_star(5).length, 5)
    stars = one_star.concat(two_star).concat(three_star).concat(four_star).concat(five_star)
    total = 0.0
    stars.each {|star| total += star.to_f}
    result = total / stars.length.to_f
    result.round(2)
  end

  def self.get_all_study_group_ratings(month)
    if month != "All"
      self.where("rating_type='SG'").where('extract(month from date) = ?', Date::MONTHNAMES.index(month))
    else
      self.where("rating_type='SG'")
    end
  end

  def self.get_study_group_average
    one_star = Array.new(get_all_study_group_ratings.filter_by_star(1).length, 1)
    two_star = Array.new(get_all_study_group_ratings.filter_by_star(2).length, 2)
    three_star = Array.new(get_all_study_group_ratings.filter_by_star(3).length, 3)
    four_star = Array.new(get_all_study_group_ratings.filter_by_star(4).length, 4)
    five_star = Array.new(get_all_study_group_ratings.filter_by_star(5).length, 5)
    stars = one_star.concat(two_star).concat(three_star).concat(four_star).concat(five_star)
    total = 0.0
    stars.each {|star| total += star.to_f}
    result = total / stars.length.to_f
    result.round(2)
  end

  def valid_comment
    !!self.comment && !self.comment.strip.empty?
  end
end
