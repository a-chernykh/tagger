class Tag < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :hits, :numericality => true

  scope :order_by_rank, lambda { |order|
    order = 'desc' unless ['asc', 'desc'].include?(order.downcase)
    select('*, ROUND((hits/(SELECT MAX(hits) FROM tags))*10) rank').order("rank #{order.upcase}")
  }

  class <<self
    def maximum_hits
      maximum('hits') || 0
    end
  end

  # we're hitting 'rank' every time, but this should be performance hog since it uses query cache for quering maximum
  def as_json(options = {})
    { :id => self.id, :name => self.name, :hits => self.hits, :rank => self.rank }
  end

  def hit!
    increment(:hits)
    save
  end

  def rank
    self.class.maximum_hits.zero? ? 0 : ((hits.to_f / self.class.maximum_hits.to_f) * 10).round
  end
end