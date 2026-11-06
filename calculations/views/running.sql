create view running as SELECT r.session_id,
st.TEXT AS batch_text,
       qp.query_plan AS 'XML Plan',
       r.start_time,
       r.status,
       r.total_elapsed_time
FROM sys.dm_exec_requests AS r
     CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
     CROSS APPLY sys.dm_exec_query_plan(r.plan_handle) AS qp
