class Tag < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :hits, :numericality => true

  scope :order_by_rank, lambda { |order|
    order = 'desc' unless ['asc', 'desc'].include?(order.downcase)
    select('*, ROUND((hits/(SELECT MAX(hits) FROM tags))*10) AS rank').order("rank #{order.upcase}")
  }

  class <<self
    def maximum_hits
      maximum('hits')
    end
  end

  def rank
    return 0 if self.class.maximum_hits.zero?
    ((hits.to_f / self.class.maximum_hits.to_f) * 10).round
  end

  def hit!
    increment(:hits)
  end
end