/*-- **********************************************************************
-- FUNCTION: DateRange
-- Returns a table of datetime values based on the parameters
-- Parameters:  
-- @StartDate    :Start date of the series 
-- @EndDate      :End date of the series 
-- @DatePart :The time unit for @interval
--     ns    : nanoseconds 
--     mcs   : microseconds 
--     ms    : milliseconds 
--     ss    : seconds
--     mi    : minutes
--     hh    : hours
--     dd    : days
--     ww    : weeks
--     mm    : months
--     qq    : quarters
--     yy    : years
-- @Interval :The number of dateparts between each value returned
--
-- Sample Calls:
--     SELECT * FROM [dbo].[DateRange]('2011-01-01 12:24:35', '2011-02-01 12:24:35', 'ss', 2)
--     SELECT COUNT(*) FROM [dbo].[DateRange]('2018-01-01 00:00:00', '2018-01-25 20:31:23.646', 'ms', default)
--     SELECT * FROM [dbo].[DateRange]('2011-01-01', '2012-02-03', default, default)
--     SELECT * FROM [dbo].[DateRange]('2012-02-03', '2011-01-01', 'dd', 7)
--     SELECT DATEDIFF(ns,'2018-01-01 00:00:00.000', value),Value,* FROM [dbo].[DateRange]('2018-01-01 00:00:00.000', '2018-01-01 00:00:00.00001', 'ns', 100)
-- **********************************************************************/  
CREATE FUNCTION [dbo].[DateRange] 
(
    @StartDate datetime2, 
    @EndDate   datetime2, 
    @DatePart  nvarchar(3)='dd', 
    @Interval  int=1
)
RETURNS TABLE AS RETURN 
  WITH A(A) AS (SELECT 0 FROM (VALUES (0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) A(A)),
       B(RowNum) AS (SELECT TOP(ABS(CASE @DatePart
                                        WHEN 'ns'  THEN DATEDIFF(ns, @EndDate, @StartDate)/@Interval
                                        WHEN 'mcs' THEN DATEDIFF(mcs,@EndDate, @StartDate)/@Interval
                                        WHEN 'ms'  THEN DATEDIFF(ms, @EndDate, @StartDate)/@Interval
                                        WHEN 'ss'  THEN DATEDIFF(ss, @EndDate, @StartDate)/@Interval
                                        WHEN 'mi'  THEN DATEDIFF(mi, @EndDate, @StartDate)/@Interval
                                        WHEN 'hh'  THEN DATEDIFF(hh, @EndDate, @StartDate)/@Interval
                                        WHEN 'dd'  THEN DATEDIFF(dd, @EndDate, @StartDate)/@Interval
                                        WHEN 'ww'  THEN DATEDIFF(ww, @EndDate, @StartDate)/@Interval
                                        WHEN 'mm'  THEN DATEDIFF(mm, @EndDate, @StartDate)/@Interval
                                        WHEN 'qq'  THEN DATEDIFF(qq, @EndDate, @StartDate)/@Interval
                                        WHEN 'yy'  THEN DATEDIFF(yy, @EndDate, @StartDate)/@Interval
                                        ELSE DATEDIFF(dd, IIF(@StartDate < @EndDate, @StartDate, @EndDate), IIF(@StartDate < @EndDate, @EndDate, @StartDate))/@Interval
                                    END) + 1)
                            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1
                       FROM A A, A B, A C, A D, A E, A F, A G, A H)   -- A maximum of 16^8 (or 2^32) rows could be returned from this inline tally
  SELECT CASE @DatePart            
              WHEN 'ns'  THEN DATEADD(ns, T.AddAmount, @StartDate)
              WHEN 'mcs' THEN DATEADD(mcs,T.AddAmount, @StartDate)
              WHEN 'ms'  THEN DATEADD(ms, T.AddAmount, @StartDate)
              WHEN 'ss'  THEN DATEADD(ss, T.AddAmount, @StartDate)
              WHEN 'mi'  THEN DATEADD(mi, T.AddAmount, @StartDate)
              WHEN 'hh'  THEN DATEADD(hh, T.AddAmount, @StartDate)
              WHEN 'dd'  THEN DATEADD(dd, T.AddAmount, @StartDate)
              WHEN 'ww'  THEN DATEADD(ww, T.AddAmount, @StartDate)
              WHEN 'mm'  THEN DATEADD(mm, T.AddAmount, @StartDate)
              WHEN 'qq'  THEN DATEADD(qq, T.AddAmount, @StartDate)
              WHEN 'yy'  THEN DATEADD(yy, T.AddAmount, @StartDate)
              ELSE            DATEADD(dd, T.AddAmount, @StartDate)
          END [Value]
    FROM B
   CROSS APPLY(VALUES (IIF(@StartDate<@EndDate, @interval*RowNum, @interval*-RowNum))) T(AddAmount)
