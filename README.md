# DE_Fabric_Project — Unified Monthly KPIs (Taxi + Air Quality + FX + GDP)

This project is a Microsoft Fabric Data Engineering workspace that builds a small analytics-ready warehouse using multiple public datasets and exposes a unified monthly KPI dataset for reporting in Power BI.

Main deliverable: a **unified long-format monthly KPI view** that supports slicers (domain / metric / time) and a **correlation view** for comparing mobility vs air quality.

---

## What this project contains

### Data sources (high-level)
- **NYC Taxi** (mobility / revenue metrics)
- **OpenAQ** (air quality metrics: PM2.5, NO2, O3)
- **ECB FX rates** (USD/EUR conversion context)
- **World Bank GDP** (economic context)

### Storage / modeling
- **Lakehouse**: `lh_unified` (bronze/silver/gold processing for OpenAQ)
- **Warehouse**: `wh_gold` (final tables + views used by Power BI)

### Core tables (Warehouse)
- `DimDate`
- `DimZone`
- `DimFx`
- `DimGDP`
- `DimAirQualityMetric`
- `ZoneLookup`
- `FactTaxiDaily`
- `FactAirQualityMonthly`

### Core views (Warehouse)
- `vw_UnifiedMonthly_Long_Complete`  
  Unified monthly long-format table with columns like:
  `domain`, `month_date`, `metric_name`, `metric_value`, `unit`, etc.
- `vw_CorrelationMonthly`  
  Monthly dataset used for correlation/scatter visuals (mobility vs air quality).

---

## Workspace items included in this repo

### Dataflows (Gen2)
Located in: `exports/dataflows/`
- Bronze ingestion (ECB FX, WorldBank GDP)
- Dimension loads (Date, Zone, FX, GDP, AirQualityMetric)
- Fact loads (Taxi daily, Air quality monthly)
- Lookups / helper loads (zone lookup)
- Gold OpenAQ load

### Notebooks
Located in: `exports/notebooks/`
- `04_openaq_ingest.ipynb`
- `nb_transform_silver.ipynb`
- `nb_transform_gold.ipynb`

### Pipeline
Located in: `exports/pipelines/`
- `pl_bronze_nyc_taxi_copy.zip`

### SQL scripts (Warehouse)
Located in: `exports/sql/`

### Power BI Report (Fabric Web)
Located in: `powerbi/screenshots/`

