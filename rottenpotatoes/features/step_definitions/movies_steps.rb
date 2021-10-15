
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |e1, e2|
  expect(Movie.find_by(title: e1).director).to eq(e2)
end

Then /I should see all movies with ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(/,/)

  # count records with rating
  count = 0
  ratings.each do |rating|
    count += Movie.where(rating: rating).count
  end

  # count records displayed
  table_count = page.body.scan(/<tr>/).size - 1
  table_count.should be count
end

Then /I shouldn't see any movies with ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(/,/)
  
  # count records with rating
  count = 0
  ratings.each do |rating|
    Movie.where(rating: rating).each do |movie|
      regexp = /#{movie.title}/m
      if page.body =~ regexp then
        count += 1
      end
    end
  end
  
  # count records displayed
  count.should be 0
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end