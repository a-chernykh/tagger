require 'spec_helper'

describe TagsController do
  render_views

  it 'should return the list of tags in json descending by rank' do
    tag1, tag2, tag3 = build_3_tags
    get 'index', :format => 'json'
    response.body.should == [tag3, tag2, tag1].to_json
  end

  it 'should return the list of tags as html page' do
    tag1, tag2, tag3 = build_3_tags
    get 'index'
    response.should render_template('index')
  end

  it 'should allow to hit particular tag' do
    tag = Factory(:tag, :hits => 9)
    post 'increment', :id => tag.id
    response.should redirect_to(tags_url)
  end
end