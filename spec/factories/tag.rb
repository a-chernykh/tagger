Factory.sequence :tag_name do |n|
  "tag #{n}"
end

Factory.define :tag do |f|
  f.name { Factory.next(:tag_name) }
  f.hits { rand(100) }
end