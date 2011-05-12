class TagsController < ApplicationController
  respond_to :html, :json
  before_filter :find_tag, :only => [:increment]

  def index
    respond_with(@tags = Tag.order_by_rank('desc'))
  end

  def increment
    @tag.hit!
    respond_with(@tag, :location => tags_url)
  end

  protected

  def find_tag
    @tag = Tag.find(params[:id])
  end
end