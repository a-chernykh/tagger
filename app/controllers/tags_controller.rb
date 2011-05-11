class TagsController < ApplicationController
  respond_to :html, :json
  before_filter :find_tag, :only => [:increment]

  def index
  end

  def increment
    @tag.hit!
  end

  protected

  def find_tag
    @tag = Tag.find(params[:id])
  end
end