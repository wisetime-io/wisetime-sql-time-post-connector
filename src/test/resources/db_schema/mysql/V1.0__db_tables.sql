CREATE TABLE wt_post_time (
  ACTIVITYID INT AUTO_INCREMENT NOT NULL,
  CASEID INT NULL,
  USERNAME CHAR(50) NOT NULL,
  EMAIL CHAR(50) NULL,
  ACTIVITY_CODE NUMERIC(11, 0) NULL,
  NARRATIVE CHAR(254) NULL,
  NARRATIVE_INTERNAL_NOTE CHAR(254) NULL,
  START_TIME DATETIME(3) NOT NULL,
  TOTAL_TIME_SECS BIGINT NULL,
  CHARGEABLE_TIME_SECS BIGINT NULL,
  PRIMARY KEY (ACTIVITYID)
);

create table CASES (
  CASEID INT NOT NULL,
  IRN CHAR(30),
  CASETYPE CHAR(1) NOT NULL,
  TITLE CHAR(254),
  PROPERTYTYPE CHAR(1) NOT NULL,
  COUNTRYCODE CHAR(3) NOT NULL
);

create table USERIDENTITY (
  IDENTITYID INT AUTO_INCREMENT,
  NAMENO INT NOT NULL,
  LOGINID CHAR(50) NOT NULL,
  PRIMARY KEY (IDENTITYID)
);

create table TACTIVITYCODES (
  ACTIVITYCODE NUMERIC(11, 0),
  ACTIVITYNAME CHAR(50),
  ACTIVITYTYPE INT,
  ACTIVITYLA INT
);
