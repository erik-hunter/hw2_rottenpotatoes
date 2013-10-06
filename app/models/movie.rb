class Movie < ActiveRecord::Base

	def self.getUniqueMovieRatings
		return Movie.select("rating").map{|m| m.rating}.uniq
	end

end
