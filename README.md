# Irish Spatial Database — Phase 1

A PostGIS spatial database project using Irish authoritative open data from data.gov.ie.

## Data Sources
- **OSi County Boundaries** — Tailte Éireann via data.gov.ie (EPSG:2157)
- **OSi Townlands Gazetteer** — Tailte Éireann via data.gov.ie (50,380 townlands)

## Tools Used
- PostgreSQL 16 + PostGIS 3.4
- QGIS 3.x
- ogr2ogr (GDAL)
- macOS

## What This Project Demonstrates
- Loading Irish authoritative GeoPackage data into PostGIS using ogr2ogr
- Spatial queries: ST_Area, ST_Within, ST_Distance, ST_Transform
- Point-in-polygon spatial joins across 50,380 features
- CRS management: storing and reprojecting between ITM (EPSG:2157) and WGS84 (EPSG:4326)
- Province-level spatial aggregation using GROUP BY

## Key Findings
- Cork is the largest county at ~7,500 km² with 5,326 townlands
- Dublin has only 883 townlands despite being the most populous county — reflecting its urban nature
- Munster has the highest average townlands per county (2,813) driven by large rural counties
- Ulster shows only 3 counties — the dataset covers the Republic of Ireland only

## View the Map
GitHub's renderer does not support complex Irish coastal boundaries.
View the interactive county map here:
[Open in geojson.io](https://geojson.io/#data=data:text/x-url,https://raw.githubusercontent.com/BazenHaile/irish-spatial-db/main/data/counties.geojson)

## Repository Structure
- `sql/phase1_queries.sql` — All PostGIS queries used in this project
- `data/county_townland_counts.csv` — County rankings by townland count and area
- `data/counties.geojson` — County boundaries (26 counties, EPSG:4326)

## Tools
PostgreSQL · PostGIS · QGIS · ogr2ogr · macOS
