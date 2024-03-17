--Creating DimGeography table:
CREATE TABLE [dbo].[adv_DimGeography](
	[dim_geographykey] [int] IDENTITY(1,1) primary key,
	[GeographyID] [nvarchar](510) NULL,
	[suburb] [nvarchar](255) NULL,
	[city] [nvarchar](255) NULL,
	[state] [nvarchar](255) NULL,
	[state_code] [nvarchar](255) NULL,
	[lat] [float] NULL,
	[lon] [float] NULL)


--Creating DimTransport table:
CREATE TABLE [dbo].[adv_DimTransport](
	[dim_transportkey] [int] IDENTITY(1,1) primary key,
	[TransportID] [nvarchar](767) NULL,
	[state_code] [nvarchar](255) NULL,
	[stop_name] [nvarchar](255) NULL,
	[mode] [nvarchar](255) NULL,
	[lat] [float] NULL,
	[lon] [float] NULL,
	[dim_geographykey] [int] NULL)

ALTER TABLE [dbo].[adv_DimTransport]  WITH CHECK ADD  CONSTRAINT [FK_adv_DimTransport_adv_DimGeography] FOREIGN KEY([dim_geographykey])
REFERENCES [dbo].[adv_DimGeography] ([dim_geographykey])
GO
ALTER TABLE [dbo].[adv_DimTransport] CHECK CONSTRAINT [FK_adv_DimTransport_adv_DimGeography]
GO


--Creating DimSchool table:
CREATE TABLE [dbo].[adv_DimSchool](
	[dim_Schoolkey] [int] IDENTITY(1,1) primary key,
	[postcode] [float] NULL,
	[school_code] [float] NULL,
	[school_name] [nvarchar](255) NULL,
	[SchoolType] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[SchoolID] [nvarchar](767) NULL,
	[dim_geographykey] [int] NULL)

ALTER TABLE [dbo].[adv_DimSchool]  WITH CHECK ADD  CONSTRAINT [FK_adv_DimSchool_adv_DimGeography] FOREIGN KEY([dim_geographykey])
REFERENCES [dbo].[xyz] ([dim_geographykey])
GO
ALTER TABLE [dbo].[adv_DimSchool] CHECK CONSTRAINT [FK_adv_DimSchool_adv_DimGeography]
GO


--Creating FactCrime table:
CREATE TABLE [dbo].[adv_FactCrime](
	[fact_Crimekey] [int] IDENTITY(1,1) primary key,
	[Postcode] [float] NULL,
	[Offence category] [nvarchar](255) NULL,
	[Offence subcategory] [nvarchar](255) NULL,
	[Recorded Incidents] [float] NULL,
	[dim_geographykey] [int] NULL)

ALTER TABLE [dbo].[adv_FactCrime]  WITH CHECK ADD  CONSTRAINT [FK_adv_FactCrime_adv_DimGeography] FOREIGN KEY([dim_geographykey])
REFERENCES [dbo].[adv_DimGeography] ([dim_geographykey])
GO
ALTER TABLE [dbo].[adv_FactCrime] CHECK CONSTRAINT [FK_adv_FactCrime_adv_DimGeography]
GO


--Creating FactRentalValue table:
CREATE TABLE [dbo].[adv_FactRentalValue](
	[fact_RentalValuekey] [int] IDENTITY(1,1) primary key,
	[RentalHouseType] [nvarchar](255) NULL,
	[RentalAmount] [float] NULL,
	[dim_geographykey] [int] NULL)

ALTER TABLE [dbo].[adv_FactRentalValue]  WITH CHECK ADD  CONSTRAINT [FK_adv_FactRentalValue_adv_DimGeography] FOREIGN KEY([dim_geographykey])
REFERENCES [dbo].[xyz] ([dim_geographykey])
GO
ALTER TABLE [dbo].[adv_FactRentalValue] CHECK CONSTRAINT [FK_adv_FactRentalValue_adv_DimGeography]
GO


--Creating FactHouseValue table:
CREATE TABLE [dbo].[adv_FactHouseValue](
	[fact_HouseValuekey] [int] IDENTITY(1,1) Primary key,
	[HouseValue] [float] NULL,
	[dim_geographykey] [int] NULL)

