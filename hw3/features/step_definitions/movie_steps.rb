# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  i1 = page.body.index(e1)
  i2 = page.body.index(e2)
  assert(i1 < i2, "The movie #{e1} did not appear before #{e2}")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  Movie.all_ratings.each { |rating| rating = "ratings[#{rating.strip.gsub(/"/, "")}]" ; if uncheck.nil? then uncheck(rating) else check(rating) end }
  rating_list.split(/,\s?/).each { |rating| rating = "ratings[#{rating.strip.gsub(/"/, "")}]" ; if uncheck.nil? then check(rating) else uncheck(rating) end }
end

Then /I should see all of the movies/ do
  assert_equal Movie.all.count, page.all('table tbody tr').count
end
