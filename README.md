# texas-real-estate
Analysis of 500 real Estate listings in Texas

Original Dataset: https://www.kaggle.com/datasets/kanchana1990/texas-real-estate-trends-2024-500-listings
Link to related Tableau Public Dashboard: https://public.tableau.com/views/TexasRealEstateListings/TexasRealEstateListings?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link

Breakdown on how certain variables affect listing prices of the 500 record sample

Notes for SQL querying and Tableau:
- Modified version of 'housing_desc' table called 'housing_desc_mod' created in 'price_by_year_built_ranges.sql' to avoid a $28 listing price outlier
  (This is only used in the 'Summary of Listing Prices Based on Year Built' visualization, other two are original dataset, outlier included. Done to make axes less extreme and allow for synchronization on dual axis chart.)
- All fields are described in the texasheader_db_creation.sql file, where the tables were created.
- Data set is only a sample of 500, does not encompass all of Texas. Some metrics should be taken with a grain of salt, as location was not considered a variable in this dataset (Could possibly scrape it from URL column).
- SQL files of tables created for each case used in Tableau worksheets are separated for organization, with each description coinciding with the topic of the visualization.

Descriptions of Files in This Repository

- Texas Real Estate Listings and Takeways.docx -> A text file describing setup and what questions I was aiming to answer with the dashboard
- avg_list_price_comb_bed_bath.sql -> Query used to create table for 'Average Listing Price by Layout' visualization
- price_by_year_built_ranges -> Query used to create table for 'Summary of Listing Prices Based on Year Built' visualization
- price_per_sq_ft_by_year -> Query used to create table for 'Price Per Square Foot Based on Year Built' visualization
- real_estate_texas_500_2024 -> original dataset pulled from Kaggle
- texasheader_db_creation -> Queries used to create main table and load CSV file into that table. Then, splitting into a relational structure of 3 tables. Also, some notes on the project and thought process behind this.




