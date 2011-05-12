require 'spec_helper'

describe Tag do
  it { should validate_presence_of(:name) }
  it {
    # create a couple of tags which allows the validate_uniqueness_of to pass
    3.times do
      Factory(:tag)
    end
    should validate_uniqueness_of(:name)
  }
  it { should validate_numericality_of(:hits) }

  it 'should return zero rank for tag with zero hits' do
    tag_with_zero_hits = Factory(:tag, :hits => 0)
    tag_with_zero_hits.rank.should be_zero
  end

  it 'should calculate the rank of particular tag based on the overall maximum hits' do
    tag1, tag2, tag3 = build_3_tags
    tag1.rank.should == 3
    tag2.rank.should == 7
    tag3.rank.should == 10
  end

  it 'should allow to sort the tags by rank ascending and descending' do
    tag1, tag2, tag3 = build_3_tags
    Tag.order_by_rank('asc').should == [tag1, tag2, tag3]
    Tag.order_by_rank('desc').should == [tag3, tag2, tag1]
  end

  it 'should allow to hit the particular tag' do
    tag = Factory(:tag)
    expect { tag.hit! }.to change(tag, :hits).by(1)
  end
end