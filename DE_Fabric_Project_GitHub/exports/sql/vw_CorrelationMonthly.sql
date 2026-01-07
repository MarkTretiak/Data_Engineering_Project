-- Auto Generated (Do not modify) E8B66D1FFFEAAFFEC9A543EF90B2A63AFED0316DDE7D06C22D5C22140DF46553
CREATE   VIEW dbo.vw_CorrelationMonthly AS
WITH taxi AS (
    SELECT
        [year],
        [month],
        trip_count,
        total_amount_usd,
        fare_amount_usd,
        tip_amount_usd,
        avg_trip_distance,
        avg_trip_minutes,
        avg_passenger_count
    FROM dbo.vw_MonthlyKPI
),
air AS (
    SELECT
        [year],
        [month],
        MAX(CASE WHEN parameter='pm25' THEN avg_value END) AS pm25_avg,
        MAX(CASE WHEN parameter='no2'  THEN avg_value END) AS no2_avg,
        MAX(CASE WHEN parameter='o3'   THEN avg_value END) AS o3_avg
    FROM dbo.vw_AirQualityMonthly_Enriched
    GROUP BY [year], [month]
)
SELECT
    t.[year],
    t.[month],
    CAST(CONCAT(t.[year], '-', RIGHT('00' + CAST(t.[month] AS varchar(2)), 2), '-01') AS date) AS month_date,
    t.trip_count,
    t.total_amount_usd,
    t.fare_amount_usd,
    t.tip_amount_usd,
    t.avg_trip_distance,
    t.avg_trip_minutes,
    t.avg_passenger_count,
    a.pm25_avg,
    a.no2_avg,
    a.o3_avg
FROM taxi t
LEFT JOIN air a
  ON a.[year]=t.[year] AND a.[month]=t.[month]
WHERE t.[year]=2024;