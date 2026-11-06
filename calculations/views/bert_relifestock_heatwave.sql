
CREATE VIEW [dbo].[bert_relifestock_heatwave]
AS
WITH ParsedKNMI AS (
    -- Cast raw fields to typed temporal and numeric values
    SELECT 
        station,
        TRY_CAST(tijdstip_utc AS DATETIME2) AS tijdstip_dt,
        CAST(TRY_CAST(tijdstip_utc AS DATETIME2) AS DATE) AS datum,
        thi
    FROM dbo.T_RAW_knmi
    WHERE tijdstip_utc IS NOT NULL
      AND thi IS NOT NULL
),
DailyMetrics AS (
    -- Aggregate hourly data to daily level to evaluate multi-day criteria
    SELECT 
        station,
        datum,
        MAX(thi) AS max_daily_thi,
        AVG(thi) AS avg_daily_thi,
        SUM(CASE WHEN thi >= 68.0 THEN thi - 68.0 ELSE 0.0 END) AS daily_heat_load_excess,
        COUNT(CASE WHEN thi >= 68.0 THEN 1 END) AS daily_stress_hours
    FROM ParsedKNMI
    GROUP BY station, datum
),
StressDays AS (
    -- Identify qualifying heat stress days where peak THI reaches at least 68.0
    SELECT 
        station,
        datum,
        max_daily_thi,
        avg_daily_thi,
        daily_heat_load_excess,
        daily_stress_hours,
        -- Subtract chronological sequence of days to group consecutive stress days
        DATEADD(
            day, 
            -DENSE_RANK() OVER (PARTITION BY station ORDER BY datum), 
            datum
        ) AS island_group
    FROM DailyMetrics
    WHERE max_daily_thi >= 68.0
    and daily_stress_hours>6
)
SELECT 
    station,
    MIN(datum) AS episode_start_date,
    MAX(datum) AS episode_end_date,
    COUNT(*) AS consecutive_days,
    SUM(daily_stress_hours) AS total_stress_hours,
    ROUND(AVG(avg_daily_thi), 2) AS avg_thi,
    MAX(max_daily_thi) AS peak_thi
    
    -- ROUND(SUM(daily_heat_load_excess), 2) AS total_cumulative_heat_load
FROM StressDays
GROUP BY station, island_group;