ALTER TABLE [dbo].[adv_FactHouseValue]  WITH CHECK ADD  CONSTRAINT [FK_adv_FactHouseValue_adv_DimGeography] FOREIGN KEY([dim_geographykey])
REFERENCES [dbo].[xyz] ([dim_geographykey])
GO
ALTER TABLE [dbo].[adv_FactHouseValue] CHECK CONSTRAINT [FK_adv_FactHouseValue_adv_DimGeography]
GO


--Queries Explored:

--Retrieve unique suburbs from the adv_DimGeography table:
SELECT DISTINCT suburb 
FROM adv_DimGeography;

--Retrieve the top 3 Postcode with the highest total recorded incidents:
SELECT TOP 3 Postcode, SUM([Recorded Incidents]) AS TotalIncidents
FROM adv_FactCrime
GROUP BY [Postcode]
ORDER BY TotalIncidents DESC;

--Get the total recorded incidents for each offense category in the adv_FactCrime table:
SELECT [Offence category], SUM([Recorded Incidents]) AS TotalIncidents
FROM adv_FactCrime
GROUP BY [Offence category];

--Find the average rental amount for each rental house type in the adv_FactRentalValue table:
SELECT [RentalHouseType], AVG([RentalAmount]) AS AverageRental
FROM adv_FactRentalValue
GROUP BY [RentalHouseType];

--Filter Records in adv_DimSchool with WHERE Clause:
SELECT * 
FROM adv_DimSchool
WHERE SchoolType = 'Primary';

--Sort Records in adv_FactHouseValue with ORDER BY:
SELECT *
FROM adv_FactHouseValue 
ORDER BY HouseValue DESC;

--Count the Number of Records in adv_FactRentalValue:
SELECT COUNT(*) 
FROM adv_FactRentalValue;

--Summarize Data with GROUP BY in adv_FactCrime:
SELECT [Offence category], COUNT(*) as TotalCrime
FROM adv_FactCrime
GROUP BY [Offence category];

--Filter Aggregated Data with HAVING in adv_FactCrime:
SELECT [Offence category], COUNT(*) as TotalCrime
FROM adv_FactCrime
GROUP BY [Offence category]
HAVING COUNT(*) > 10;

--Join Two Tables (adv_FactHouseValue and adv_DimGeography):
SELECT HouseValue, suburb, state
FROM adv_FactHouseValue
JOIN adv_DimGeography
ON adv_FactHouseValue.dim_geographykey = adv_DimGeography.dim_geographykey

--Combine Data from Multiple Tables with INNER JOIN:
SELECT fcv.HouseValue, dt.mode, ds.school_name
FROM adv_FactHouseValue fcv
INNER JOIN adv_DimTransport dt ON fcv.dim_geographykey = dt.dim_geographykey
INNER JOIN adv_DimSchool ds ON fcv.dim_geographykey = ds.dim_geographykey;

--Calculate Average Rental Amount by House Type:
SELECT RentalHouseType, AVG(RentalAmount) AS AvgRentalAmount
FROM adv_FactRentalValue
GROUP BY RentalHouseType;

--Window Function to Rank Schools by Postcode:
SELECT school_name, postcode, 
       RANK() OVER (PARTITION BY postcode ORDER BY school_name) AS SchoolRank
FROM adv_DimSchool;

--Create a View for Easy Data Retrieval:
CREATE VIEW vw_HighValueHouses AS
SELECT g.suburb, v.HouseValue
FROM adv_FactHouseValue v
JOIN adv_DimGeography g ON v.dim_geographykey = g.dim_geographykey
WHERE v.HouseValue > 500000;

--Queries Basedon using VIEW vw
--(a)Selecting Data:
SELECT * FROM vw_HighValueHouses;

--(b)Aggregations:
SELECT suburb, AVG(HouseValue) AS AvgHouseValue
FROM vw_HighValueHouses
GROUP BY suburb;

