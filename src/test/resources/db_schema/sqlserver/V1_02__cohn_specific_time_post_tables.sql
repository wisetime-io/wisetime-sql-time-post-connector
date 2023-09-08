
CREATE TABLE [dbo].[wt_post_time](
	[ACTIVITYID] [int] IDENTITY(1,1) NOT NULL,
	[CASEID] [int] NULL,
	[USERNAME] [nvarchar](40) NOT NULL,
	[EMAIL] [nvarchar](50) NULL,
	[ACTIVITY_CODE] [numeric](11, 0) NULL,
	[NARRATIVE] nvarchar(254) NULL,
	[NARRATIVE_INTERNAL_NOTE] nvarchar(254) NULL,
	[START_TIME] [datetime] NOT NULL,
    [TOTAL_TIME_SECS] bigint NULL,
    [CHARGEABLE_TIME_SECS] bigint NULL

	)
;