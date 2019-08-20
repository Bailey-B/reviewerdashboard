# Reviewer Dashboard with Dummy Data

Here is where you can access the live app on shiny
https://baileybaumann.shinyapps.io/dummydatareviewerpool/

As this is a public dashboard, there is no real reviewer information. For GDPR and business reasons, personal and proprietary data should only be on a private dashboard. 

The search bar on the first tab searches everything in the first table, which includes countries, keywords, and even a hidden field with the titles of articles each reviewer has authored and reviewed. When rows are selected in the first table, the tables in the subsequent tabs are filtered so only those reviewers' information is showing. We use (hidden) ORCID fields to identify similar rows across tables.

To run this app on your own computer, make sure to download the app.R file and the three CSV files and save them to the same directory. Then open the app.R file. Load the required libraries (listed at the top of the script) if you have not already. Then run the app using runApp() or by just clicking on the "Run App" button at the top right of the script window if you are in R Studio.

To substitute the dummy data with real data, you will need three separate files. Be sure to include the fields that are searchable but hidden in the final app, such as ORICDs (in all three CSVs) and titles of articles authored (in the master CSV).
  UPDATE 8/19/2019: To avoid encoding errors on the shiny server, make sure your CSV files are UTF-8 encoded.
