use quest_bechdel;

# SCHEMA SETUP
# Setting constraints for bechdel_ratings table
ALTER TABLE bechdel_ratings
ADD PRIMARY KEY (bechdel_ID);

ALTER TABLE bechdel_ratings
ADD FOREIGN KEY (movie_info_ID) REFERENCES movie_info(movie_info_ID);

# Setting constraints for genres table
ALTER TABLE genres
MODIFY COLUMN genre_ID BIGINT;

ALTER TABLE genres
ADD PRIMARY KEY (genre_ID);

# Setting constraints for movie_genre table
ALTER TABLE movie_genre
ADD FOREIGN KEY (movie_info_ID) REFERENCES movie_info(movie_info_ID);

ALTER TABLE movie_genre
ADD FOREIGN KEY (genre_ID) REFERENCES genres(genre_ID);

# QUERIES RELATED TO RESEARCH QUESTION
# What genres are doing best/worst?
# Bechdel 0-3
SELECT gn.genre_name, AVG(br.bechdel_score) AS avg_b_score
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
INNER JOIN movie_genre AS mg
ON mi.movie_info_ID = mg.movie_info_ID
INNER JOIN genres AS gn
ON mg.genre_ID = gn.genre_ID
GROUP BY gn.genre_name
ORDER BY avg_b_score DESC;

# Bechdel fail/pass
SELECT gn.genre_name, AVG(br.bechdel_pass) AS percent_b_pass
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
INNER JOIN movie_genre AS mg
ON mi.movie_info_ID = mg.movie_info_ID
INNER JOIN genres AS gn
ON mg.genre_ID = gn.genre_ID
GROUP BY gn.genre_name
ORDER BY percent_b_pass DESC;

# Are indie movies doing better than “big” industry movies (cut off: budget 1 mio)?
# Bechdel 0-3
SELECT 
	CASE
		WHEN budget < 1000000 THEN 'Indie film'
		ELSE 'Major film'
	END AS production_type,
	AVG(bechdel_score) AS avg_b_score
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY production_type;

# Bechdel fail/pass
SELECT 
	CASE
		WHEN budget < 1000000 THEN 'Indie film'
		ELSE 'Major film'
	END AS production_type,
	AVG(bechdel_pass) AS percent_b_pass
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY production_type;

# Is the score related to the success of a movie?
# Revenue
# Bechdel 0-3
SELECT bechdel_score, AVG(revenue) AS avg_revenue
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY bechdel_score
ORDER BY bechdel_score ASC;

# (Setting up an additional export table for a scatterplot)
SELECT bechdel_score, revenue
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
ORDER BY bechdel_score;

# Bechdel fail/pass
SELECT bechdel_pass, AVG(revenue) AS avg_revenue
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY bechdel_pass
ORDER BY bechdel_pass ASC;

# IMDB rating
# Bechdel 0-3
SELECT bechdel_score, AVG(imdb_score/10) AS avg_imdb_score
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY bechdel_score
ORDER BY bechdel_score ASC;

# (Setting up an additional export table for a scatterplot)
SELECT bechdel_score, imdb_score/10
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
ORDER BY bechdel_score ASC;

# Bechdel fail/pass
SELECT bechdel_pass, AVG(imdb_score/10) AS avg_imdb_score
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY bechdel_pass
ORDER BY bechdel_pass ASC;

# Are movies doing better now than earlier (progression over years)?
# Bechdel 0-3
# All years
SELECT mi.year, AVG(br.bechdel_score) AS avg_b_score
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
GROUP BY mi.year
ORDER BY mi.year ASC;

# (Setting up an additional export table for a scatterplot)
SELECT mi.year, br.bechdel_score
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
ORDER BY mi.year ASC;

# Last ten years
SELECT mi.year, AVG(br.bechdel_score)  AS avg_b_score
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
WHERE mi.year >= 2014
GROUP BY mi.year
ORDER BY mi.year ASC;

