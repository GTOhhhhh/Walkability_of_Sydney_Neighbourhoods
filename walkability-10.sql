DROP TABLE IF EXISTS business_stats;
DROP TABLE IF EXISTS car_sharing_pods;
DROP TABLE IF EXISTS census_stats;
DROP TABLE IF EXISTS neighbourhood_walk_stats;
DROP TABLE IF EXISTS neighbourhoods;
DROP TABLE IF EXISTS statistical_areas;

CREATE TABLE statistical_areas (
  area_id        INTEGER,
  area_name      VARCHAR(50),
  parent_area_id INTEGER,
  PRIMARY KEY (area_id)
);

CREATE TABLE neighbourhoods (
  area_id              INTEGER,
  area_name            VARCHAR(200) UNIQUE,
  land_area            DECIMAL,
  population           INTEGER,
  number_of_dwellings  INTEGER,
  number_of_businesses INTEGER,
  number_of_car_sharing_pods INTEGER,
  number_of_public_transport_hubs INTEGER,
  PRIMARY KEY (area_id),
  FOREIGN KEY (area_id) REFERENCES statistical_areas(area_id)
);

CREATE TABLE business_stats (
  area_id                           INTEGER,
  num_businesses                    INTEGER,
  retail_trade                      INTEGER,
  accommodation_and_food_services   INTEGER,
  health_care_and_social_assistance INTEGER,
  education_and_training            INTEGER,
  arts_and_recreation_services      INTEGER,
  PRIMARY KEY (area_id),
  FOREIGN KEY (area_id) REFERENCES statistical_areas(area_id),
  FOREIGN KEY (area_id) REFERENCES neighbourhoods(area_id)    
);

CREATE TABLE car_sharing_pods (
  pod_id INTEGER,
  name VARCHAR(100),
  num_cars INTEGER,
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  area_id INTEGER, 
  PRIMARY KEY (pod_id),
  FOREIGN KEY (area_id) REFERENCES statistical_areas(area_id),
  FOREIGN KEY (area_id) REFERENCES neighbourhoods(area_id)
);

CREATE TABLE census_stats (
  area_id INTEGER,
  median_annual_household_income INTEGER,
  avg_monthly_rent INTEGER,
  PRIMARY KEY (area_id),
  FOREIGN KEY (area_id) REFERENCES statistical_areas(area_id),
  FOREIGN KEY (area_id) REFERENCES neighbourhoods(area_id)
);

CREATE TABLE neighbourhood_walk_stats (
    area_id INTEGER,
    population_density DECIMAL,
    dwelling_density DECIMAL,
    service_balance DECIMAL,
    transport_density DECIMAL,
    public_transport_density DECIMAL,
    population_density_z DECIMAL,
    dwelling_density_z DECIMAL,
    service_balance_z DECIMAL,
    transport_density_z DECIMAL,
    public_transport_density_z DECIMAL,
    walkability_score DECIMAL,
    PRIMARY KEY (area_id),
    FOREIGN KEY (area_id) REFERENCES statistical_areas(area_id),
    FOREIGN KEY (area_id) REFERENCES neighbourhoods(area_id)
);

CREATE INDEX walkability_idx
ON neighbourhood_walk_stats (walkability_score);

CREATE INDEX spatial_idx
ON car_sharing_pods (latitude, longitude);
