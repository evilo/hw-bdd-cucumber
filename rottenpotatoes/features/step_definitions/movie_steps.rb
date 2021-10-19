# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
      Movie.create movie
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
    Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    contents = page.body()
    expect(contents.index(e1)).to be < contents.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    if uncheck
        rating_list.split(/, /, -1).each{|rating| uncheck("ratings_" + rating)}
    else
        rating_list.split(/, /, -1).each{|rating| check("ratings_" + rating)}
    end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
#   fail "Unimplemented"
end

Then /I should see all the movies/ do
    c = Movie.all.count + 1
    expect(page.all('table#movies tr').count).to eq (c)
end