--(c)Filtering:
SELECT *
FROM vw_HighValueHouses
WHERE HouseValue > 800000;


--Left Join to Include All Records from adv_DimGeography:
SELECT dg.suburb, fc.[Offence category]
FROM adv_DimGeography dg
LEFT JOIN adv_FactCrime fc 
ON dg.dim_geographykey = fc.dim_geographykey;

--Calculate Percentage of Crimes by Category:
SELECT [Offence category], 
       COUNT(*) AS TotalCrimes,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS CrimePercentage
FROM adv_FactCrime
GROUP BY [Offence category]


-- Postcode with Maximum Recorded Crime Incidents(SubQuery)
SELECT  distinct postcode, [Offence category], [Offence subcategory], [Recorded Incidents]
FROM adv_FactCrime c
WHERE [Recorded Incidents] = (
    SELECT MAX([Recorded Incidents])
    FROM adv_FactCrime f
    WHERE postcode = postcode
);

-- crime by state,city and suburb
SELECT d.state,d.city,d.suburb, f.[Offence category],f.[Offence subcategory] ,f.[Recorded Incidents]
FROM adv_DimGeography d
INNER JOIN adv_FactCrime f ON d.[dim_geographykey] = f.[dim_geographykey];


--calculate the average house value, total recorded crime incidents, and average crime rate for each city(SubQuery)
SELECT city,
       AVG(HouseValue) AS average_house_value,
       SUM( [Recorded Incidents]) AS total_crime_incidents,
       AVG( [Recorded Incidents]) AS average_crime_rate
FROM (
  SELECT d.[city], f.[HouseValue], c.[Offence category],c.[Offence subcategory], c.[Recorded Incidents]
  FROM adv_DimGeography d
  INNER JOIN adv_FactHouseValue f ON d.dim_geographykey = f.dim_geographykey
  INNER JOIN adv_FactCrime c ON d.dim_geographykey = c.dim_geographykey
) AS combined_data
GROUP BY city;

--Or

--calculate the average house value, total recorded crime incidents, and average crime rate for each city(CTE)
WITH GeoHouseCrimeData AS (
  SELECT d.state,d.[city], f.[HouseValue], c.[Offence category],c.[Offence subcategory], c.[Recorded Incidents]
  FROM adv_DimGeography d
  INNER JOIN adv_FactHouseValue f ON d.dim_geographykey = f.dim_geographykey
  INNER JOIN adv_FactCrime c ON d.dim_geographykey = c.dim_geographykey
)
SELECT city,
       AVG(HouseValue) AS average_house_value,
       SUM( [Recorded Incidents]) AS total_crime_incidents,
       AVG( [Recorded Incidents]) AS average_crime_rate
FROM GeoHouseCrimeData
GROUP BY city;


--Creating Stored Procedure: GetTransportDetailsByAusLocation
--Description: This stored procedure retrieves transportation details based on Australian locations.
CREATE PROCEDURE GetTransportDetailsByAusLocation
    (@State NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @Suburb NVARCHAR(MAX))
AS
BEGIN
   -- SET NOCOUNT ON;
    SELECT
        dg.[state],
        dg.[city], 
        dg.[suburb],
        dt.[stop_name],
		dt.[mode]
		
    FROM
        [dbo].[adv_DimGeography] AS dg
    INNER JOIN
         [dbo].[adv_DimTransport] AS dt ON dg.[dim_geographykey] = dt.[dim_geographykey]
    WHERE
        dg.[suburb] IN (SELECT value FROM STRING_SPLIT(@Suburb, ',') WHERE RTRIM(value) <> '')
        AND dg.[city] IN (SELECT value FROM STRING_SPLIT(@City, ',') WHERE RTRIM(value) <> '')
        AND dg.[state] IN (SELECT value FROM STRING_SPLIT(@State, ',') WHERE RTRIM(value) <> '');
END;

--Executing Store Procedure - GetTransportDetailsByAusLocation
EXEC GetTransportDetailsByAusLocation 
    @State = 'Victoria',
    @City = 'Melbourne',
    @Suburb = 'Richmond, South Yarra';


