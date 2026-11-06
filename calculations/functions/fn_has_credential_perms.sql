CREATE FUNCTION [jobs_internal].fn_has_credential_perms(@credential_name NVARCHAR(128))
RETURNS BIT
AS
BEGIN
    RETURN HAS_PERMS_BY_NAME(quotename(@credential_name), 'DATABASE SCOPED CREDENTIAL', 'REFERENCES')
END