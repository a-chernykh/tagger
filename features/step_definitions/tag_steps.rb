Given /^the following tags:$/ do |tags|
  Tag.create!(tags.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) tag$/ do |pos|
  visit tags_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tags:$/ do |expected_tags_table|
  expected_tags_table.diff!(tableish('table tr', 'td,th'))
end