--Creating Stored Procedure: GetHouseValueByAusLocation
CREATE PROCEDURE [dbo].[GetHouseValueByAusLocation]
    (@State NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @Suburb NVARCHAR(MAX))
AS
BEGIN

    SELECT
        dg.[state],
        dg.[city],
        dg.[suburb],
        fh.[HouseValue]
    FROM
        [dbo].[adv_DimGeography] AS dg
    INNER JOIN
        [dbo].[adv_FactHouseValue] AS fh ON dg.[dim_geographykey] = fh.[dim_geographykey]
    WHERE
        dg.[suburb] IN (SELECT value FROM STRING_SPLIT(@Suburb, ',') WHERE RTRIM(value) <> '')
        AND dg.[city] IN (SELECT value FROM STRING_SPLIT(@City, ',') WHERE RTRIM(value) <> '')
        AND dg.[state] IN (SELECT value FROM STRING_SPLIT(@State, ',') WHERE RTRIM(value) <> '');
END;


--Creating Stored Procedure: GetRentalValueByAusLocation
CREATE PROCEDURE [dbo].[GetRentalValueByAusLocation]
    (@State NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @Suburb NVARCHAR(MAX))
AS
BEGIN
   
    SELECT
        dg.[state],
        dg.[city],
        dg.[suburb],
		fr.[RentalHouseType],
        fr.[RentalAmount]
    FROM
        [dbo].[adv_DimGeography] AS dg
    INNER JOIN
        [dbo].[adv_FactRentalValue] AS fr ON dg.[dim_geographykey] = fr.[dim_geographykey]
    WHERE
        dg.[suburb] IN (SELECT value FROM STRING_SPLIT(@Suburb, ',') WHERE RTRIM(value) <> '')
        AND dg.[city] IN (SELECT value FROM STRING_SPLIT(@City, ',') WHERE RTRIM(value) <> '')
        AND dg.[state] IN (SELECT value FROM STRING_SPLIT(@State, ',') WHERE RTRIM(value) <> '');
END;


--Creating Stored Procedure: GetSchoolDetailsByAusLocation
CREATE PROCEDURE [dbo].[GetSchoolDetailsByAusLocation]
    (@State NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @Suburb NVARCHAR(MAX))
AS
BEGIN
   
    SELECT
        dg.[state],
        dg.[city],
        dg.[suburb],
        ds.[school_name],
		ds.[SchoolType]
    FROM
        [dbo].[adv_DimGeography] AS dg
    INNER JOIN
        [dbo].[adv_DimSchool] AS ds ON dg.[dim_geographykey] = ds.[dim_geographykey]
    WHERE
        dg.[suburb] IN (SELECT value FROM STRING_SPLIT(@Suburb, ',') WHERE RTRIM(value) <> '')
        AND dg.[city] IN (SELECT value FROM STRING_SPLIT(@City, ',') WHERE RTRIM(value) <> '')
        AND dg.[state] IN (SELECT value FROM STRING_SPLIT(@State, ',') WHERE RTRIM(value) <> '');
END;


--Creating Stored Procedure: GetCrimeDetailsByAusLocation
CREATE PROCEDURE [dbo].[GetCrimeDetailsByAusLocation]
    (@State NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @Suburb NVARCHAR(MAX))
AS
BEGIN
   
    SELECT
        dg.[state],
        dg.[city], 
        dg.[suburb],
        fc.[Offence category],
		fc.[Offence subcategory],
		fc.[Recorded Incidents]
    FROM
        [dbo].[adv_DimGeography] AS dg
    INNER JOIN
        [dbo].[adv_FactCrime] AS fc ON dg.[dim_geographykey] = fc.[dim_geographykey]
    WHERE
        dg.[suburb] IN (SELECT value FROM STRING_SPLIT(@Suburb, ',') WHERE RTRIM(value) <> '')
        AND dg.[city] IN (SELECT value FROM STRING_SPLIT(@City, ',') WHERE RTRIM(value) <> '')
        AND dg.[state] IN (SELECT value FROM STRING_SPLIT(@State, ',') WHERE RTRIM(value) <> '');
END;
