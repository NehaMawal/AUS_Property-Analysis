# Project: Property Analysis and Visualization
 ### Overview:
   * The Property Analysis and Visualization project aims to extract insights from Australian property data using advanced data analysis and Business Intelligence 
     (BI) techniques.
   * The project involves data collection, transformation, modeling, ETL processing and visualization to provide stakeholders with actionable insights for decision- 
     making.
  ### DataSet: https://drive.google.com/drive/folders/1SgYQoRI7MOcaLrpgCZQnJK2771Aq7gVB?usp=sharing 
# Tools and Languages Used:
   * Microsoft SQL Server: Used for data storage, management, and querying.
   * Visual Studio: Utilized for developing SSIS packages for the ETL process.
   * SSRS (SQL Server Reporting Services): Employed for designing and deploying interactive report.
   * Power BI: Leveraged for creating dynamic and visually appealing dashboards and visualizations.
  
# Key Responsibilities:
   * Data Collection: Data was collected from various sources, including Aus_Suburb Data, House Value, Rental Value, school, transport and crime statistics. 
   * Data Transformation: The collected data was meticulously transformed and cleansed to ensure accuracy and integrity.
   * Data Modeling: A robust data model was designed using the Snowflake schema, incorporating dimension and fact tables to support reporting and analysis 
     requirements.SQL queries were used to create dimensions and fact tables, establish primary and foreign key relationships, and ensure data integrity.
   * Reporting and Visualization: Interactive dashboards and reports were developed using SSRS and Power BI, presenting insights effectively to stakeholders.

# Project Tasks:
  # Part 1: Data Collection and Consolidation
  * ETL(Extract,Transform,Load) process was used to extracting data from multiple sources,cleaning the data and transforming it to fit the data model
  * SSIS packages were used for the ETL process, and loading data into staging tables.
  * Load tables and staging tables were implemented for efficient data processing and consolidation.
    
# Part 2: Data Modeling
  * A comprehensive data model was designed using the Snowflake schema, including dimension and fact tables.
  * SQL queries were used to create dimensions and fact tables, establish primary and foreign key relationships, and ensure data integrity.
  * SSIS packages were created to load data into the data model, ensuring accuracy and reliability.
  * Advanced SQL queries were utilized to create dimension and fact tables and select and manipulate data within the data model, optimizing performance and efficiency.
    
# Part 3: Reporting with SSRS
  * SSRS was connected to the Data Warehouse and SQL stored procedures were used to fetch data into SSRS reports.
  * Multiple tables were designed using SSRS, incorporating parameters and cascading parameters to display property values, rental rates, transport stations, schools, 
    and crime incidents.
  * SQL queries and stored procedures were written to select data from the data model for use in SSRS report.
  * The report was deployed on a web page for easy access by stakeholders, and options for downloading reports as PDF files were provided.
    
# Part 4: Visualization with Power BI
  * A Power BI dashboard with multiple pages was built for analyzing and visualizing property data.
  * The Data Model from the Data Warehouse was imported into Power BI and all tables were connected on the correct columns. 

    <img width="533" alt="image" src="https://github.com/NehaMawal/AUS_Property-Analysis/assets/163222343/b7980ee9-2b41-4ba0-b69e-a932d69202e7">
  * Multiple pages in Power BI were created to analyze house values, rental rates, schools, transport, and crime incidents using various visualizations.
  * A Summary page was designed to consolidate key insights from individual pages and implemented drill-through functionality for detailed analysis.

# Insights:
  * Meticulous Data Management: Accuracy and reliability of data were ensured through meticulous data transformation, cleansing, and modeling processes.
  * Efficient Data Processing: SSIS packages and SQL queries were utilized for efficient data collection, transformation, and loading into the data model.
  * Effective Visualization: Intuitive and visually appealing reports and dashboards were developed using SSRS and Power BI, providing stakeholders with easily 
    consumable insights.
