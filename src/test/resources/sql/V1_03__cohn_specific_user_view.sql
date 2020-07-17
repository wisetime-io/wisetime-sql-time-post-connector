CREATE VIEW [V_rcw_ListEmployee]
AS
-- VIEW :	V_rcw_ListEmployee
-- VERSION :	1
-- DESCRIPTON:	Populate the List of Employee 
-- Date		MODIFICTION HISTORY
-- ====         ===================
-- 07/07/2020	ELP	Procedure created

select distinct  U.NAMENO as ID, U.LOGINID as Username,  ISNULL (E.SIGNOFFNAME, ISNULL(N.FIRSTNAME,'') + ' ' +  UPPER(N.NAME)) as Name,
	 ISNULL(TELECOMNUMBER, U.LOGINID + '@rcip.co.il') as Email 
from USERIDENTITY U with (NOLOCK)
JOIN NAME N with (NOLOCK) ON U.NAMENO = N.NAMENO
JOIN EMPLOYEE E with (NOLOCK) ON U.NAMENO = E.EMPLOYEENO
LEFT JOIN TELECOMMUNICATION T with (NOLOCK) on T.TELECODE = N.MAINEMAIL AND TELECOMTYPE = 1903
where U.NAMENO <> -48900 and Left(N.NAME,2) <> 'ZZ' and N.NAME is not null
;