# Over the centuries
SELECT 
	CASE
		WHEN movie_info.year < 1930 THEN '1920s'
		WHEN movie_info.year BETWEEN 1930 AND 1939 THEN '1930s'
		WHEN movie_info.year BETWEEN 1940 AND 1949 THEN '1940s'
		WHEN movie_info.year BETWEEN 1950 AND 1959 THEN '1950s'
		WHEN movie_info.year BETWEEN 1960 AND 1969 THEN '1960s'
		WHEN movie_info.year BETWEEN 1970 AND 1979 THEN '1970s'
		WHEN movie_info.year BETWEEN 1980 AND 1989 THEN '1980s'
		WHEN movie_info.year BETWEEN 1990 AND 1999 THEN '1990s'
		WHEN movie_info.year BETWEEN 2000 AND 2009 THEN '2000s'
		WHEN movie_info.year BETWEEN 2010 AND 2019 THEN '2010s'
		ELSE '2020s'
		END AS century,
	AVG(bechdel_score) AS avg_b_score
FROM bechdel_ratings
INNER JOIN movie_info
ON bechdel_ratings.movie_info_ID = movie_info.movie_info_ID
GROUP BY century
ORDER BY century ASC;

# Bechdel fail/pass
# All years
SELECT mi.year, AVG(br.bechdel_pass) AS percent_b_pass
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
GROUP BY mi.year
ORDER BY mi.year ASC;

# Last ten years
SELECT mi.year, AVG(br.bechdel_pass)  AS percent_b_pass
FROM bechdel_ratings AS br
INNER JOIN movie_info AS mi
ON br.movie_info_ID = mi.movie_info_ID
WHERE mi.year >= 2014
GROUP BY mi.year
ORDER BY mi.year ASC;

# Over the centuries
SELECT 
	CASE
		WHEN movie_info.year < 1930 THEN '1920s'
		WHEN movie_info.year BETWEEN 1930 AND 1939 THEN '1930s'
        WHEN movie_info.year BETWEEN 1940 AND 1949 THEN '1940s'
        WHEN movie_info.year BETWEEN 1950 AND 1959 THEN '1950s'
        WHEN movie_info.year BETWEEN 1960 AND 1969 THEN '1960s'
        WHEN movie_info.year BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN movie_info.year BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN movie_info.year BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN movie_info.year BETWEEN 2000 AND 2009 THEN '2000s'
		WHEN movie_info.year BETWEEN 2010 AND 2019 THEN '2010s'
        ELSE '2020s'
		END AS century,
	AVG(bechdel_ratings.bechdel_pass) AS percent_b_pass
FROM bechdel_ratings
INNER JOIN movie_info
ON bechdel_ratings.movie_info_ID = movie_info.movie_info_ID
GROUP BY century
ORDER BY century ASC;

# Are specific countries/orig. languages doing particularly well/bad?
# Countries
# Bechdel 0-3 (min. 5 ratings)
SELECT country, 
	AVG(bechdel_score) AS avg_b_score
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY country
HAVING COUNT(bechdel_ID) > 5
ORDER BY avg_b_score DESC;

# Bechdel fail/pass (min. 5 ratings)
SELECT country, 
	AVG(bechdel_pass) AS percent_b_pass
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY country
HAVING COUNT(bechdel_ID) > 5
ORDER BY percent_b_pass DESC;

# Languages
# Bechdel 0-3 (min. 5 ratings)
SELECT original_language, 
	AVG(bechdel_score) AS avg_b_score
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY original_language
HAVING COUNT(bechdel_ID) > 5
ORDER BY avg_b_score DESC;

# Bechdel fail/pass (min. 5 ratings)
SELECT original_language, 
	AVG(bechdel_pass) AS percent_b_pass
FROM bechdel_ratings
INNER JOIN movie_info
USING(movie_info_ID)
GROUP BY original_language
HAVING COUNT(bechdel_ID) > 5
ORDER BY percent_b_pass DESC;