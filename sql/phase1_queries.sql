-- Phase 1: PostgreSQL + PostGIS Foundations
-- Database: gis_ireland
-- Data: OSi County Boundaries + OSi Townlands (data.gov.ie)
-- CRS: Irish Transverse Mercator EPSG:2157

-- Task 4: County areas ranked largest to smallest
SELECT
    county,
    province,
    ROUND((ST_Area(shape) / 1000000)::numeric, 2) AS area_km2
FROM counties
ORDER BY area_km2 DESC;

-- Task 4: Point in polygon
SELECT county, province
FROM counties
WHERE ST_Within(
    ST_GeomFromText('POINT(715830 734697)', 2157),
    shape
);

-- Task 4: Distance between county centroids
SELECT
    ROUND((ST_Distance(
        (SELECT ST_Centroid(shape) FROM counties WHERE county = 'DUBLIN'),
        (SELECT ST_Centroid(shape) FROM counties WHERE county = 'CORK')
    ) / 1000)::numeric, 1) AS distance_km;

-- Task 5: CRS comparison - ITM vs WGS84 area
SELECT
    county,
    ROUND((ST_Area(shape) / 1000000)::numeric, 2) AS area_itm_km2,
    ROUND(ST_Area(ST_Transform(shape, 4326))::numeric, 6) AS area_wgs84_degrees
FROM counties
ORDER BY area_itm_km2 DESC;

-- Task 6: Spatial join - townland count per county
SELECT
    c.county,
    c.province,
    COUNT(t.objectid_1) AS townland_count
FROM counties c
JOIN townlands t ON ST_Within(t.shape, c.shape)
GROUP BY c.county, c.province
ORDER BY townland_count DESC;

-- Task 6: Province level aggregation
SELECT
    c.province,
    COUNT(DISTINCT c.county) AS county_count,
    COUNT(t.objectid_1) AS total_townlands,
    ROUND(COUNT(t.objectid_1)::numeric / COUNT(DISTINCT c.county), 0) AS avg_townlands_per_county
FROM counties c
JOIN townlands t ON ST_Within(t.shape, c.shape)
GROUP BY c.province
ORDER BY total_townlands DESC;
