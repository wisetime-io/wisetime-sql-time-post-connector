
CREATE VIEW [V_rcw_ListHoursActivity]
AS
-- VIEW :	V_rcw_ListHoursActivity
-- VERSION :	1
-- DESCRIPTON:	Populate the List of Activity Hours
-- Date		MODIFICTION HISTORY
-- ====         ===================
-- 07/07/2020	ELP	Procedure created

SELECT [ACTIVITYCODE]      ,[ACTIVITYNAME]
       FROM [TACTIVITYCODES]
  where [ACTIVITYTYPE]=3 and ACTIVITYLA=1
;
