# "BECHDFLIX" - Bechdel Analytics

By Sebastian Bobeth, Dominik Koppen  
Created in November 2023


## SCOPE OF THE PROJECT
Analyzing movie data related to the Bechdel test using Python, SQL, and data visualization tools.

#### SCENARIO
Taking on the role of developers of a new progressive movie streaming platform (BECHDFLIX), one of our purposes is to only include movies that pass the Bechdel test in our services. The Bechdel test is a very simple way to assess the active presence of female characters in movies. Despite its basic criteria, many movies have failed the test.
The goal of our data analysis is to find out whether there is a sufficient market for an online streaming platform focussing on movies passing the test.

#### TECHNOLOGIES USED
- Python (Jupyter Notebook) - Data cleaning and preparation
- SQL (MySQL Workbench) - Schema design, querying research questions
- Data visualization software (Tableau) - Visualizing query results

#### DATASETS USED
- [Bechdel_movies_2023_FEB.csv](https://www.kaggle.com/datasets/treelunar/bechdel-test-movies-as-of-feb-28-2023) - Dataset with ~10,000 Bechdel test rating scores from the bechdeltest.com community
- [imdb_movies.csv](https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset) - Dataset with information about ~ 10,000 movies (e.g., IMDB rating, revenue, genre information)

#### RELATIONAL DATABASE
We built a relational database to link the datasets and to account for a many-to-many relationship between movies and genres. The schema is depicted below.  
<br>
![Database schema](https://github.com/seblap86/bechdel_analytics/blob/main/bechdel_analytics_ERD.jpg?raw=true)

## RESULTS 
Our analyses reveals that there is a sufficient market for movies passing the Bechdel test.
- There are movies passing the Bechdel test present in major and indie productions, which provides a wide range of options regarding the movie inventory.  
<br>  
![Production types](https://github.com/seblap86/bechdel_analytics/blob/main/visualizations/avg_bechdel_score_by_production_type.jpg?raw=true)
<br>

- Genres such as TV movies, music-related movies, romances are, on average, scoring better than genres such as war movies, documentaries, or western movies, which influences purchase options/decisions and the potential target group.  
![Genres](https://github.com/seblap86/bechdel_analytics/blob/main/visualizations/avg_bechdel_score_by_genre.jpg?raw=true)
<br>

- Movies that pass all 3 criteria of the Bechdel pass are creating a higher revenue, on average, than movies that fail to pass the Bechdel pass, pointing to a high market potential.  
![Revenues](https://github.com/seblap86/bechdel_analytics/blob/main/visualizations/avg_revenue_by_bechdel_score.jpg?raw=true)
<br>

- Over the last decades, movies, on average, are doing better and better in passing the very basic criteria of the test, pointing to a future-proof market.  
![Decades](https://github.com/seblap86/bechdel_analytics/blob/main/visualizations/avg_bechdel_score_through_decades.png?raw=true)
<br>

## CONTENTS OF THIS REPOSITORY
We provide our cleaned data files, Python and SQL code, as well as visualizations and Tableau files in this repository.
