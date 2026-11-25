--use master;

SET ANSI_NULLS ON
;
SET QUOTED_IDENTIFIER ON
;

create table dtproperties
(
  [id] int identity,
  [objectid] int,
  [property] varchar(64) not null,
  [value] varchar(255),
  [uvalue] nvarchar(255),
  [lvalue] image,
  [version] int default 0 not null,
  constraint pk_dtproperties
  primary key (id, property)
)
;

create table ACCOUNT
(
  [ENTITYNO] int not null,
  [NAMENO] int not null,
  [BALANCE] decimal(11,2),
  [CRBALANCE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKACCOUNT
  primary key (ENTITYNO, NAMENO)
)
;

create index XIE1ACCOUNT
  on ACCOUNT (NAMENO)
;

create table ACCT_TRANS_TYPE
(
  [TRANS_TYPE_ID] smallint not null
    constraint XPKACCTTRANSTYPE
    primary key,
  [DESCRIPTION] nvarchar(50) not null,
  [USED_BY] int not null,
  [REVERSE_TRANS_TYPE] smallint,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ACCT_TRANS_TYPE
  on ACCT_TRANS_TYPE (DESCRIPTION)
;

create table ACTIONS
(
  [ACTION] nvarchar(2) not null
    constraint XPKACTIONS
    primary key,
  [ACTIONNAME] nvarchar(50),
  [NUMCYCLESALLOWED] smallint,
  [ACTIONTYPEFLAG] decimal(1),
  [ACTIONNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ACTIVITYATTACHMENT
(
  [ACTIVITYNO] int not null,
  [SEQUENCENO] int not null,
  [ATTACHMENTNAME] nvarchar(254),
  [FILENAME] nvarchar(254),
  [ATTACHMENTDESC] nvarchar(254),
  [PUBLICFLAG] decimal(1),
  [ATTACHMENTDESC_TID] int,
  [ATTACHMENTNAME_TID] int,
  [ATTACHMENTTYPE] int,
  [LANGUAGENO] int,
  [PAGECOUNT] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKACTIVITYATTACHMENT
  primary key (ACTIVITYNO, SEQUENCENO)
)
;

create index XIE1ACTIVITYATTACHMENT
  on ACTIVITYATTACHMENT (ATTACHMENTTYPE)
;

create index XIE2ACTIVITYATTACHMENT
  on ACTIVITYATTACHMENT (LANGUAGENO)
;

create table ACTIVITYHISTORY
(
  [CASEID] int,
  [WHENREQUESTED] datetime not null,
  [SQLUSER] nvarchar(40) not null,
  [QUESTIONNO] smallint,
  [INSTRUCTOR] int,
  [OWNER] int,
  [EMPLOYEENO] int,
  [PROGRAMID] nvarchar(8),
  [ACTION] nvarchar(2),
  [EVENTNO] int,
  [CYCLE] smallint,
  [LETTERNO] smallint,
  [ALTERNATELETTER] smallint,
  [COVERINGLETTERNO] smallint,
  [HOLDFLAG] decimal(1),
  [SPLITBILLFLAG] decimal(1),
  [BILLPERCENTAGE] decimal(5,2),
  [DEBITNOTENO] nvarchar(10),
  [ENTITYNO] int,
  [DEBTORNAMETYPE] nvarchar(3),
  [DEBITNOTEDETAIL] nvarchar(10),
  [LETTERDATE] datetime,
  [DELIVERYID] smallint,
  [ACTIVITYTYPE] smallint,
  [ACTIVITYCODE] int,
  [PROCESSED] decimal(1),
  [TRANSACTIONFLAG] decimal(1),
  [PRODUCECHARGES] decimal(1),
  [WHENOCCURRED] datetime,
  [STATUSCODE] smallint,
  [RATENO] int,
  [PAYFEECODE] nchar(1),
  [ENTEREDQUANTITY] int,
  [ENTEREDAMOUNT] decimal(11,2),
  [DISBCURRENCY] nvarchar(3),
  [DISBEXCHANGERATE] decimal(8,4),
  [SERVICECURRENCY] nvarchar(3),
  [SERVEXCHANGERATE] decimal(8,4),
  [BILLCURRENCY] nvarchar(3),
  [BILLEXCHANGERATE] decimal(8,4),
  [DISBTAXCODE] nvarchar(3),
  [SERVICETAXCODE] nvarchar(3),
  [DISBNARRATIVE] smallint,
  [SERVICENARRATIVE] smallint,
  [DISBAMOUNT] decimal(11,2),
  [SERVICEAMOUNT] decimal(11,2),
  [DISBTAXAMOUNT] decimal(11,2),
  [SERVICETAXAMOUNT] decimal(11,2),
  [TOTALDISCOUNT] decimal(11,2),
  [DISBWIPCODE] nvarchar(6),
  [SERVICEWIPCODE] nvarchar(6),
  [SYSTEMMESSAGE] nvarchar(254),
  [DISBEMPLOYEENO] int,
  [SERVEMPLOYEENO] int,
  [DISBORIGINALAMOUNT] decimal(11,2),
  [SERVORIGINALAMOUNT] decimal(11,2),
  [DISBBILLAMOUNT] decimal(11,2),
  [SERVBILLAMOUNT] decimal(11,2),
  [DISCBILLAMOUNT] decimal(11,2),
  [TAKENUPAMOUNT] decimal(11,2),
  [DISBDISCOUNT] decimal(11,2),
  [SERVDISCOUNT] decimal(11,2),
  [DISBBILLDISCOUNT] decimal(11,2),
  [SERVBILLDISCOUNT] decimal(11,2),
  [DISBCOSTLOCAL] decimal(11,2),
  [DISBCOSTORIGINAL] decimal(11,2),
  [DISBDISCORIGINAL] decimal(11,2),
  [SERVDISCORIGINAL] decimal(11,2),
  [ESTIMATEFLAG] decimal(1),
  [EMAILOVERRIDE] nvarchar(50),
  [DISBCOSTCALC1] decimal(11,2),
  [DISBCOSTCALC2] decimal(11,2),
  [SERVCOSTCALC1] decimal(11,2),
  [SERVCOSTCALC2] decimal(11,2),
  [IDENTITYID] int,
  [DEBTOR] int,
  [SEPARATEDEBTORFLAG] decimal(1),
  [PRODUCTCODE] int,
  [XMLINSTRUCTIONID] int,
  [CHECKLISTTYPE] smallint,
  [SERVCOSTLOCAL] decimal(11,2),
  [SERVCOSTORIGINAL] decimal(11,2),
  [FILENAME] nvarchar(254),
  [DIRECTPAYFLAG] bit,
  [ACTIVITYID] int identity,
  [BATCHNO] int,
  [EDEOUTPUTTYPE] int,
  [REQUESTID] int,
  [XMLFILTER] nvarchar(254),
  [DISBSTATETAXCODE] nvarchar(3),
  [SERVSTATETAXCODE] nvarchar(3),
  [DISBSTATETAXAMT] decimal(11,2),
  [SERVSTATETAXAMT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [GROUPACTIVITYID] int,
  [DISBMARGINNO] int,
  [SERVMARGINNO] int,
  [DISBMARGIN] decimal(11,2),
  [DISBHOMEMARGIN] decimal(11,2),
  [DISBBILLMARGIN] decimal(11,2),
  [SERVMARGIN] decimal(11,2),
  [SERVHOMEMARGIN] decimal(11,2),
  [SERVBILLMARGIN] decimal(11,2),
  [DISBDISCFORMARGIN] decimal(11,2),
  [DISBHOMEDISCFORMARGIN] decimal(11,2),
  [DISBBILLDISCFORMARGIN] decimal(11,2),
  [SERVDISCFORMARGIN] decimal(11,2),
  [SERVHOMEDISCFORMARGIN] decimal(11,2),
  [SERVBILLDISCFORMARGIN] decimal(11,2),
  constraint XPKACTIVITYHISTORY
  primary key (SQLUSER, ACTIVITYID)
)
;

create index XIE2ACTIVITYHISTORY
  on ACTIVITYHISTORY (PROCESSED, ACTIVITYCODE, ACTIVITYTYPE, TRANSACTIONFLAG, WHENREQUESTED)
;

create index XIE3ACTIVITYHISTORY
  on ACTIVITYHISTORY (DEBITNOTENO, ENTITYNO)
;

create index XIE4ACTIVITYHISTORY
  on ACTIVITYHISTORY (CASEID, WHENREQUESTED, SQLUSER)
;

create index XIE5ACTIVITYHISTORY
  on ACTIVITYHISTORY (BATCHNO, EDEOUTPUTTYPE)
;

create index XIE6ACTIVITYHISTORY
  on ACTIVITYHISTORY (GROUPACTIVITYID)
;

create index XIE7ACTIVITYHISTORY
  on ACTIVITYHISTORY (DISBMARGINNO, SERVMARGINNO)
;

create index XIE8ACTIVITYHISTORY
  on ACTIVITYHISTORY (SERVMARGINNO)
;

create table ACTIVITYREQUEST
(
  [CASEID] int,
  [WHENREQUESTED] datetime not null,
  [SQLUSER] nvarchar(40) not null,
  [QUESTIONNO] smallint,
  [INSTRUCTOR] int,
  [OWNER] int,
  [EMPLOYEENO] int,
  [PROGRAMID] nvarchar(8),
  [ACTION] nvarchar(2)
    constraint RI_1032
    references ACTIONS,
  [EVENTNO] int,
  [CYCLE] smallint,
  [LETTERNO] smallint,
  [ALTERNATELETTER] smallint,
  [COVERINGLETTERNO] smallint,
  [HOLDFLAG] decimal(1),
  [SPLITBILLFLAG] decimal(1),
  [BILLPERCENTAGE] decimal(5,2),
  [DEBITNOTENO] nvarchar(10),
  [ENTITYNO] int,
  [DEBTORNAMETYPE] nvarchar(3),
  [DEBITNOTEDETAIL] nvarchar(10),
  [LETTERDATE] datetime,
  [DELIVERYID] smallint,
  [ACTIVITYTYPE] smallint,
  [ACTIVITYCODE] int,
  [PROCESSED] decimal(1),
  [TRANSACTIONFLAG] decimal(1),
  [PRODUCECHARGES] decimal(1),
  [WHENOCCURRED] datetime,
  [STATUSCODE] smallint,
  [RATENO] int,
  [PAYFEECODE] nchar(1),
  [ENTEREDQUANTITY] int,
  [ENTEREDAMOUNT] decimal(11,2),
  [DISBCURRENCY] nvarchar(3),
  [DISBEXCHANGERATE] decimal(8,4),
  [SERVICECURRENCY] nvarchar(3),
  [SERVEXCHANGERATE] decimal(8,4),
  [BILLCURRENCY] nvarchar(3),
  [BILLEXCHANGERATE] decimal(8,4),
  [DISBTAXCODE] nvarchar(3),
  [SERVICETAXCODE] nvarchar(3),
  [DISBNARRATIVE] smallint,
  [SERVICENARRATIVE] smallint,
  [DISBAMOUNT] decimal(11,2),
  [SERVICEAMOUNT] decimal(11,2),
  [DISBTAXAMOUNT] decimal(11,2),
  [SERVICETAXAMOUNT] decimal(11,2),
  [TOTALDISCOUNT] decimal(11,2),
  [DISBWIPCODE] nvarchar(6),
  [SERVICEWIPCODE] nvarchar(6),
  [SYSTEMMESSAGE] nvarchar(254),
  [DISBEMPLOYEENO] int,
  [SERVEMPLOYEENO] int,
  [DISBORIGINALAMOUNT] decimal(11,2),
  [SERVORIGINALAMOUNT] decimal(11,2),
  [DISBBILLAMOUNT] decimal(11,2),
  [SERVBILLAMOUNT] decimal(11,2),
  [DISCBILLAMOUNT] decimal(11,2),
  [TAKENUPAMOUNT] decimal(11,2),
  [DISBDISCOUNT] decimal(11,2),
  [SERVDISCOUNT] decimal(11,2),
  [DISBBILLDISCOUNT] decimal(11,2),
  [SERVBILLDISCOUNT] decimal(11,2),
  [DISBCOSTLOCAL] decimal(11,2),
  [DISBCOSTORIGINAL] decimal(11,2),
  [DISBDISCORIGINAL] decimal(11,2),
  [SERVDISCORIGINAL] decimal(11,2),
  [ESTIMATEFLAG] decimal(1),
  [EMAILOVERRIDE] nvarchar(50),
  [DISBCOSTCALC1] decimal(11,2),
  [DISBCOSTCALC2] decimal(11,2),
  [SERVCOSTCALC1] decimal(11,2),
  [SERVCOSTCALC2] decimal(11,2),
  [IDENTITYID] int,
  [DEBTOR] int,
  [SEPARATEDEBTORFLAG] decimal(1),
  [PRODUCTCODE] int,
  [XMLINSTRUCTIONID] int,
  [CHECKLISTTYPE] smallint,
  [SERVCOSTLOCAL] decimal(11,2),
  [SERVCOSTORIGINAL] decimal(11,2),
  [FILENAME] nvarchar(254),
  [DIRECTPAYFLAG] bit,
  [ACTIVITYID] int identity,
  [BATCHNO] int,
  [EDEOUTPUTTYPE] int,
  [REQUESTID] int,
  [XMLFILTER] nvarchar(254),
  [DISBSTATETAXCODE] nvarchar(3),
  [SERVSTATETAXCODE] nvarchar(3),
  [DISBSTATETAXAMT] decimal(11,2),
  [SERVSTATETAXAMT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [GROUPACTIVITYID] int,
  [DISBMARGINNO] int,
  [SERVMARGINNO] int,
  [DISBMARGIN] decimal(11,2),
  [DISBHOMEMARGIN] decimal(11,2),
  [DISBBILLMARGIN] decimal(11,2),
  [SERVMARGIN] decimal(11,2),
  [SERVHOMEMARGIN] decimal(11,2),
  [SERVBILLMARGIN] decimal(11,2),
  [DISBDISCFORMARGIN] decimal(11,2),
  [DISBHOMEDISCFORMARGIN] decimal(11,2),
  [DISBBILLDISCFORMARGIN] decimal(11,2),
  [SERVDISCFORMARGIN] decimal(11,2),
  [SERVHOMEDISCFORMARGIN] decimal(11,2),
  [SERVBILLDISCFORMARGIN] decimal(11,2),
  constraint XPKACTIVITYREQUEST
  primary key (SQLUSER, ACTIVITYID)
)
;

create index XIE1ACTIVITYREQUEST
  on ACTIVITYREQUEST (CASEID, WHENREQUESTED, SQLUSER)
;

create index XIE2ACTIVITYREQUEST
  on ACTIVITYREQUEST (BATCHNO, EDEOUTPUTTYPE)
;

create index XIE3ACTIVITYREQUEST
  on ACTIVITYREQUEST (REQUESTID)
;

create index XIE4ACTIVITYREQUEST
  on ACTIVITYREQUEST (GROUPACTIVITYID)
;

create index XIE5ACTIVITYREQUEST
  on ACTIVITYREQUEST (LETTERNO)
;

create index XIE6ACTIVITYREQUEST
  on ACTIVITYREQUEST (PRODUCTCODE)
;

create index XIE7ACTIVITYREQUEST
  on ACTIVITYREQUEST (ACTIVITYCODE)
;

create index XIE8ACTIVITYREQUEST
  on ACTIVITYREQUEST (EDEOUTPUTTYPE)
;

create index XIE9ACTIVITYREQUEST
  on ACTIVITYREQUEST (DISBMARGINNO, SERVMARGINNO)
;

create table ADDRESS
(
  [ADDRESSCODE] int not null
    constraint XPKADDRESS
    primary key,
  [STREET1] nvarchar(254),
  [STREET2] nvarchar(254),
  [CITY] nvarchar(30),
  [STATE] nvarchar(20),
  [POSTCODE] nvarchar(10),
  [COUNTRYCODE] nvarchar(3) not null,
  [TELEPHONE] int,
  [FAX] int,
  [CITY_TID] int,
  [STATE_TID] int,
  [STREET1_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1ADDRESS
  on ADDRESS (COUNTRYCODE, STATE)
;

create index XIE2ADDRESS
  on ADDRESS (CITY)
;

create table ADDRESSTELECOM
(
  [ADDRESSCODE] int not null
    constraint R_889
    references ADDRESS,
  [TELECODE] int not null,
  [TELECOMDESC] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKADDRESSTELECOM
  primary key (ADDRESSCODE, TELECODE)
)
;

create table ADJUSTMENT
(
  [ADJUSTMENT] nvarchar(4) not null
    constraint XPKADJUSTMENT
    primary key,
  [ADJUSTMENTDESC] nvarchar(50),
  [ADJUSTDAY] decimal(2),
  [ADJUSTMONTH] decimal(2),
  [ADJUSTYEAR] decimal(4),
  [ADJUSTMENTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table AIRPORT
(
  [AIRPORTCODE] nvarchar(5) not null
    constraint XPKAIRPORT
    primary key,
  [AIRPORTNAME] nvarchar(30),
  [COUNTRYCODE] nvarchar(3),
  [STATE] nvarchar(20),
  [CITY] nvarchar(30),
  [AIRPORTNAME_TID] int,
  [CITY_TID] int,
  [STATE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ALERT
(
  [EMPLOYEENO] int not null,
  [ALERTSEQ] datetime not null,
  [CASEID] int,
  [ALERTMESSAGE] nvarchar(1000),
  [REFERENCE] nvarchar(20),
  [ALERTDATE] datetime,
  [DUEDATE] datetime,
  [DATEOCCURRED] datetime,
  [OCCURREDFLAG] decimal(1),
  [DELETEDATE] datetime,
  [STOPREMINDERSDATE] datetime,
  [MONTHLYFREQUENCY] smallint,
  [MONTHSLEAD] smallint,
  [DAILYFREQUENCY] smallint,
  [DAYSLEAD] smallint,
  [SEQUENCENO] int not null,
  [SENDELCTRONICALLY] decimal(1),
  [EMAILSUBJECT] nvarchar(100),
  [SENDELECTRONICALLY] decimal(1),
  [FROMCASEID] int,
  [EVENTNO] int,
  [CYCLE] smallint,
  [LETTERNO] smallint,
  [OVERRIDERULE] smallint,
  [TRIGGEREVENTNO] int,
  [SENDMETHOD] int,
  [SENTDATE] datetime,
  [RECEIPTDATE] datetime,
  [RECEIPTREFERENCE] nvarchar(50),
  [DISPLAYORDER] smallint,
  [IMPORTANCELEVEL] nvarchar(2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [NAMENO] int,
  [EMPLOYEEFLAG] bit default 0 not null,
  [SIGNATORYFLAG] bit default 0 not null,
  [CRITICALFLAG] bit default 0 not null,
  [NAMETYPE] nvarchar(3),
  [RELATIONSHIP] nvarchar(3),
  constraint XPKALERT
  primary key (EMPLOYEENO, ALERTSEQ)
)
;

create index XIE1ALERT
  on ALERT (CASEID)
;

create index XIE2ALERT
  on ALERT (ALERTDATE)
;

create index XIE3ALERT
  on ALERT (SENDMETHOD)
;

create index XIE4ALERT
  on ALERT (FROMCASEID, EVENTNO, CYCLE)
;

create table ALIASTYPE
(
  [ALIASTYPE] nvarchar(2) not null
    constraint XPKALIASTYPE
    primary key,
  [ALIASDESCRIPTION] nvarchar(30),
  [ALIASDESCRIPTION_TID] int,
  [MUSTBEUNIQUE] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table APPLICATIONBASIS
(
  [BASIS] nvarchar(2) not null
    constraint XPKAPPLICATIONBASIS
    primary key,
  [BASISDESCRIPTION] nvarchar(50),
  [CONVENTION] decimal(1),
  [BASISDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table APPLICATIONS
(
  [APPLICATIONNAME] nvarchar(20) not null
    constraint XPKAPPLICATIONS
    primary key,
  [DESCRIPTION] nvarchar(254),
  [PROGRAMNAME] nvarchar(20),
  [RUNTIMEPARMS] nvarchar(254),
  [PROGRAMPATH] nvarchar(50),
  [WORKINGDIRECTORY] nvarchar(50),
  [DISPLAYSEQUENCE] smallint,
  [MENUNAME] nvarchar(20),
  [HOWUSEDINDICATOR] smallint,
  [USECASEACCESS] bit,
  [APPLICATIONNAME_TID] int,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ASSIGNEDUSERS
(
  [SECURITYGROUP] nvarchar(30) not null,
  [USERID] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKASSIGNEDUSERS
  primary key (SECURITYGROUP, USERID)
)
;

create table ASSOCIATEDNAME
(
  [NAMENO] int not null,
  [RELATIONSHIP] nvarchar(3) not null,
  [RELATEDNAME] int not null,
  [SEQUENCE] smallint not null,
  [PROPERTYTYPE] nchar(1),
  [COUNTRYCODE] nvarchar(3),
  [ACTION] nvarchar(2)
    constraint R_1336
    references ACTIONS,
  [CONTACT] int,
  [JOBROLE] int,
  [USEINMAILING] decimal(1),
  [CEASEDDATE] datetime,
  [POSITIONCATEGORY] int,
  [POSITION] nvarchar(60),
  [TELEPHONE] int,
  [FAX] int,
  [MAINORGANISATION] decimal(1),
  [POSTALADDRESS] int
    constraint R_830
    references ADDRESS,
  [STREETADDRESS] int
    constraint R_831
    references ADDRESS,
  [USEINFORMAL] decimal(1),
  [VALEDICTION] int,
  [NOTES] nvarchar(254),
  [NOTES_TID] int,
  [POSITION_TID] int,
  [CRMONLY] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FORMATPROFILEID] int,
  constraint XPKEASSOCIATEDNAME
  primary key (NAMENO, RELATIONSHIP, RELATEDNAME, SEQUENCE)
)
;

create unique index XAK1ASSOCIATEDNAME
  on ASSOCIATEDNAME (RELATEDNAME, NAMENO, RELATIONSHIP, PROPERTYTYPE, COUNTRYCODE, ACTION, CONTACT, JOBROLE)
;

create index XIE2ASSOCIATEDNAME
  on ASSOCIATEDNAME (JOBROLE)
;

create index XIE3ASSOCIATEDNAME
  on ASSOCIATEDNAME (POSITIONCATEGORY)
;

create index XIE4ASSOCIATEDNAME
  on ASSOCIATEDNAME (VALEDICTION)
;

create table AUDITLOCATION
(
  [AUDITNUMBER] int not null,
  [SEQUENCENO] int not null,
  [CASEID] int,
  [FILEPARTID] smallint,
  [FILELOCATION] int,
  [IRN] nvarchar(30),
  [USERCODE] nvarchar(30),
  [AUDITDATE] datetime,
  [AUDITEDBY] nvarchar(18),
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKAUDITLOCATION
  primary key (AUDITNUMBER, SEQUENCENO)
)
;

create index XIE1AUDITLOCATION
  on AUDITLOCATION (CASEID)
;

create index XIE2AUDITLOCATION
  on AUDITLOCATION (FILELOCATION)
;

create table BANK
(
  [BANKCODE] nvarchar(4) not null
    constraint XPKBANK
    primary key,
  [BANKNAME] nvarchar(40),
  [BANKADDRESS] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table BANKACCOUNT
(
  [ACCOUNTOWNER] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [ISOPERATIONAL] decimal(1),
  [BANKBRANCHNO] nvarchar(10),
  [BRANCHNAMENO] int,
  [ACCOUNTNO] nvarchar(20) not null,
  [ACCOUNTNAME] nvarchar(80) not null,
  [CURRENCY] nvarchar(3) not null,
  [DESCRIPTION] nvarchar(80) not null,
  [ACCOUNTTYPE] int,
  [DRAWCHEQUESFLAG] decimal(1) not null,
  [LASTMANUALCHEQUE] nvarchar(30),
  [LASTAUTOCHEQUE] nvarchar(30),
  [ACCOUNTBALANCE] decimal(13,2),
  [LOCALBALANCE] decimal(13,2),
  [DATECEASED] datetime,
  [BICBANKCODE] nvarchar(4),
  [BICCOUNTRYCODE] nvarchar(2),
  [BICLOCATIONCODE] nvarchar(2),
  [BICBRANCHCODE] nvarchar(3),
  [IBAN] nvarchar(34),
  [BANKOPERATIONCODE] int,
  [DETAILSOFCHARGES] int,
  [EFTFILEFORMATUSED] int,
  [CABPROFITCENTRE] nvarchar(6),
  [CABACCOUNTID] int,
  [CABCPROFITCENTRE] nvarchar(6),
  [CABCACCOUNTID] int,
  [PROCAMOUNTTOWORDS] nvarchar(128),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [TRUSTACCTFLAG] bit default 0 not null,
  constraint XPKBANKACCOUNT
  primary key (ACCOUNTOWNER, BANKNAMENO, SEQUENCENO)
)
;

create index XIE1BANKACCOUNT
  on BANKACCOUNT (BANKOPERATIONCODE)
;

create index XIE2BANKACCOUNT
  on BANKACCOUNT (DETAILSOFCHARGES)
;

create index XIE3BANKACCOUNT
  on BANKACCOUNT (ACCOUNTTYPE)
;

create table BANKACCT
(
  [BANKCODE] nvarchar(4) not null
    constraint R_1297
    references BANK,
  [ACCOUNTNO] nvarchar(20) not null,
  [ACCOUNTNAME] nvarchar(50),
  [ACCOUNTBALANCE] decimal(12,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKBANKACCT
  primary key (BANKCODE, ACCOUNTNO)
)
;

create table BANKHISTORY
(
  [ENTITYNO] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [HISTORYLINENO] int not null,
  [TRANSDATE] datetime not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [PAYMENTMETHOD] int,
  [WITHDRAWALCHEQUENO] nvarchar(30),
  [TRANSTYPE] smallint not null,
  [MOVEMENTCLASS] smallint not null,
  [COMMANDID] smallint not null,
  [REFENTITYNO] int not null,
  [REFTRANSNO] int,
  [STATUS] smallint,
  [DESCRIPTION] nvarchar(254),
  [ASSOCLINENO] int,
  [PAYMENTCURRENCY] nvarchar(3),
  [PAYMENTAMOUNT] decimal(13,2),
  [BANKEXCHANGERATE] decimal(8,4),
  [BANKAMOUNT] decimal(13,2),
  [BANKCHARGES] decimal(9,2),
  [BANKNET] decimal(13,2),
  [LOCALAMOUNT] decimal(13,2),
  [LOCALCHARGES] decimal(13,2),
  [LOCALEXCHANGERATE] decimal(8,4),
  [LOCALNET] decimal(13,2),
  [BANKCATEGORY] smallint,
  [REFERENCE] nvarchar(30),
  [ISRECONCILED] decimal(1) not null,
  [GLMOVEMENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKBANKHISTORY
  primary key (ENTITYNO, BANKNAMENO, SEQUENCENO, HISTORYLINENO),
  constraint R_1420
  foreign key (ENTITYNO, BANKNAMENO, SEQUENCENO) references BANKACCOUNT
)
;

create index XIE1BANKHISTORY
  on BANKHISTORY (REFENTITYNO, REFTRANSNO)
;

create table BANKINGCATEGORY
(
  [BANKCATEGORY] smallint not null
    constraint XPKBANKINGCATEGORY
    primary key,
  [DESCRIPTION] nvarchar(60),
  [PRESENTPHYSICALLY] decimal(1),
  [BANKINTERVENTION] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table BANKHISTORY
  add constraint R_1426
foreign key (BANKCATEGORY) references BANKINGCATEGORY
;

create table BANKTRAN
(
  [BANKCODE] nvarchar(4) not null,
  [ACCOUNTNO] nvarchar(20) not null,
  [TRANNO] int not null,
  [TRANCODE] nvarchar(1),
  [TRANREFERENCE] nvarchar(20),
  [TRANDATE] datetime,
  [TRANDESC] nvarchar(50),
  [TRANAMOUNT] decimal(12,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKBANKTRAN
  primary key (BANKCODE, ACCOUNTNO, TRANNO),
  constraint R_1298
  foreign key (BANKCODE, ACCOUNTNO) references BANKACCT
)
;

create table BILLEDITEM
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [WIPENTITYNO] int not null,
  [WIPTRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [BILLEDVALUE] decimal(11,2),
  [ADJUSTEDVALUE] decimal(11,2),
  [REASONCODE] nvarchar(2),
  [ITEMENTITYNO] int,
  [ITEMTRANSNO] int,
  [ITEMLINENO] smallint,
  [ACCTENTITYNO] int,
  [ACCTDEBTORNO] int,
  [FOREIGNCURRENCY] nvarchar(3),
  [FOREIGNBILLEDVALUE] decimal(11,2),
  [FOREIGNADJUSTEDVALUE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [GENERATEDFROMTAXCODE] nvarchar(3),
  constraint XPKBILLEDITEM
  primary key (ENTITYNO, TRANSNO, WIPENTITYNO, WIPTRANSNO, WIPSEQNO),
  constraint R_1261
  foreign key (ACCTENTITYNO, ACCTDEBTORNO) references ACCOUNT
)
;

create index XIE1BILLEDITEM
  on BILLEDITEM (WIPTRANSNO, WIPENTITYNO, WIPSEQNO)
;

create table BILLFORMAT
(
  [BILLFORMATID] smallint not null
    constraint XPKBILLFORMAT
    primary key,
  [FORMATNAME] nvarchar(40) not null,
  [CREDITNOTEFLAG] decimal(1),
  [NAMENO] int,
  [LANGUAGE] int,
  [ENTITYNO] int,
  [CASETYPE] nchar(1),
  [ACTION] nvarchar(2)
    constraint R_1399
    references ACTIONS,
  [EMPLOYEENO] int,
  [BILLFORMATDESC] nvarchar(254),
  [BILLFORMATREPORT] nvarchar(254),
  [SORTEMPLOYEENO] smallint,
  [SORTDATE] smallint,
  [SORTCASE] smallint,
  [SORTWIPCATEGORY] smallint,
  [CONSOLIDATESC] smallint,
  [CONSOLIDATEPD] smallint,
  [CONSOLIDATEOR] smallint,
  [DETAILSREQUIRED] smallint,
  [CONSOLIDATEDISC] smallint,
  [EXPENSEGROUPTITLE] nvarchar(30),
  [CONSOLIDATECHTYP] smallint,
  [OFFICEID] int,
  [DEBITNOTE] smallint,
  [COVERINGLETTER] smallint,
  [PROPERTYTYPE] nchar(1),
  [RENEWALWIP] decimal(1),
  [SINGLECASE] decimal(1),
  [SORTCASEMODE] smallint,
  [SORTCASETITLE] smallint,
  [SORTCASEDEBTORREF] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FORMATPROFILEID] int,
  [CONSOLIDATEMAR] smallint
)
;

create index XIE1BILLFORMAT
  on BILLFORMAT (LANGUAGE)
;

create table BILLRULE
(
  [RULESEQNO] int not null
    constraint XPKBILLRULE
    primary key,
  [RULETYPE] int not null,
  [CASEID] int,
  [DEBTORNO] int,
  [ENTITYNO] int,
  [NAMECATEGORY] int,
  [LOCALCLIENTFLAG] decimal(1),
  [CASETYPE] nchar(1),
  [PROPERTYTYPE] nchar(1),
  [CASEACTION] nvarchar(2)
    constraint R_1482
    references ACTIONS,
  [BILLINGENTITY] int,
  [MINIMUMNETBILL] decimal(7,2),
  [WIPCODE] nvarchar(6),
  [CASECOUNTRY] nvarchar(3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1BILLRULE
  on BILLRULE (CASEID, DEBTORNO, ENTITYNO, NAMECATEGORY, LOCALCLIENTFLAG, CASETYPE, PROPERTYTYPE, CASEACTION, WIPCODE, CASECOUNTRY, RULETYPE)
;

create index XIE1BILLRULE
  on BILLRULE (RULETYPE)
;

create index XIE2BILLRULE
  on BILLRULE (NAMECATEGORY)
;

create table BUSINESSFUNCTION
(
  [FUNCTIONTYPE] smallint not null
    constraint XPKBUSINESSFUNCTION
    primary key,
  [DESCRIPTION] nvarchar(50) not null,
  [OWNERALLOWED] decimal(1) not null,
  [PRIVILEGESALLOWED] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1BUSINESSFUNCTION
  on BUSINESSFUNCTION (FUNCTIONTYPE, DESCRIPTION)
;

create table CASECATEGORY
(
  [CASETYPE] nchar(1) not null,
  [CASECATEGORY] nvarchar(2) not null,
  [CASECATEGORYDESC] nvarchar(50),
  [CONVENTIONLITERAL] nvarchar(30),
  [CASECATEGORYDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASECATEGORY
  primary key (CASETYPE, CASECATEGORY)
)
;

create table CASEFAMILY
(
  [FAMILY] nvarchar(20) not null
    constraint XPKCASEFAMILY
    primary key,
  [FAMILYTITLE] nvarchar(254),
  [FAMILYTITLE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table CASEIMAGE
(
  [CASEID] int not null,
  [IMAGEID] int not null,
  [IMAGETYPE] int,
  [IMAGESEQUENCE] smallint,
  [CASEIMAGEDESC] nvarchar(254),
  [FIRMELEMENTID] nvarchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEIMAGE
  primary key (CASEID, IMAGEID)
)
;

create index XIE1CASEIMAGE
  on CASEIMAGE (IMAGETYPE)
;

create table CASELOCATION
(
  [CASEID] int not null,
  [WHENMOVED] datetime not null,
  [FILEPARTID] smallint,
  [FILELOCATION] int,
  [BAYNO] nvarchar(20),
  [ISSUEDBY] int,
  [DATESCANNED] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASELOCATION
  primary key (CASEID, WHENMOVED)
)
;

create index XIE1CASELOCATION
  on CASELOCATION (FILELOCATION)
;

create index XIE2CASELOCATION
  on CASELOCATION (ISSUEDBY)
;

create table CASENAME
(
  [CASEID] int not null,
  [NAMETYPE] nvarchar(3) not null,
  [NAMENO] int not null,
  [SEQUENCE] smallint not null,
  [CORRESPONDNAME] int,
  [ADDRESSCODE] int
    constraint R_20015
    references ADDRESS,
  [REFERENCENO] nvarchar(80),
  [ASSIGNMENTDATE] datetime,
  [COMMENCEDATE] datetime,
  [EXPIRYDATE] datetime,
  [BILLPERCENTAGE] decimal(5,2),
  [INHERITED] decimal(1),
  [INHERITEDNAMENO] int,
  [INHERITEDRELATIONS] nvarchar(3),
  [INHERITEDSEQUENCE] smallint,
  [NAMEVARIANTNO] int,
  [DERIVEDCORRNAME] decimal(1) default 0 not null,
  [REMARKS] nvarchar(254),
  [CORRESPONDENCESENT] bit,
  [CORRESPONDENCERECEIVED] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CORRESPSENT] bit,
  [CORRESPRECEIVED] int,
  constraint XPKCASENAME
  primary key nonclustered (CASEID, NAMETYPE, NAMENO, SEQUENCE)
)
;

create clustered index XIE5CASENAME
  on CASENAME (CASEID)
;

create index XIE2CASENAME
  on CASENAME (CORRESPONDNAME)
;

create index XIE3CASENAME
  on CASENAME (REFERENCENO)
;

create index XIE4CASENAME
  on CASENAME (ADDRESSCODE)
;

create index XIE6CASENAME
  on CASENAME (NAMENO, NAMETYPE, CASEID, EXPIRYDATE)
;

create index XIE7CASENAME
  on CASENAME (INHERITEDNAMENO)
;

create index XIE8CASENAME
  on CASENAME (CORRESPRECEIVED)
;

create table CASEPROFITCENTRE
(
  [SEQUENCENO] smallint not null
    constraint XPKCASEPROFITCENTRE
    primary key,
  [COUNTRYCODE] nvarchar(3),
  [PROPERTYTYPE] nchar(1),
  [REGISTEREDFLAG] decimal(1),
  [INSTRUCTOR] int,
  [CASEID] int,
  [PROFITCENTRECODE] nvarchar(6),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CASEPROFITCENTRE
  on CASEPROFITCENTRE (CASEID)
;

create table CASERELATION
(
  [RELATIONSHIP] nvarchar(3) not null
    constraint XPKCASERELATION
    primary key,
  [EVENTNO] int,
  [EARLIESTDATEFLAG] decimal(1),
  [SHOWFLAG] decimal(1),
  [RELATIONSHIPDESC] nvarchar(50),
  [POINTERTOPARENT] decimal(1),
  [RELATIONSHIPDESC_TID] int,
  [DISPLAYEVENTONLY] decimal(1) default 0,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FROMEVENTNO] int,
  [DISPLAYEVENTNO] int,
  [PRIORARTFLAG] bit
)
;

create table CASES
(
  [CASEID] int not null
    constraint XPKCASES
    primary key,
  [IRN] nvarchar(30),
  [FAMILY] nvarchar(20)
    constraint R_893
    references CASEFAMILY,
  [STEM] nvarchar(30),
  [STATUSCODE] smallint,
  [CASETYPE] nchar(1) not null,
  [PROPERTYTYPE] nchar(1) not null,
  [COUNTRYCODE] nvarchar(3) not null,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2),
  [TYPEOFMARK] int,
  [TITLE] nvarchar(254),
  [NOINSERIES] smallint,
  [NOOFCLASSES] smallint,
  [LOCALCLASSES] nvarchar(254),
  [INTCLASSES] nvarchar(254),
  [LOCALCLIENTFLAG] decimal(1),
  [ENTITYSIZE] int,
  [PURCHASEORDERNO] nvarchar(80),
  [REPORTTOTHIRDPARTY] decimal(1),
  [CURRENTOFFICIALNO] nvarchar(36),
  [TAXCODE] nvarchar(3),
  [STOPPAYREASON] nchar(1),
  [EXTENDEDRENEWALS] int,
  [PREDECESSORID] int,
  [FILECOVER] int,
  [TITLE_TID] int,
  [BUDGETAMOUNT] decimal(11,2),
  [IPODELAY] int,
  [APPLICANTDELAY] int,
  [IPOPTA] int,
  [OFFICEID] int,
  [BUDGETREVISEDAMT] decimal(11,2),
  [STATETAXCODE] nvarchar(3),
  [SERVPERFORMEDIN] nvarchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROFITCENTRECODE] nvarchar(6),
  [NUMBEROFRESPONSES] int,
  [CAMPAIGNCOST] decimal(11,2),
  [LEADCOUNT] int,
  [OPPORTUNITYCOUNT] int
)
;

create index XIE1CASES
  on CASES (FAMILY)
;

create index XIE2CASES
  on CASES (STEM)
;

create index XIE3CASES
  on CASES (CASETYPE, PROPERTYTYPE, COUNTRYCODE)
;

create index XIE4CASES
  on CASES (PREDECESSORID)
;

create index XIE5CASES
  on CASES (FILECOVER)
;

create index XIE6CASES
  on CASES (IRN)
;

create index XIE7CASES
  on CASES (CASEID, IRN)
;

create index XIE8CASES
  on CASES (TYPEOFMARK)
;

create index XIE9CASES
  on CASES (ENTITYSIZE)
;

create index XIE100CASES
  on CASES (COUNTRYCODE, CASETYPE, CASEID, TITLE)
;

alter table ACTIVITYREQUEST
  add constraint R_880
foreign key (CASEID) references CASES
;

alter table ALERT
  add constraint R_1313
foreign key (CASEID) references CASES
;

alter table AUDITLOCATION
  add constraint R_30004
foreign key (CASEID) references CASES
;

alter table BILLRULE
  add constraint R_1476
foreign key (CASEID) references CASES
;

alter table CASEIMAGE
  add constraint R_20026
foreign key (CASEID) references CASES
;

alter table CASELOCATION
  add constraint R_930
foreign key (CASEID) references CASES
;

alter table CASENAME
  add constraint R_20027
foreign key (CASEID) references CASES
;

alter table CASEPROFITCENTRE
  add constraint RI_1231
foreign key (CASEID) references CASES
;

create table CASETYPE
(
  [CASETYPE] nchar(1) not null
    constraint XPKCASETYPE
    primary key,
  [CASETYPEDESC] nvarchar(50),
  [CASETYPEDESC_TID] int,
  [ACTUALCASETYPE] nchar(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CRMONLY] bit default 0,
  [KOTTEXTTYPE] nvarchar(2)
)
;

alter table BILLFORMAT
  add constraint R_1402
foreign key (CASETYPE) references CASETYPE
;

alter table BILLRULE
  add constraint R_1480
foreign key (CASETYPE) references CASETYPE
;

alter table CASECATEGORY
  add constraint R_20037
foreign key (CASETYPE) references CASETYPE
;

--alter table CASES
--  add constraint R_91862
--foreign key (CASETYPE) references CASETYPE
--;

create table CASEWORDS
(
  [CASEID] int not null
    constraint R_852
    references CASES,
  [KEYWORDNO] int not null,
  [FROMTITLE] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEWORDS
  primary key (CASEID, KEYWORDNO)
)
;

create index XIE1CASEWORDS
  on CASEWORDS (KEYWORDNO)
;

create table CASHHISTORY
(
  [ENTITYNO] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [TRANSENTITYNO] int not null,
  [TRANSNO] int not null,
  [HISTORYLINENO] smallint not null,
  [TRANSDATE] datetime not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [TRANSTYPE] int not null,
  [MOVEMENTCLASS] smallint not null,
  [COMMANDID] smallint not null,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [STATUS] smallint,
  [DESCRIPTION] nvarchar(254),
  [ASSOCIATEDLINENO] int,
  [ITEMREFNO] nvarchar(30),
  [ACCTENTITYNO] int,
  [ACCTNAMENO] int,
  [GLACCOUNTCODE] nvarchar(100),
  [DISSECTIONCURRENCY] nvarchar(3),
  [FOREIGNAMOUNT] decimal(13,2),
  [DISSECTIONEXCHANGE] decimal(8,4),
  [LOCALAMOUNT] decimal(13,2),
  [ITEMIMPACT] smallint,
  [GLMOVEMENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASHHISTORY
  primary key (ENTITYNO, BANKNAMENO, SEQUENCENO, TRANSENTITYNO, TRANSNO, HISTORYLINENO),
  constraint R_1437
  foreign key (ACCTENTITYNO, ACCTNAMENO) references ACCOUNT
)
;

create index XIE1CASHHISTORY
  on CASHHISTORY (REFENTITYNO, REFTRANSNO)
;

create index XIE2CASHHISTORY
  on CASHHISTORY (ACCTENTITYNO, ACCTNAMENO)
;

create table CASHITEM
(
  [ENTITYNO] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [TRANSENTITYNO] int not null,
  [TRANSNO] int not null,
  [ITEMDATE] datetime not null,
  [DESCRIPTION] nvarchar(254),
  [STATUS] smallint not null,
  [ITEMTYPE] int not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [CLOSEPOSTDATE] datetime,
  [CLOSEPOSTPERIOD] int,
  [TRADER] nvarchar(254),
  [ACCTENTITYNO] int,
  [ACCTNAMENO] int,
  [BANKEDBYENTITYNO] int,
  [BANKEDBYTRANSNO] int,
  [BANKCATEGORY] smallint
    constraint R_1431
    references BANKINGCATEGORY,
  [ITEMBANKBRANCHNO] nvarchar(10),
  [ITEMREFNO] nvarchar(30),
  [ITEMBANKNAME] nvarchar(60),
  [ITEMBANKBRANCH] nvarchar(60),
  [CREDITCARDTYPE] int,
  [CARDEXPIRYDATE] int,
  [PAYMENTCURRENCY] nvarchar(3),
  [PAYMENTAMOUNT] decimal(13,2),
  [BANKEXCHANGERATE] decimal(8,4),
  [BANKAMOUNT] decimal(13,2),
  [BANKCHARGES] decimal(9,2),
  [BANKNET] decimal(13,2),
  [DISSECTIONCURRENCY] nvarchar(3),
  [DISSECTIONAMOUNT] decimal(13,2),
  [DISSECTIONUNALLOC] decimal(13,2),
  [DISSECTIONEXCHANGE] decimal(8,4),
  [LOCALAMOUNT] decimal(13,2),
  [LOCALCHARGES] decimal(9,2),
  [LOCALEXCHANGERATE] decimal(8,4),
  [LOCALNET] decimal(13,2),
  [LOCALUNALLOCATED] decimal(13,2),
  [BANKOPERATIONCODE] int,
  [DETAILSOFCHARGES] int,
  [EFTFILEFORMAT] int,
  [EFTPAYMENTFILE] nvarchar(254),
  [FXDEALERREF] nvarchar(16),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [TRANSFERENTITYNO] int,
  [TRANSFERTRANSNO] int,
  [INSTRUCTIONCODE] int,
  constraint XPKCASHITEM
  primary key (ENTITYNO, BANKNAMENO, SEQUENCENO, TRANSENTITYNO, TRANSNO),
  constraint R_1427
  foreign key (ENTITYNO, BANKNAMENO, SEQUENCENO) references BANKACCOUNT
)
;

create index XIE1CASHITEM
  on CASHITEM (BANKEDBYENTITYNO, BANKEDBYTRANSNO)
;

create index XIE2CASHITEM
  on CASHITEM (TRANSFERENTITYNO, TRANSFERTRANSNO)
;

create index XIE3CASHITEM
  on CASHITEM (EFTFILEFORMAT)
;

create index XIE4CASHITEM
  on CASHITEM (INSTRUCTIONCODE)
;

create index XIE5CASHITEM
  on CASHITEM (CREDITCARDTYPE)
;

create index XIE6CASHITEM
  on CASHITEM (DETAILSOFCHARGES)
;

create index XIE7CASHITEM
  on CASHITEM (BANKOPERATIONCODE)
;

alter table CASHHISTORY
  add constraint R_1435
foreign key (ENTITYNO, BANKNAMENO, SEQUENCENO, TRANSENTITYNO, TRANSNO) references CASHITEM
;

create table CHECKLISTITEM
(
  [CRITERIANO] int not null,
  [QUESTIONNO] smallint not null,
  [SEQUENCENO] smallint,
  [QUESTION] nvarchar(100),
  [YESNOREQUIRED] decimal(1),
  [COUNTREQUIRED] decimal(1),
  [PERIODTYPEREQUIRED] decimal(1),
  [AMOUNTREQUIRED] decimal(1),
  [DATEREQUIRED] decimal(1),
  [EMPLOYEEREQUIRED] decimal(1),
  [TEXTREQUIRED] decimal(1),
  [PAYFEECODE] nchar(1),
  [UPDATEEVENTNO] int,
  [DUEDATEFLAG] decimal(1),
  [YESRATENO] int,
  [NORATENO] int,
  [YESCHECKLISTTYPE] smallint,
  [NOCHECKLISTTYPE] smallint,
  [INHERITED] decimal(1),
  [NODUEDATEFLAG] decimal(1),
  [NOEVENTNO] int,
  [ESTIMATEFLAG] decimal(1),
  [QUESTION_TID] int,
  [DIRECTPAYFLAG] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [SOURCEQUESTION] smallint,
  [ANSWERSOURCEYES] decimal(1),
  [ANSWERSOURCENO] decimal(1),
  constraint XPKCHECKLISTITEM
  primary key (CRITERIANO, QUESTIONNO)
)
;

create index XIE1CHECKLISTITEM
  on CHECKLISTITEM (UPDATEEVENTNO)
;

create table CHECKLISTLETTER
(
  [CRITERIANO] int not null,
  [LETTERNO] smallint not null,
  [QUESTIONNO] smallint,
  [REQUIREDANSWER] decimal(1),
  [INHERITED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCHECKLISTLETTER
  primary key (CRITERIANO, LETTERNO)
)
;

create index XIE1CHECKLISTLTR
  on CHECKLISTLETTER (CRITERIANO)
;

create table CHECKLISTS
(
  [CHECKLISTTYPE] smallint not null
    constraint XPKCHECKLISTS
    primary key,
  [CHECKLISTDESC] nvarchar(50),
  [CHECKLISTTYPEFLAG] decimal(1),
  [CHECKLISTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CHECKLISTITEM
  add constraint R_20047
foreign key (YESCHECKLISTTYPE) references CHECKLISTS
;

alter table CHECKLISTITEM
  add constraint R_20044
foreign key (NOCHECKLISTTYPE) references CHECKLISTS
;

create table CONTROLTOTAL
(
  [LEDGER] int not null,
  [CATEGORY] int not null,
  [TYPE] int not null,
  [PERIODID] int not null,
  [ENTITYNO] int not null,
  [TOTAL] decimal(11,2) default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCONTROLTOTAL
  primary key (LEDGER, CATEGORY, TYPE, PERIODID, ENTITYNO)
)
;

create table COPYPROFILE
(
  [PROFILENAME] nvarchar(50) not null,
  [SEQUENCENO] smallint not null,
  [COPYAREA] nvarchar(30) not null,
  [CHARACTERKEY] nvarchar(30),
  [NUMERICKEY] int,
  [REPLACEMENTDATA] nvarchar(254),
  [PROTECTCOPY] decimal(1),
  [STOPCOPY] decimal(1) default 0,
  [PROFILENAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCOPYPROFILE
  primary key (PROFILENAME, SEQUENCENO)
)
;

create unique index XAK1COPYPROFILE
  on COPYPROFILE (PROFILENAME, COPYAREA, CHARACTERKEY, NUMERICKEY)
;

create table CORRESPONDTO
(
  [CORRESPONDTYPE] smallint not null
    constraint XPKCORRESPONDTO
    primary key,
  [DESCRIPTION] nvarchar(50),
  [NAMETYPE] nvarchar(3),
  [COPIESTO] nvarchar(3),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table COSTTRACK
(
  [COSTID] int not null
    constraint XPKCOSTTRACK
    primary key,
  [AGENTNO] int,
  [ENTRYDATE] datetime not null,
  [INVOICEDATE] datetime,
  [INVOICEREF] nvarchar(12),
  [INVOICEAMT] decimal(11,2) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table COSTTRACKALLOC
(
  [COSTID] int not null
    constraint R_1500
    references COSTTRACK,
  [COSTALLOCNO] smallint not null,
  [CASEID] int not null
    constraint R_1502
    references CASES,
  [DEBTORNO] int not null,
  [COSTPERCENTAGE] decimal(5,2) not null,
  [ALLOCAMT] decimal(11,2) not null,
  [INTERNALCOSTFLAG] decimal(1) not null,
  [FAMILY] nvarchar(20)
    constraint R_1508
    references CASEFAMILY,
  [DIVISIONNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCOSTTRACKALLOC
  primary key (COSTID, COSTALLOCNO)
)
;

create index XIE1COSTTRACKALLOC
  on COSTTRACKALLOC (CASEID)
;

create table COUNTRY
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint XPKCountry
    primary key,
  [ALTERNATECODE] nvarchar(3),
  [COUNTRY] nvarchar(60),
  [INFORMALNAME] nvarchar(60),
  [COUNTRYABBREV] nvarchar(10),
  [COUNTRYADJECTIVE] nvarchar(60),
  [RECORDTYPE] nchar(1),
  [ISD] nvarchar(5),
  [STATELITERAL] nvarchar(20),
  [POSTCODELITERAL] nvarchar(20),
  [POSTCODEFIRST] decimal(1),
  [WORKDAYFLAG] smallint,
  [DATECOMMENCED] datetime,
  [DATECEASED] datetime,
  [NOTES] nvarchar(254),
  [STATEABBREVIATED] decimal(1),
  [ALLMEMBERSFLAG] decimal(1) not null,
  [NAMESTYLE] int,
  [ADDRESSSTYLE] int,
  [DEFAULTTAXCODE] nvarchar(3),
  [REQUIREEXEMPTTAXNO] decimal(1),
  [DEFAULTCURRENCY] nvarchar(3),
  [COUNTRY_TID] int,
  [COUNTRYADJECTIVE_TID] int,
  [INFORMALNAME_TID] int,
  [NOTES_TID] int,
  [POSTCODELITERAL_TID] int,
  [STATELITERAL_TID] int,
  [POSTCODESEARCHCODE] int,
  [POSTCODEAUTOFLAG] decimal(1),
  [POSTALNAME] nvarchar(60),
  [POSTALNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PRIORARTFLAG] bit
)
;

create index XIE1COUNTRY
  on COUNTRY (ALTERNATECODE)
;

create index XIE2COUNTRY
  on COUNTRY (NAMESTYLE)
;

create index XIE3COUNTRY
  on COUNTRY (ADDRESSSTYLE)
;

alter table ADDRESS
  add constraint R_20061
foreign key (COUNTRYCODE) references COUNTRY
;

alter table AIRPORT
  add constraint R_1328
foreign key (COUNTRYCODE) references COUNTRY
;

alter table ASSOCIATEDNAME
  add constraint RI_1125
foreign key (COUNTRYCODE) references COUNTRY
;

alter table BILLRULE
  add constraint R_91818
foreign key (CASECOUNTRY) references COUNTRY
;

alter table CASEPROFITCENTRE
  add constraint R_1234
foreign key (COUNTRYCODE) references COUNTRY
;

--alter table CASES
--  add constraint R_20054
--foreign key (COUNTRYCODE) references COUNTRY
--;

create table COUNTRYFLAGS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint RI_973
    references COUNTRY,
  [FLAGNUMBER] int not null,
  [FLAGNAME] nvarchar(30),
  [NATIONALALLOWED] decimal(1),
  [RESTRICTREMOVALFLG] decimal(1),
  [PROFILENAME] nvarchar(50),
  [STATUS] decimal(1) not null,
  [FLAGNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCOUNTRYFLAGS
  primary key (COUNTRYCODE, FLAGNUMBER)
)
;

create table COUNTRYGROUP
(
  [TREATYCODE] nvarchar(3) not null,
  [MEMBERCOUNTRY] nvarchar(3) not null,
  [DATECOMMENCED] datetime,
  [DATECEASED] datetime,
  [ASSOCIATEMEMBER] decimal(1),
  [DEFAULTFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PREVENTNATPHASE] bit,
  constraint XPKCOUNTRYGROUP
  primary key (TREATYCODE, MEMBERCOUNTRY)
)
;

create table CPADATA
(
  [RECORDTYPE] nchar(1) not null,
  [BATCHNO] int not null,
  [CASECODE] nchar(15),
  [SYSTEMID] nchar(3),
  [CASEID] int,
  [PROPERTYTYPE] nchar(1),
  [TRANSACTIONCODE] float,
  [OLDCASECODE] nchar(15),
  [CPACOUNTRYCODE] nchar(2),
  [RENEWALTYPECODE] nchar(2),
  [CLIENTCODE] nchar(8),
  [SMALLENTITY] nchar(1),
  [DIVISIONCODE] nchar(6),
  [CASEOFFICECODE] nchar(3),
  [DATE1] float,
  [DATE2] float,
  [DATE3] float,
  [DATE4] float,
  [DATE5] float,
  [DATE6] float,
  [OFFICIALNO1] nchar(15),
  [OFFICIALNO2] nchar(15),
  [OFFICIALNO3] nchar(15),
  [OFFICIALNO4] nchar(15),
  [OFFICIALNO5] nchar(15),
  [OFFICIALNO6] nchar(15),
  [OWNERCODE] nchar(6),
  [CLIENTREF1] nchar(15),
  [CLIENTREF2] nchar(20),
  [STARTPAYINGDATE] float,
  [STOPPAYINGDATE] float,
  [STOPPAYINGREASON] nchar(1),
  [FOREIGNASSOCCODE] nchar(8),
  [NOOFCLAIMS] float,
  [NOOFDESIGNSPRODTS] float,
  [NOOFCLASSES] float,
  [NOOFSTATES] float,
  [DESIGNATEDSTATES] nchar(100),
  [IPOWNER] nchar(35),
  [CPACLIENTNO] float,
  [CLIENTNAME] nchar(35),
  [ADDRESSLINES] nchar(175),
  [TELEPHONENO] nchar(20),
  [TELEXNO] nchar(20),
  [FAXNO] nchar(20),
  [POSTCODE] nchar(16),
  [NOOFYEARS] float,
  [EXPIRYYEAR] float,
  [RENEWALYEAR] float,
  [TRADEMARK] nchar(70),
  [INTERNATNLCLASSES] nchar(50),
  [NATIONALCLASSESS] nchar(50),
  [REGISTEREDUSER] nchar(35),
  [PARENTCOUNTRY] nchar(2),
  [PROPRTORADDRLINES] nchar(175),
  [CLIENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPADATA
  on CPADATA (CASEID, BATCHNO)
;

create index XIE2CPADATA
  on CPADATA (BATCHNO, CASEID)
;

create index XIE3CPADATA
  on CPADATA (CLIENTNO, BATCHNO)
;

create table CPADATACOPY
(
  [RECORDTYPE] nchar(1) not null,
  [BATCHNO] int not null,
  [CASECODE] nchar(15),
  [SYSTEMID] nchar(3),
  [CASEID] int,
  [PROPERTYTYPE] nchar(1),
  [TRANSACTIONCODE] float,
  [OLDCASECODE] nchar(15),
  [CPACOUNTRYCODE] nchar(2),
  [RENEWALTYPECODE] nchar(2),
  [CLIENTCODE] nchar(8),
  [SMALLENTITY] nchar(1),
  [DIVISIONCODE] nchar(6),
  [CASEOFFICECODE] nchar(3),
  [DATE1] float,
  [DATE2] float,
  [DATE3] float,
  [DATE4] float,
  [DATE5] float,
  [DATE6] float,
  [OFFICIALNO1] nchar(15),
  [OFFICIALNO2] nchar(15),
  [OFFICIALNO3] nchar(15),
  [OFFICIALNO4] nchar(15),
  [OFFICIALNO5] nchar(15),
  [OFFICIALNO6] nchar(15),
  [OWNERCODE] nchar(6),
  [CLIENTREF1] nchar(15),
  [CLIENTREF2] nchar(20),
  [STARTPAYINGDATE] float,
  [STOPPAYINGDATE] float,
  [STOPPAYINGREASON] nchar(1),
  [FOREIGNASSOCCODE] nchar(8),
  [NOOFCLAIMS] float,
  [NOOFDESIGNSPRODTS] float,
  [NOOFCLASSES] float,
  [NOOFSTATES] float,
  [DESIGNATEDSTATES] nchar(100),
  [IPOWNER] nchar(35),
  [CPACLIENTNO] float,
  [CLIENTNAME] nchar(35),
  [ADDRESSLINES] nchar(175),
  [TELEPHONENO] nchar(20),
  [TELEXNO] nchar(20),
  [FAXNO] nchar(20),
  [POSTCODE] nchar(16),
  [NOOFYEARS] float,
  [EXPIRYYEAR] float,
  [RENEWALYEAR] float,
  [TRADEMARK] nchar(70),
  [INTERNATNLCLASSES] nchar(50),
  [NATIONALCLASSESS] nchar(50),
  [REGISTEREDUSER] nchar(35),
  [PARENTCOUNTRY] nchar(2),
  [PROPRTORADDRLINES] nchar(175),
  [CLIENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPADATACOPY
  on CPADATACOPY (CASEID, BATCHNO)
;

create index XIE2CPADATACOPY
  on CPADATACOPY (CLIENTNO, BATCHNO)
;

create table CPADATARECEIVED
(
  [DATEOFPORTFOLIOLST] float not null,
  [BATCHNO] int not null,
  [AGENTCASECODE] nchar(15) not null,
  [CLIENTNO] float,
  [CLIENTCURRENCY] nchar(3),
  [COUNTRYCODE] nchar(2),
  [TYPENAME] nchar(16),
  [REGISTRATIONNO] nchar(15),
  [PARENTNO] nchar(15),
  [PCTNO] nchar(15),
  [FIRSTPRIORITYNO] nchar(15),
  [APPLICATIONNO] nchar(15),
  [PUBLICATIONNO] nchar(15),
  [GRANTNO] nchar(15),
  [NEXTRENEWALDATE] float,
  [BASEDATE] float,
  [EXPIRYDATE] float,
  [PARENTAPPLDATE] float,
  [PCTFILINGDATE] float,
  [FIRSTPRIORITYDATE] float,
  [APPLDATE] float,
  [PUBLICDATE] float,
  [GRANTDATE] float,
  [IPOWNER] nchar(35),
  [OWNERCODE] nchar(6),
  [CLIENTREF] nchar(35),
  [CLIENTCASECODE] nchar(15),
  [DIVISIONCODE] nchar(6),
  [DIVISIONNAME] nchar(35),
  [ANNUITY] float,
  [TRADEMARKREFERENCE] nchar(15),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCPADATARECEIVED
  primary key (DATEOFPORTFOLIOLST, BATCHNO, AGENTCASECODE)
)
;

create index XIE1CPADATARECEIVED
  on CPADATARECEIVED (AGENTCASECODE)
;

/*
create table [dbo].[CPAUPDATE]
(
	[NAMEID] [int],
	[CASEID] [int]
		constraint [R_1599]
		references CASES,
	[INSERTDATETIME] datetime default getdate(),
	[INSERTIDENTITYID] int,
	[INSERTUSERID] nvarchar(50),
	[INSERTTRIGGER] nvarchar(30),
	[INSERTAPPLICATION] nvarchar(128),
	[ROWID] int identity
		constraint XPKCPAUPDATE
		primary key,
	[LOGUSERID] nvarchar(50),
	[LOGIDENTITYID] int,
	[LOGTRANSACTIONNO] int,
	[LOGDATETIMESTAMP] datetime,
	[LOGAPPLICATION] nvarchar(128),
	[LOGOFFICEID] int
)
;

create index XIE1CPAUPDATE
	on CPAUPDATE (CASEID)
;

create index XIE2CPAUPDATE
	on CPAUPDATE (NAMEID)
;
*/

create table CRITERIA
(
  [CRITERIANO] int not null
    constraint XPKCRITERIA
    primary key,
  [PURPOSECODE] nchar(1),
  [CASETYPE] nchar(1),
  [ACTION] nvarchar(2)
    constraint R_20007
    references ACTIONS,
  [CHECKLISTTYPE] smallint
    constraint R_20042
    references CHECKLISTS,
  [PROGRAMID] nvarchar(8),
  [PROPERTYTYPE] nchar(1),
  [PROPERTYUNKNOWN] decimal(1),
  [COUNTRYCODE] nvarchar(3)
    constraint R_20058
    references COUNTRY,
  [COUNTRYUNKNOWN] decimal(1),
  [CASECATEGORY] nvarchar(2),
  [CATEGORYUNKNOWN] decimal(1),
  [SUBTYPE] nvarchar(2),
  [SUBTYPEUNKNOWN] decimal(1),
  [BASIS] nvarchar(2)
    constraint R_815
    references APPLICATIONBASIS,
  [REGISTEREDUSERS] nchar(1),
  [LOCALCLIENTFLAG] decimal(1),
  [TABLECODE] int,
  [RATENO] int,
  [DATEOFACT] datetime,
  [USERDEFINEDRULE] decimal(1),
  [RULEINUSE] decimal(1),
  [STARTDETAILENTRY] decimal(1),
  [BELONGSTOGROUP] decimal(1),
  [DESCRIPTION] nvarchar(254),
  [TYPEOFMARK] int,
  [RENEWALTYPE] int,
  [PARENTCRITERIA] int,
  [DESCRIPTION_TID] int,
  [CASEOFFICEID] int,
  [LINKTITLE] nvarchar(100),
  [LINKTITLE_TID] int,
  [LINKDESCRIPTION] nvarchar(254),
  [LINKDESCRIPTION_TID] int,
  [DOCITEMID] int,
  [URL] nvarchar(254),
  [ISPUBLIC] bit default 0 not null,
  [GROUPID] int,
  [PRODUCTCODE] int,
  [NEWCASETYPE] nchar(1),
  [NEWCOUNTRYCODE] nvarchar(3)
    constraint R_91505
    references COUNTRY,
  [NEWPROPERTYTYPE] nchar(1),
  [NEWCASECATEGORY] nvarchar(2),
  [PROFILENAME] nvarchar(50),
  [SYSTEMID] smallint,
  [DATAEXTRACTID] smallint,
  [RULETYPE] int,
  [REQUESTTYPE] nvarchar(50),
  [DATASOURCETYPE] int,
  [DATASOURCENAMENO] int,
  [RENEWALSTATUS] smallint,
  [STATUSCODE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROFILEID] int,
  constraint R_91504
  foreign key (NEWCASETYPE, NEWCASECATEGORY) references CASECATEGORY
)
;

create index XIE1CRITERIA
  on CRITERIA (PURPOSECODE, CASETYPE)
;

create index XIE10CRITERIA
  on CRITERIA (GROUPID)
;

create index XIE2CRITERIA
  on CRITERIA (ACTION)
;

create index XIE3CRITERIA
  on CRITERIA (CHECKLISTTYPE)
;

create index XIE4CRITERIA
  on CRITERIA (PROGRAMID)
;

create index XIE5CRITERIA
  on CRITERIA (RATENO)
;

create index XIE6CRITERIA
  on CRITERIA (RULETYPE)
;

create index XIE7CRITERIA
  on CRITERIA (DATASOURCETYPE)
;

create index XIE8CRITERIA
  on CRITERIA (TABLECODE)
;

create index XIE9CRITERIA
  on CRITERIA (PRODUCTCODE)
;

alter table CHECKLISTITEM
  add constraint R_934
foreign key (CRITERIANO) references CRITERIA
;

alter table CHECKLISTLETTER
  add constraint RI_935
foreign key (CRITERIANO) references CRITERIA
;

create table CRITERIACHANGES
(
  [WHENREQUESTED] datetime not null,
  [SQLUSER] nvarchar(30) not null,
  [CRITERIANO] int,
  [EVENTNO] int,
  [OLDCRITERIANO] int,
  [NEWCRITERIANO] int,
  [PROCESSED] decimal(1),
  [WHENOCCURRED] datetime,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCRITERIACHANGE
  primary key (WHENREQUESTED, SQLUSER)
)
;

create index XIE1CRITERIACHANGE
  on CRITERIACHANGES (EVENTNO)
;

create index XIE2CRITERIACHANGE
  on CRITERIACHANGES (PROCESSED)
;

create table CURRENCY
(
  [CURRENCY] nvarchar(3) not null
    constraint XPKCURRENCY
    primary key,
  [DESCRIPTION] nvarchar(40),
  [BUYFACTOR] decimal(8,4),
  [SELLFACTOR] decimal(8,4),
  [BANKRATE] decimal(8,4),
  [BUYRATE] decimal(8,4),
  [SELLRATE] decimal(8,4),
  [DATECHANGED] datetime,
  [ROUNDBILLEDVALUES] smallint,
  [DESCRIPTION_TID] int,
  [DECIMALPLACES] tinyint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table BANKACCOUNT
  add constraint R_1418
foreign key (CURRENCY) references CURRENCY
;

alter table BANKHISTORY
  add constraint R_1422
foreign key (PAYMENTCURRENCY) references CURRENCY
;

alter table CASHHISTORY
  add constraint R_1439
foreign key (DISSECTIONCURRENCY) references CURRENCY
;

alter table CASHITEM
  add constraint R_1433
foreign key (PAYMENTCURRENCY) references CURRENCY
;

alter table CASHITEM
  add constraint R_1434
foreign key (DISSECTIONCURRENCY) references CURRENCY
;

alter table COUNTRY
  add constraint R_62
foreign key (DEFAULTCURRENCY) references CURRENCY
;

create table DEBITNOTEDETAILS
(
  [DEBITNOTENUMBER] int not null
    constraint XPKDebitNoteDetails
    primary key,
  [DEBITNOTEDATE] datetime,
  [USERID] nvarchar(30),
  [IRN] nvarchar(30),
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table DEBITNOTEIMAGE
(
  [RULESEQNO] int not null
    constraint XPKDEBITNOTEIMAGE
    primary key,
  [LANGUAGECODE] int,
  [ENTITYNO] int,
  [DEBTORNO] int,
  [COUNTRYCODE] nvarchar(3)
    constraint R_1552
    references COUNTRY,
  [IMAGEID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DEBITNOTEIMAGE
  on DEBITNOTEIMAGE (LANGUAGECODE, ENTITYNO, DEBTORNO, COUNTRYCODE)
;

create index XIE1DEBITNOTEIMAGE
  on DEBITNOTEIMAGE (LANGUAGECODE)
;

create table DEBTOR_ITEM_TYPE
(
  [ITEM_TYPE_ID] smallint not null
    constraint XPKDEBTORSITEMTYPE
    primary key,
  [ABBREVIATION] nchar(2) not null,
  [DESCRIPTION] nchar(50) not null,
  [USEDBYBILLING] decimal(1),
  [INTERNAL] decimal(1),
  [TAKEUPONBILL] smallint,
  [CASHITEMFLAG] decimal(1),
  [DESCRIPTION_TID] int,
  [EVENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DEBTOR_ITEM_TYPE
  on DEBTOR_ITEM_TYPE (DESCRIPTION)
;

create table DEBTORSTATUS
(
  [BADDEBTOR] smallint not null
    constraint XPKDEBTORSTATUS
    primary key,
  [DEBTORSTATUS] nvarchar(50),
  [ACTIONFLAG] decimal(1),
  [CLEARPASSWORD] nvarchar(10),
  [DEBTORSTATUS_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table DEFAULTACTIVITY
(
  [ACTIVITYTYPE] int not null,
  [SEQUENCENO] smallint not null,
  [ACTIVITYCATEGORY] int,
  [WIPCODE] nvarchar(6),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDEFAULTACTIVITY
  primary key (ACTIVITYTYPE, SEQUENCENO)
)
;

create table TACTIVITYCODES
(
  [ACTIVITYCODE] [numeric](11, 0),
  [ACTIVITYNAME] nvarchar(50),
  [ACTIVITYTYPE] int,
  [ACTIVITYLA] int
)
;

create index XIE1DEFAULTACTIVITY
  on DEFAULTACTIVITY (ACTIVITYTYPE)
;

create index XIE2DEFAULTACTIVITY
  on DEFAULTACTIVITY (ACTIVITYCATEGORY)
;

create table DELIVERYMETHOD
(
  [DELIVERYID] smallint not null
    constraint XPKDELIVERYMETHOD
    primary key,
  [DELIVERYTYPE] int,
  [DESCRIPTION] nvarchar(254),
  [MACRO] nvarchar(254),
  [FILEDESTINATION] nvarchar(254),
  [RESOURCENO] int,
  [DESTINATIONSP] nvarchar(60),
  [DIGITALCERTIFICATE] ntext,
  [DESCRIPTION_TID] int,
  [EMAILSP] nvarchar(60),
  [NAMETYPE] nvarchar(3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1DELIVERYMETHOD
  on DELIVERYMETHOD (DELIVERYTYPE)
;

alter table ACTIVITYREQUEST
  add constraint R_1346
foreign key (DELIVERYID) references DELIVERYMETHOD
;

create table DETAILCONTROL
(
  [CRITERIANO] int not null
    constraint R_20065
    references CRITERIA,
  [ENTRYNUMBER] smallint not null,
  [ENTRYDESC] nvarchar(100),
  [TAKEOVERFLAG] decimal(1),
  [DISPLAYSEQUENCE] smallint,
  [STATUSCODE] smallint,
  [RENEWALSTATUS] smallint,
  [FILELOCATION] int,
  [NUMBERTYPE] nchar(1),
  [ATLEAST1FLAG] decimal(1),
  [USERINSTRUCTION] nvarchar(254),
  [INHERITED] decimal(1),
  [ENTRYCODE] nvarchar(10),
  [CHARGEGENERATION] decimal(1),
  [DISPLAYEVENTNO] int,
  [HIDEEVENTNO] int,
  [DIMEVENTNO] int,
  [SHOWTABS] decimal(1),
  [SHOWMENUS] decimal(1),
  [SHOWTOOLBAR] decimal(1),
  [ENTRYDESC_TID] int,
  [USERINSTRUCTION_TID] int,
  [PARENTCRITERIANO] int,
  [PARENTENTRYNUMBER] smallint,
  [POLICINGIMMEDIATE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDETAILCONTROL
  primary key (CRITERIANO, ENTRYNUMBER)
)
;

create index XIE1DETAILCONTROL
  on DETAILCONTROL (PARENTCRITERIANO, PARENTENTRYNUMBER)
;

create index XIE2DETAILCONTROL
  on DETAILCONTROL (FILELOCATION)
;

create table DETAILDATES
(
  [CRITERIANO] int not null,
  [ENTRYNUMBER] smallint not null,
  [EVENTNO] int not null,
  [OTHEREVENTNO] int,
  [DEFAULTFLAG] decimal(1),
  [EVENTATTRIBUTE] smallint,
  [DUEATTRIBUTE] smallint,
  [POLICINGATTRIBUTE] smallint,
  [PERIODATTRIBUTE] smallint,
  [OVREVENTATTRIBUTE] smallint,
  [OVRDUEATTRIBUTE] smallint,
  [JOURNALATTRIBUTE] smallint,
  [DISPLAYSEQUENCE] smallint,
  [INHERITED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [DUEDATERESPATTRIBUTE] smallint,
  constraint XPKDETAILDATES
  primary key (CRITERIANO, ENTRYNUMBER, EVENTNO),
  constraint R_20075
  foreign key (CRITERIANO, ENTRYNUMBER) references DETAILCONTROL
)
;

create index XIE1DETAILDATES
  on DETAILDATES (EVENTNO)
;

create index XIE2DETAILDATES
  on DETAILDATES (OTHEREVENTNO)
;

create table DETAILLETTERS
(
  [CRITERIANO] int not null,
  [ENTRYNUMBER] smallint not null,
  [LETTERNO] smallint not null,
  [MANDATORYFLAG] decimal(1),
  [DELIVERYMETHODFLAG] decimal(1),
  [INHERITED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDETAILLETTERS
  primary key (CRITERIANO, ENTRYNUMBER, LETTERNO),
  constraint R_20076
  foreign key (CRITERIANO, ENTRYNUMBER) references DETAILCONTROL
)
;

create table DISCOUNT
(
  [NAMENO] int,
  [SEQUENCE] smallint not null,
  [PROPERTYTYPE] nchar(1),
  [ACTION] nvarchar(2)
    constraint RI_927
    references ACTIONS,
  [DISCOUNTRATE] decimal(6,3),
  [WIPCATEGORY] nvarchar(3),
  [BASEDONAMOUNT] decimal(1),
  [WIPTYPEID] nvarchar(6),
  [EMPLOYEENO] int,
  [PRODUCTCODE] int,
  [CASEOWNER] int,
  [DISCOUNTID] int identity
    constraint XPKDISCOUNT
    primary key,
  [MARGINPROFILENO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DISCOUNT
  on DISCOUNT (DISCOUNTID, NAMENO, SEQUENCE)
;

create index XIE1DISCOUNT
  on DISCOUNT (NAMENO, SEQUENCE)
;

create index XIE2DISCOUNT
  on DISCOUNT (PRODUCTCODE)
;

create table DOCUMENT
(
  [DOCUMENTNO] smallint not null
    constraint XPKDOCUMENT
    primary key,
  [DOCDESCRIPTION] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table DUEDATECALC
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [SEQUENCE] smallint not null,
  [CYCLENUMBER] smallint,
  [COUNTRYCODE] nvarchar(3)
    constraint R_976
    references COUNTRY,
  [FROMEVENT] int,
  [RELATIVECYCLE] smallint,
  [OPERATOR] nchar(1),
  [DEADLINEPERIOD] smallint,
  [PERIODTYPE] nchar(1),
  [EVENTDATEFLAG] smallint,
  [ADJUSTMENT] nvarchar(4)
    constraint R_20016
    references ADJUSTMENT,
  [MUSTEXIST] decimal(1),
  [COMPARISON] nvarchar(2),
  [COMPAREEVENT] int,
  [WORKDAY] decimal(1),
  [MESSAGE2FLAG] decimal(1),
  [SUPPRESSREMINDERS] decimal(1),
  [OVERRIDELETTER] smallint,
  [INHERITED] decimal(1),
  [COMPAREEVENTFLAG] smallint,
  [COMPARECYCLE] smallint,
  [COMPARERELATIONSHIP] nvarchar(3),
  [COMPAREDATE] datetime,
  [COMPARESYSTEMDATE] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDUEDATECALC
  primary key (CRITERIANO, EVENTNO, SEQUENCE)
)
;

create index XIE1DUEDATECALC
  on DUEDATECALC (FROMEVENT, CRITERIANO)
;

create index XIE2DUEDATECALC
  on DUEDATECALC (EVENTNO)
;

create index XIE3DUEDATECALC
  on DUEDATECALC (COMPAREEVENT, CRITERIANO, EVENTNO, COMPARECYCLE)
;

create table EMPLOYEE
(
  [EMPLOYEENO] int not null
    constraint XPKEMPLOYEE
    primary key,
  [ABBREVIATEDNAME] nvarchar(10),
  [STAFFCLASS] int,
  [SIGNOFFTITLE] nvarchar(50),
  [SIGNOFFNAME] nvarchar(50),
  [STARTDATE] datetime,
  [ENDDATE] datetime,
  [CAPACITYTOSIGN] int,
  [PROFITCENTRECODE] nvarchar(6),
  [RESOURCENO] int,
  [SIGNOFFNAME_TID] int,
  [SIGNOFFTITLE_TID] int,
  [DEFAULTENTITYNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EMPLOYEE
  on EMPLOYEE (CAPACITYTOSIGN)
;

create index XIE2EMPLOYEE
  on EMPLOYEE (STAFFCLASS)
;

create table EVENTS
(
  [EVENTNO] int not null
    constraint XPKEVENTS
    primary key,
  [EVENTCODE] nvarchar(10),
  [EVENTDESCRIPTION] nvarchar(100),
  [NUMCYCLESALLOWED] smallint,
  [IMPORTANCELEVEL] nvarchar(2),
  [CONTROLLINGACTION] nvarchar(2)
    constraint RI_1108
    references ACTIONS,
  [DEFINITION] nvarchar(254),
  [DEFINITION_TID] int,
  [EVENTDESCRIPTION_TID] int,
  [CLIENTIMPLEVEL] nvarchar(2),
  [CATEGORYID] smallint,
  [PROFILEREFNO] int,
  [RECALCEVENTDATE] bit default 0,
  [DRAFTEVENTNO] int
    constraint R_91782
    references EVENTS,
  [EVENTGROUP] int,
  [ACCOUNTINGEVENTFLAG] bit,
  [POLICINGIMMEDIATE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EVENTS
  on EVENTS (EVENTCODE)
;

create index XIE2EVENTS
  on EVENTS (IMPORTANCELEVEL, CLIENTIMPLEVEL)
;

create index XIE3EVENTS
  on EVENTS (EVENTDESCRIPTION)
;

create index XIE4EVENTS
  on EVENTS (CONTROLLINGACTION)
;

create index XIE5EVENTS
  on EVENTS (EVENTGROUP)
;

alter table ALERT
  add constraint R_82
foreign key (TRIGGEREVENTNO) references EVENTS
;

alter table CASERELATION
  add constraint RI_947
foreign key (EVENTNO) references EVENTS
;

alter table CASERELATION
  add constraint R_81575
foreign key (FROMEVENTNO) references EVENTS
;

alter table CASERELATION
  add constraint R_81576
foreign key (DISPLAYEVENTNO) references EVENTS
;

alter table CHECKLISTITEM
  add constraint R_20086
foreign key (UPDATEEVENTNO) references EVENTS
;

alter table CHECKLISTITEM
  add constraint R_1489
foreign key (NOEVENTNO) references EVENTS
;

alter table DEBTOR_ITEM_TYPE
  add constraint R_91893
foreign key (EVENTNO) references EVENTS
;

alter table DETAILCONTROL
  add constraint R_232
foreign key (DISPLAYEVENTNO) references EVENTS
;

alter table DETAILCONTROL
  add constraint R_233
foreign key (HIDEEVENTNO) references EVENTS
;

alter table DETAILCONTROL
  add constraint R_234
foreign key (DIMEVENTNO) references EVENTS
;

alter table DETAILDATES
  add constraint R_20088
foreign key (EVENTNO) references EVENTS
;

alter table DETAILDATES
  add constraint R_20089
foreign key (OTHEREVENTNO) references EVENTS
;

alter table DUEDATECALC
  add constraint R_977
foreign key (FROMEVENT) references EVENTS
;

alter table DUEDATECALC
  add constraint R_20126
foreign key (COMPAREEVENT) references EVENTS
;

create table EVENTSREPLACED
(
  [OLDEVENTNO] int not null
    constraint XPKEVENTSREPLACED
    primary key,
  [EVENTNO] int
    constraint R_1327
    references EVENTS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table EXCHANGERATEHIST
(
  [CURRENCY] nvarchar(3) not null
    constraint RI_1192
    references CURRENCY,
  [DATEEFFECTIVE] datetime not null,
  [BANKRATE] decimal(8,4),
  [BUYFACTOR] numeric(8,4),
  [BUYRATE] decimal(8,4),
  [SELLFACTOR] numeric(8,4),
  [SELLRATE] decimal(8,4),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEXCHANGERATEH
  primary key (CURRENCY, DATEEFFECTIVE)
)
;

create table EXPENSEIMPORT
(
  [IMPORTBATCHNO] int not null,
  [TRANSNO] int not null,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [EMPLOYEENO] int,
  [NAMENO] int,
  [CASEID] int
    constraint R_1485
    references CASES,
  [ENTITYNAMECODE] nvarchar(20),
  [IRN] nvarchar(30),
  [NAMECODE] nvarchar(20),
  [ENTITYNAMENO] int,
  [TRANSDATE] datetime,
  [WIPCODE] nvarchar(6),
  [RATENO] int,
  [EMPLOYEECODE] nvarchar(20),
  [IMPORTAMOUNT] decimal(11,2),
  [FOREIGNCURRENCY] nvarchar(3),
  [FOREIGNAMOUNT] decimal(11,2),
  [INVOICENO] nvarchar(20),
  [SUPPLIERNAMECODE] nvarchar(20),
  [NARRATIVE] nvarchar(254),
  [REJECTREASON] nvarchar(254),
  [SUPPLIERNAMENO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEXPENSEIMPORT
  primary key (IMPORTBATCHNO, TRANSNO)
)
;

create index XIE1EXPENSEIMPORT
  on EXPENSEIMPORT (EMPLOYEENO)
;

create index XIE2EXPENSEIMPORT
  on EXPENSEIMPORT (NAMENO)
;

create index XIE3EXPENSEIMPORT
  on EXPENSEIMPORT (SUPPLIERNAMENO)
;

create index XIE4EXPENSEIMPORT
  on EXPENSEIMPORT (CASEID)
;

create table FEELIST
(
  [FEELISTNO] int not null
    constraint XPKFEELIST
    primary key,
  [CURRENCY] nvarchar(3)
    constraint R_1519
    references CURRENCY,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1086
    references COUNTRY,
  [PROPERTYTYPE] nchar(1),
  [FEELISTDESC] nvarchar(50),
  [DATEPRINTED] datetime,
  [BATCHNUMBER] nchar(9),
  [REGISTEREDFLAG] decimal(1),
  [TAXABLE] decimal(1),
  [OFFICEID] int,
  [FEELISTNAME] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CASETYPE] nchar(1),
  [CASECATEGORY] nvarchar(2),
  [IPOFFICE] int,
  constraint R_91449
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create index XIE1FEELIST
  on FEELIST (BATCHNUMBER)
;

create table FEELISTCASE
(
  [WHENREQUESTED] datetime not null,
  [FEELISTITEM] int not null,
  [TAXCODE] nvarchar(3),
  [FEELISTNO] int
    constraint RI_1056
    references FEELIST,
  [FEETYPE] nvarchar(6),
  [CASEID] int
    constraint R_809
    references CASES,
  [OFFICIALNUMBER] nvarchar(36),
  [NUMBERTYPE] nchar(1),
  [BASEFEEAMOUNT] decimal(11,2),
  [ADDITIONALFEE] decimal(11,2),
  [FOREIGNFEEAMOUNT] decimal(11,2),
  [CURRENCY] nvarchar(3)
    constraint R_812
    references CURRENCY,
  [OWNERNAME] nvarchar(50),
  [QUANTITYINCALC] int,
  [QUANTITYDESC] int,
  [TOBEPAID] decimal(1),
  [TAXAMOUNT] decimal(11,2),
  [TOTALFEE] decimal(11,2),
  [AGEOFCASE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  constraint XPKFEELISTCASE
  primary key (WHENREQUESTED, FEELISTITEM)
)
;

create index XIE1FEELISTCASE
  on FEELISTCASE (FEELISTNO)
;

create index XIE2FEELISTCASE
  on FEELISTCASE (CASEID)
;

create index XIE3FEELISTCASE
  on FEELISTCASE (QUANTITYDESC)
;

create index XIE4FEELISTCASE
  on FEELISTCASE (REFENTITYNO, REFTRANSNO)
;

create table FEESCALCULATION
(
  [CRITERIANO] int not null
    constraint R_20067
    references CRITERIA,
  [UNIQUEID] smallint not null,
  [AGENT] int,
  [DEBTORTYPE] int,
  [DEBTOR] int,
  [CYCLENUMBER] smallint,
  [VALIDFROMDATE] datetime,
  [DEBITNOTE] smallint,
  [COVERINGLETTER] smallint,
  [GENERATECHARGES] decimal(1),
  [FEETYPE] nvarchar(6),
  [IPOFFICEFEEFLAG] decimal(1),
  [DISBCURRENCY] nvarchar(3)
    constraint R_20072
    references CURRENCY,
  [DISBTAXCODE] nvarchar(3),
  [DISBNARRATIVE] smallint,
  [DISBWIPCODE] nvarchar(6),
  [DISBBASEFEE] decimal(11,2),
  [DISBMINFEEFLAG] decimal(1),
  [DISBVARIABLEFEE] decimal(11,2),
  [DISBADDPERCENTAGE] decimal(5,4),
  [DISBUNITSIZE] smallint,
  [DISBBASEUNITS] smallint,
  [SERVICECURRENCY] nvarchar(3)
    constraint R_20073
    references CURRENCY,
  [SERVTAXCODE] nvarchar(3),
  [SERVICENARRATIVE] smallint,
  [SERVWIPCODE] nvarchar(6),
  [SERVBASEFEE] decimal(11,2),
  [SERVMINFEEFLAG] decimal(1),
  [SERVVARIABLEFEE] decimal(11,2),
  [SERVADDPERCENTAGE] decimal(5,4),
  [SERVDISBPERCENTAGE] decimal(5,4),
  [SERVUNITSIZE] smallint,
  [SERVBASEUNITS] smallint,
  [INHERITED] decimal(1),
  [PARAMETERSOURCE] smallint,
  [DISBMAXUNITS] smallint,
  [SERVMAXUNITS] smallint,
  [DISBEMPLOYEENO] int,
  [SERVEMPLOYEENO] int,
  [VARBASEFEE] decimal(11,2),
  [VARBASEUNITS] smallint,
  [VARVARIABLEFEE] decimal(11,2),
  [VARUNITSIZE] smallint,
  [VARMAXUNITS] smallint,
  [VARMINFEEFLAG] decimal(1),
  [WRITEUPREASON] nvarchar(2),
  [VARWIPCODE] nvarchar(6),
  [VARFEEAPPLIES] decimal(1),
  [OWNER] int,
  [INSTRUCTOR] int,
  [PRODUCTCODE] int,
  [PARAMETERSOURCE2] smallint,
  [FEETYPE2] nvarchar(6),
  [FROMEVENTNO] int
    constraint R_91812
    references EVENTS,
  [DISBSTAFFNAMETYPE] nvarchar(3),
  [SERVSTAFFNAMETYPE] nvarchar(3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [DISBDISCFEEFLAG] bit,
  [SERVDISCFEEFLAG] bit,
  constraint XPKFEESCALCULATION
  primary key (CRITERIANO, UNIQUEID)
)
;

create unique index XAK1FEESCALCULATION
  on FEESCALCULATION (CRITERIANO, DEBTORTYPE, AGENT, DEBTOR, CYCLENUMBER, VALIDFROMDATE, OWNER, INSTRUCTOR, FROMEVENTNO)
;

create index XIE1FEESCALCULATION
  on FEESCALCULATION (PRODUCTCODE)
;

create index XIE2FEESCALCULATION
  on FEESCALCULATION (DEBTORTYPE)
;

create table FEETYPES
(
  [FEETYPE] nvarchar(6) not null
    constraint XPKFEETYPES
    primary key,
  [FEENAME] nvarchar(50),
  [REPORTFORMAT] nchar(1),
  [RATENO] int,
  [WIPCODE] nvarchar(6),
  [FEENAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ACCOUNTOWNER] int,
  [BANKNAMENO] int,
  [ACCOUNTSEQUENCENO] int,
  constraint R_81595
  foreign key (ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO) references BANKACCOUNT
)
;

create index XIE1FEETYPES
  on FEETYPES (ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO)
;

alter table FEELISTCASE
  add constraint RI_1021
foreign key (FEETYPE) references FEETYPES
;

alter table FEESCALCULATION
  add constraint R_1022
foreign key (FEETYPE) references FEETYPES
;

alter table FEESCALCULATION
  add constraint R_91638
foreign key (FEETYPE2) references FEETYPES
;

create table FIELDCONTROL
(
  [CRITERIANO] int not null,
  [SCREENNAME] nvarchar(32) not null,
  [SCREENID] smallint not null,
  [FIELDNAME] nvarchar(32) not null,
  [ATTRIBUTES] int,
  [FIELDLITERAL] nvarchar(40),
  [INHERITED] decimal(1),
  [FIELDLITERAL_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFIELDCONTROL
  primary key (CRITERIANO, SCREENNAME, SCREENID, FIELDNAME)
)
;

create table FILEPART
(
  [CASEID] int not null
    constraint R_1386
    references CASES,
  [FILEPART] smallint not null,
  [FILEPARTTITLE] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [RFID] nvarchar(32),
  [FILEPARTTYPE] int,
  [FILERECORDSTATUS] int,
  [ISMAINFILE] bit default 0,
  constraint XPKFILEPART
  primary key (CASEID, FILEPART)
)
;

create table FILEREQUEST
(
  [CASEID] int not null
    constraint R_1372
    references CASES,
  [FILELOCATION] int not null,
  [SEQUENCENO] smallint not null,
  [EMPLOYEENO] int,
  [FILEPARTID] smallint,
  [DATEOFREQUEST] datetime,
  [DATEREQUIRED] datetime,
  [REMARKS] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [RESOURCENO] int,
  [PRIORITY] int,
  [STATUS] int,
  constraint XPKFILEREQUEST
  primary key (CASEID, FILELOCATION, SEQUENCENO)
)
;

create index XIE1FILEREQUEST
  on FILEREQUEST (DATEREQUIRED, CASEID)
;

create index XIE2FILEREQUEST
  on FILEREQUEST (FILELOCATION)
;

create table FILESIN
(
  [NAMENO] int not null,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_920
    references COUNTRY,
  [NOTES] nvarchar(254),
  [NOTES_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFILESIN
  primary key (NAMENO, COUNTRYCODE)
)
;

create index XIE1FILESIN
  on FILESIN (COUNTRYCODE)
;

create table FORMFIELDS
(
  [DOCUMENTNO] smallint not null,
  [FIELDNAME] nvarchar(40) not null,
  [FIELDTYPE] smallint not null,
  [ITEM_ID] int,
  [FIELDDESCRIPTION] nvarchar(254),
  [ITEMPARAMETER] ntext,
  [RESULTSEPARATOR] nvarchar(10),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1FORMFIELDS
  on FORMFIELDS (DOCUMENTNO, FIELDNAME)
;

create table FUNCTIONSECURITY
(
  [FUNCTIONTYPE] smallint not null
    constraint R_1471
    references BUSINESSFUNCTION,
  [SEQUENCENO] smallint not null,
  [OWNERNO] int,
  [ACCESSSTAFFNO] int,
  [ACCESSGROUP] smallint,
  [ACCESSPRIVILEGES] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFUNCTIONSECURITY
  primary key (FUNCTIONTYPE, SEQUENCENO)
)
;

create unique index XAK1FUNCTIONSECURITY
  on FUNCTIONSECURITY (FUNCTIONTYPE, OWNERNO, ACCESSSTAFFNO, ACCESSGROUP)
;

create table GENERALLEDGERACCTS
(
  [GLACCOUNTCODE] nvarchar(100) not null
    constraint XPKGENERALLEDGERACCTS
    primary key,
  [GLACCOUNTDESC] nvarchar(60),
  [LEDGERACCOUNTID] int,
  [ENTITYNO] int,
  [PROFITCENTRECODE] nvarchar(6),
  [DERIVETRANENTITY] decimal(1) default 0 not null,
  [DERIVEPCCASESTAFF] decimal(1) default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [DERIVEPCRAISEDSTAFF] decimal(1) default 0 not null
)
;

create index XIE1GENERALLEDGERACCTS
  on GENERALLEDGERACCTS (ENTITYNO, PROFITCENTRECODE, LEDGERACCOUNTID)
;

alter table CASHHISTORY
  add constraint R_1438
foreign key (GLACCOUNTCODE) references GENERALLEDGERACCTS
;

create table GLACCOUNTDEFAULTS
(
  [LEDGERID] smallint not null,
  [MOVEMENTCLASS] smallint not null,
  [AMOUNTTYPE] int not null,
  [DEFAULTSIGN] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLACCOUNTDEFAULTS
  primary key (LEDGERID, MOVEMENTCLASS, AMOUNTTYPE)
)
;

create index XIE1GLACCOUNTDEFAULTS
  on GLACCOUNTDEFAULTS (AMOUNTTYPE)
;

create table GLACCOUNTING
(
  [ACCOUNTTYPE] smallint not null,
  [MOVEMENTCLASS] smallint not null,
  [AMOUNTTYPE] int not null,
  [AMOUNTSIGN] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLACCOUNTING
  primary key (ACCOUNTTYPE, MOVEMENTCLASS)
)
;

create index XIE1GLACCOUNTING
  on GLACCOUNTING (AMOUNTTYPE)
;

create table GLACCOUNTMAPPING
(
  [RULESEQNO] int not null
    constraint XPKGLACCOUNTMAPPING
    primary key,
  [ACCOUNTTYPE] smallint not null,
  [ENTITY] int,
  [WIPINADVANCE] decimal(1),
  [WIPCODE] nvarchar(6),
  [WIPTYPEID] nvarchar(6),
  [WIPCATEGORYCODE] nvarchar(3),
  [WIPEMPLOYEENO] int,
  [LOCALCLIENTFLAG] decimal(1),
  [CASETYPE] nchar(1)
    constraint R_1578
    references CASETYPE,
  [PROPERTYTYPE] nchar(1),
  [COUNTRY] nvarchar(3)
    constraint R_1580
    references COUNTRY,
  [ACTION] nvarchar(2)
    constraint R_1581
    references ACTIONS,
  [REASONCODE] nvarchar(2),
  [DEBTFROMWIP] decimal(1),
  [BANKENTITYNO] int,
  [BANKNAMENO] int,
  [BANKSEQUENCENO] int,
  [GLACCOUNTCODE] nvarchar(100),
  [INTERNALWORKFLAG] decimal(1),
  [DEBTORITEMTYPE] smallint
    constraint R_63
    references DEBTOR_ITEM_TYPE,
  [STAFFCLASS] int,
  [CURRENCY] nvarchar(3)
    constraint R_244
    references CURRENCY,
  [SOURCEOFFICEID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_1583
  foreign key (BANKENTITYNO, BANKNAMENO, BANKSEQUENCENO) references BANKACCOUNT
)
;

create index XIE1GLACCOUNTMAPPING
  on GLACCOUNTMAPPING (STAFFCLASS)
;

create table GLFIELDRULE
(
  [FIELDNO] smallint not null,
  [ACCOUNTTYPE] smallint not null,
  [SEPARATOR] nvarchar(10),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLFIELDRULE
  primary key (FIELDNO, ACCOUNTTYPE)
)
;

create table GLFIELDRULECONTENT
(
  [FIELDNO] smallint not null,
  [ACCOUNTTYPE] smallint not null,
  [SEGMENTNO] smallint not null,
  [CONTENTID] smallint,
  [LITERAL] nvarchar(254),
  [NAMETYPE] nvarchar(3),
  [NAMEDATA] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLFIELDRULECONTENT
  primary key (FIELDNO, ACCOUNTTYPE, SEGMENTNO),
  constraint R_1592
  foreign key (FIELDNO, ACCOUNTTYPE) references GLFIELDRULE
)
;

create index XIE1GLFIELDRULECONTENT
  on GLFIELDRULECONTENT (NAMEDATA)
;

create table GLJOURNAL
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [DESIGNATION] tinyint not null,
  [POSTPERIOD] int,
  [CREATIONDATE] datetime,
  [DATELASTUPDATED] datetime,
  [EXPORTDATE] datetime,
  [JOURNALDATE] datetime,
  [JOURNALPERIOD] int,
  [USERID] nvarchar(30),
  [STATUS] int,
  [REJECTREASON] nvarchar(254),
  [LABELID] int,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLJOURNAL
  primary key (ENTITYNO, TRANSNO, DESIGNATION)
)
;

create index XIE1GLJOURNAL
  on GLJOURNAL (LABELID)
;

create index XIE2GLJOURNAL
  on GLJOURNAL (STATUS)
;

create table GLJOURNALLINE
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [DESIGNATION] tinyint not null,
  [SEQNO] int not null,
  [MOVEMENTNO] int,
  [ACCOUNTTYPE] smallint,
  [MOVEMENTCLASS] smallint,
  [GLACCOUNTCODE] nvarchar(100),
  [DESCRIPTION] nvarchar(254),
  [LOCALAMOUNT] decimal(11,2),
  [LEDGERACCOUNTID] int,
  [ACCTENTITYNO] int,
  [ACCTPROFITCENTRE] nvarchar(6),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLJOURNALLINE
  primary key (ENTITYNO, TRANSNO, DESIGNATION, SEQNO),
  constraint R_1569
  foreign key (ENTITYNO, TRANSNO, DESIGNATION) references GLJOURNAL,
  constraint R_1585
  foreign key (ACCOUNTTYPE, MOVEMENTCLASS) references GLACCOUNTING
)
;

create index XIE1GLJOURNALLINE
  on GLJOURNALLINE (GLACCOUNTCODE, DESIGNATION)
;

create index XIE2GLJOURNALLINE
  on GLJOURNALLINE (GLACCOUNTCODE, ENTITYNO, TRANSNO, DESIGNATION, SEQNO, ACCOUNTTYPE, MOVEMENTCLASS, DESCRIPTION, LOCALAMOUNT)
;

create index XIE3GLJOURNALLINE
  on GLJOURNALLINE (ACCTENTITYNO, ACCTPROFITCENTRE, LEDGERACCOUNTID)
;

create table GLJOURNALLINEEXT
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [DESIGNATION] tinyint not null,
  [SEQNO] int not null,
  [FIELDNO] smallint not null,
  [CONTENTS] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLJOURNALLINEEXT
  primary key (ENTITYNO, TRANSNO, DESIGNATION, SEQNO, FIELDNO),
  constraint R_1588
  foreign key (ENTITYNO, TRANSNO, DESIGNATION, SEQNO) references GLJOURNALLINE
)
;

create table GROUPAPPLICATION
(
  [SECURITYGROUP] nvarchar(30) not null,
  [APPLICATIONNAME] nvarchar(20) not null
    constraint R_1307
    references APPLICATIONS,
  [DISPLAYSEQUENCE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPAPPLICATION
  primary key (SECURITYGROUP, APPLICATIONNAME)
)
;

create table GROUPCONTROL
(
  [SECURITYGROUP] nvarchar(30) not null,
  [CRITERIANO] int not null,
  [ENTRYNUMBER] smallint not null,
  [INHERITED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPCONTROL
  primary key (SECURITYGROUP, CRITERIANO, ENTRYNUMBER),
  constraint R_903
  foreign key (CRITERIANO, ENTRYNUMBER) references DETAILCONTROL
)
;

create table GROUPMEMBERS
(
  [NAMEGROUP] smallint not null,
  [NAMETYPE] nvarchar(3) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPMEMBERS
  primary key (NAMEGROUP, NAMETYPE)
)
;

create table GROUPPROFILES
(
  [SECURITYGROUP] nvarchar(30) not null,
  [PROFILE] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPPROFILES
  primary key (SECURITYGROUP, PROFILE)
)
;

create table GROUPROWACCESS
(
  [ACCESSNAME] nvarchar(30) not null,
  [SECURITYGROUP] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPROWACCESS
  primary key (ACCESSNAME, SECURITYGROUP)
)
;

create table GROUPSTATUS
(
  [SECURITYGROUP] nvarchar(30) not null,
  [STATUSCODE] smallint not null,
  [SECURITYFLAG] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPSTATUS
  primary key (SECURITYGROUP, STATUSCODE)
)
;

create table HOLIDAYS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_803
    references COUNTRY,
  [HOLIDAYDATE] datetime not null,
  [HOLIDAYNAME] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKHOLIDAYS
  primary key (COUNTRYCODE, HOLIDAYDATE)
)
;

create table IMAGE
(
  [IMAGEID] int not null
    constraint XPKIMAGE
    primary key,
  [IMAGEDATA] image,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CASEIMAGE
  add constraint R_20102
foreign key (IMAGEID) references IMAGE
;

alter table DEBITNOTEIMAGE
  add constraint R_1553
foreign key (IMAGEID) references IMAGE
;

create table IMAGEDETAIL
(
  [IMAGEID] int not null
    constraint XPKIMAGEDETAIL
    primary key
    constraint RI_1010
    references IMAGE,
  [IMAGESTATUS] int,
  [SCANNEDFLAG] decimal(1),
  [IMAGEDESC] nvarchar(254),
  [FILELOCATION] nvarchar(254),
  [CONTENTTYPE] nvarchar(100),
  [IMAGEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1IMAGEDETAIL
  on IMAGEDETAIL (IMAGESTATUS)
;

create table IMPORTANCE
(
  [IMPORTANCELEVEL] nvarchar(2) not null
    constraint XPKIMPORTANCE
    primary key,
  [IMPORTANCEDESC] nvarchar(30),
  [IMPORTANCEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ALERT
  add constraint R_91527
foreign key (IMPORTANCELEVEL) references IMPORTANCE
;

alter table EVENTS
  add constraint R_1007
foreign key (IMPORTANCELEVEL) references IMPORTANCE
;

alter table EVENTS
  add constraint RI_1012
foreign key (CLIENTIMPLEVEL) references IMPORTANCE
;

create table IMPORTBATCH
(
  [IMPORTBATCHNO] int not null
    constraint XPKIMPORTBATCH
    primary key,
  [BATCHTYPE] int,
  [IMPORTEDDATE] datetime,
  [BATCHNOTES] nvarchar(2000),
  [FROMNAMENO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1IMPORTBATCH
  on IMPORTBATCH (BATCHTYPE)
;

alter table EXPENSEIMPORT
  add constraint R_1469
foreign key (IMPORTBATCHNO) references IMPORTBATCH
;

create table IMPORTCONTROL
(
  [CONTROLID] smallint not null
    constraint XPKIMPORTCONTROL
    primary key,
  [COUNTRYCODE] nvarchar(3)
    constraint R_1455
    references COUNTRY,
  [PROPERTYTYPE] nchar(1),
  [TRANSACTIONTYPE] nvarchar(20),
  [EVENTNO] int
    constraint R_1456
    references EVENTS,
  [AUTOMATICFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table INDIVIDUAL
(
  [NAMENO] int not null
    constraint XPKINDIVIDUAL
    primary key,
  [SEX] nchar(1),
  [FORMALSALUTATION] nvarchar(50),
  [CASUALSALUTATION] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ASSOCIATEDNAME
  add constraint R_870
foreign key (CONTACT) references INDIVIDUAL
;

create table INFLATIONINDEX
(
  [INFLATIONINDEXID] int not null
    constraint XPKINFLATIONINDEX
    primary key,
  [DATEPUBLISHED] datetime not null,
  [INDEXVALUE] decimal(11,2) not null,
  [DATECHANGED] datetime,
  [USERID] nvarchar(30),
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table INHERITS
(
  [CRITERIANO] int not null
    constraint R_963
    references CRITERIA,
  [FROMCRITERIA] int not null
    constraint RI_962
    references CRITERIA,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINHERITS
  primary key (CRITERIANO, FROMCRITERIA)
)
;

create index XIE1INHERITS
  on INHERITS (FROMCRITERIA)
;

create table INSTRUCTIONFLAG
(
  [INSTRUCTIONCODE] smallint not null,
  [FLAGNUMBER] smallint not null,
  [INSTRUCTIONFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINSTRUCTIONFLAG
  primary key (INSTRUCTIONCODE, FLAGNUMBER)
)
;

create table INSTRUCTIONLABEL
(
  [INSTRUCTIONTYPE] nvarchar(3) not null,
  [FLAGNUMBER] smallint not null,
  [FLAGLITERAL] nvarchar(50),
  [FLAGLITERAL_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINSTRUCTIONLABL
  primary key (INSTRUCTIONTYPE, FLAGNUMBER)
)
;

create table INSTRUCTIONS
(
  [INSTRUCTIONCODE] smallint not null
    constraint XPKINSTRUCTIONS
    primary key,
  [INSTRUCTIONTYPE] nvarchar(3),
  [DESCRIPTION] nvarchar(50),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table INSTRUCTIONFLAG
  add constraint R_20115
foreign key (INSTRUCTIONCODE) references INSTRUCTIONS
;

create table INSTRUCTIONTYPE
(
  [INSTRUCTIONTYPE] nvarchar(3) not null
    constraint XPKIINSTRUCTIONTYPE
    primary key,
  [NAMETYPE] nvarchar(3) not null,
  [INSTRTYPEDESC] nvarchar(50),
  [RESTRICTEDBYTYPE] nvarchar(3),
  [INSTRTYPEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table INSTRUCTIONLABEL
  add constraint R_20112
foreign key (INSTRUCTIONTYPE) references INSTRUCTIONTYPE
;

alter table INSTRUCTIONS
  add constraint R_20113
foreign key (INSTRUCTIONTYPE) references INSTRUCTIONTYPE
;

create table INTERNALREFSTEM
(
  [STEMUNIQUENO] smallint not null
    constraint XPKINTERNALREFSTEM
    primary key,
  [CASETYPE] nchar(1)
    constraint RI_1088
    references CASETYPE,
  [PROPERTYTYPE] nchar(1),
  [LEADINGZEROSFLAG] decimal(1),
  [NUMBEROFDIGITS] smallint,
  [NEXTAVAILABLESTEM] int,
  [CASEOFFICEID] int,
  [COUNTRYCODE] nvarchar(3)
    constraint R_1248
    references COUNTRY,
  [CASECATEGORY] nvarchar(2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1INTERNALREFSTEM
  on INTERNALREFSTEM (CASETYPE, PROPERTYTYPE, CASEOFFICEID, COUNTRYCODE, CASECATEGORY)
;

create table IPNAME
(
  [NAMENO] int not null
    constraint XPKIPNAME
    primary key,
  [TAXCODE] nvarchar(3),
  [BADDEBTOR] smallint
    constraint RI_1062
    references DEBTORSTATUS,
  [CURRENCY] nvarchar(3)
    constraint R_20074
    references CURRENCY,
  [DEBITCOPIES] smallint,
  [CONSOLIDATION] decimal(1),
  [DEBTORTYPE] int,
  [USEDEBTORTYPE] int,
  [CORRESPONDENCE] nvarchar(254),
  [CATEGORY] int,
  [PURCHASEORDERNO] nvarchar(80),
  [LOCALCLIENTFLAG] decimal(1),
  [AIRPORTCODE] nvarchar(5)
    constraint R_1335
    references AIRPORT,
  [TRADINGTERMS] int,
  [BILLINGFREQUENCY] int,
  [CREDITLIMIT] decimal(12,2),
  [CORRESPONDENCE_TID] int,
  [EXCHSCHEDULEID] int,
  [STATETAXCODE] nvarchar(3),
  [SERVPERFORMEDIN] nvarchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [BILLMAPPROFILEID] int,
  [BILLFORMATID] int,
  [MODIFIABLEPDFFLAG] bit,
  [BILLINGCAP] decimal(12,2),
  [BILLINGCAPPERIOD] int,
  [BILLINGCAPPERIODTYPE] nvarchar(1),
  [SEPARATEMARGINFLAG] bit,
  [BILLINGCAPSTARTDATE] datetime,
  [BILLINGCAPRESETFLAG] bit
)
;

create index XIE1IPNAME
  on IPNAME (CATEGORY)
;

create index XIE2IPNAME
  on IPNAME (AIRPORTCODE)
;

create index XIE3IPNAME
  on IPNAME (DEBTORTYPE)
;

create index XIE4IPNAME
  on IPNAME (USEDEBTORTYPE)
;

create index XIE5IPNAME
  on IPNAME (BILLINGFREQUENCY)
;

create table IRALLOCATION
(
  [IRN] nvarchar(30) not null
    constraint XPKIRALLOCATION
    primary key,
  [USERID] nvarchar(30),
  [EMPLOYEENO] int,
  [DATEALLOCATED] datetime,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table IRFORMAT
(
  [CRITERIANO] int not null
    constraint XPKIRFORMAT
    primary key
    constraint RI_1087
    references CRITERIA,
  [SEGMENT1] nvarchar(20),
  [SEGMENT2] nvarchar(20),
  [SEGMENT3] nvarchar(20),
  [SEGMENT4] nvarchar(20),
  [SEGMENT5] nvarchar(20),
  [INSTRUCTORFLAG] decimal(1),
  [OWNERFLAG] decimal(1),
  [STAFFFLAG] decimal(1),
  [FAMILYFLAG] decimal(1),
  [SEGMENT6] nvarchar(20),
  [SEGMENT7] nvarchar(20),
  [SEGMENT8] nvarchar(20),
  [SEGMENT9] nvarchar(20),
  [SEGMENT1CODE] int,
  [SEGMENT2CODE] int,
  [SEGMENT3CODE] int,
  [SEGMENT4CODE] int,
  [SEGMENT5CODE] int,
  [SEGMENT6CODE] int,
  [SEGMENT7CODE] int,
  [SEGMENT8CODE] int,
  [SEGMENT9CODE] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1IRFORMAT
  on IRFORMAT (SEGMENT1CODE)
;

create index XIE2IRFORMAT
  on IRFORMAT (SEGMENT2CODE)
;

create index XIE3IRFORMAT
  on IRFORMAT (SEGMENT3CODE)
;

create index XIE4IRFORMAT
  on IRFORMAT (SEGMENT4CODE)
;

create index XIE5IRFORMAT
  on IRFORMAT (SEGMENT5CODE)
;

create index XIE6IRFORMAT
  on IRFORMAT (SEGMENT6CODE)
;

create index XIE7IRFORMAT
  on IRFORMAT (SEGMENT7CODE)
;

create index XIE8IRFORMAT
  on IRFORMAT (SEGMENT8CODE)
;

create index XIE9IRFORMAT
  on IRFORMAT (SEGMENT9CODE)
;

create table JOURNAL
(
  [CASEID] int not null
    constraint RI_1098
    references CASES,
  [SEQUENCE] smallint not null,
  [JOURNALNO] nvarchar(20),
  [JOURNALPAGE] int,
  [JOURNALDATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKJOURNAL
  primary key (CASEID, SEQUENCE)
)
;

create unique index XAK1JOURNAL
  on JOURNAL (JOURNALNO, JOURNALDATE, JOURNALPAGE, CASEID)
;

create table KEYWORDS
(
  [KEYWORDNO] int not null
    constraint XPKKEYWORDS
    primary key,
  [KEYWORD] nvarchar(50) not null,
  [STOPWORD] decimal(1),
  [SOUNDEX] nvarchar(10),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1KEYWORDS
  on KEYWORDS (KEYWORD)
;

create index XIE1KEYWORDS
  on KEYWORDS (STOPWORD)
;

alter table CASEWORDS
  add constraint R_853
foreign key (KEYWORDNO) references KEYWORDS
;

create table LABEL
(
  [LABELID] int not null
    constraint XPKLABEL
    primary key,
  [DESCRIPTION] nvarchar(50) not null,
  [LABELTYPE] int,
  [DATECREATED] datetime,
  [USERID] nvarchar(30),
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1LABEL
  on LABEL (LABELTYPE, DESCRIPTION)
;

create table LANGUAGE
(
  [LANGUAGE_CODE] int not null
    constraint XPKLANGUAGE
    primary key,
  [LANGUAGE] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1LANGUAGE
  on LANGUAGE (LANGUAGE)
;

create table LASTINTERNALCODE
(
  [TABLENAME] nvarchar(18) not null,
  [INTERNALSEQUENCE] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLASTINTERNALCODE
  primary key (TABLENAME, INTERNALSEQUENCE)
)
;

create table LETTER
(
  [LETTERNO] smallint not null
    constraint XPKLETTER
    primary key,
  [LETTERNAME] nvarchar(254),
  [DOCUMENTCODE] nvarchar(10),
  [CORRESPONDTYPE] smallint
    constraint R_1113
    references CORRESPONDTO,
  [COPIESALLOWEDFLAG] decimal(1),
  [EXTRACOPIES] smallint,
  [MULTICASEFLAG] decimal(1),
  [MACRO] nvarchar(254),
  [INSTRUCTIONTYPE] nvarchar(3)
    constraint RI_1121
    references INSTRUCTIONTYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint RI_1110
    references COUNTRY,
  [DELIVERYID] smallint
    constraint R_1345
    references DELIVERYMETHOD,
  [PROPERTYTYPE] nchar(1),
  [HOLDFLAG] decimal(1),
  [NOTES] nvarchar(254),
  [DOCUMENTTYPE] smallint not null,
  [COVERINGLETTER] smallint,
  [SINGLECASELETTERNO] smallint,
  [ENVELOPE] smallint,
  [USEDBY] int default 32 not null,
  [LETTERNAME_TID] int,
  [FORPRIMECASESONLY] bit,
  [GENERATEASANSI] bit,
  [ADDATTACHMENTFLAG] bit,
  [ACTIVITYTYPE] int,
  [ACTIVITYCATEGORY] int,
  [ENTRYPOINTTYPE] int,
  [SOURCEFILE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [EXTERNALUSAGE] smallint default 0 not null
)
;

create index XIE1LETTER
  on LETTER (USEDBY)
;

create index XIE2LETTER
  on LETTER (ENTRYPOINTTYPE)
;

create index XIE3LETTER
  on LETTER (ACTIVITYTYPE)
;

create index XIE4LETTER
  on LETTER (ACTIVITYCATEGORY)
;

alter table ACTIVITYREQUEST
  add constraint R_754
foreign key (LETTERNO) references LETTER
;

alter table ACTIVITYREQUEST
  add constraint R_1117
foreign key (ALTERNATELETTER) references LETTER
;

alter table ACTIVITYREQUEST
  add constraint RI_1057
foreign key (COVERINGLETTERNO) references LETTER
;

alter table ALERT
  add constraint R_80
foreign key (LETTERNO) references LETTER
;

alter table BILLFORMAT
  add constraint RI_1072
foreign key (DEBITNOTE) references LETTER
;

alter table BILLFORMAT
  add constraint RI_1073
foreign key (COVERINGLETTER) references LETTER
;

alter table CHECKLISTLETTER
  add constraint R_744
foreign key (LETTERNO) references LETTER
;

alter table DETAILLETTERS
  add constraint R_783
foreign key (LETTERNO) references LETTER
;

alter table DUEDATECALC
  add constraint RI_970
foreign key (OVERRIDELETTER) references LETTER
;

alter table FEESCALCULATION
  add constraint R_796
foreign key (DEBITNOTE) references LETTER
;

alter table FEESCALCULATION
  add constraint R_797
foreign key (COVERINGLETTER) references LETTER
;

alter table FORMFIELDS
  add constraint R_1608
foreign key (DOCUMENTNO) references LETTER
;

create table LETTERBATCH
(
  [BATCHNUMBER] smallint not null,
  [CASEID] int not null
    constraint R_804
    references CASES,
  [LETTERNO] smallint
    constraint R_805
    references LETTER,
  [DATESENT] datetime,
  [DATEREPLIED] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLETTERBATCH
  primary key (BATCHNUMBER, CASEID)
)
;

create index XIE1LETTERBATCH
  on LETTERBATCH (CASEID)
;

create table LETTERSUBSTITUTE
(
  [LETTERNO] smallint not null
    constraint R_1102
    references LETTER,
  [SEQUENCE] smallint not null,
  [ALTERNATELETTER] smallint,
  [CASEID] int
    constraint R_1107
    references CASES,
  [INSTRUCTIONCODE] smallint
    constraint R_1106
    references INSTRUCTIONS,
  [NAMENO] int,
  [CATEGORY] int,
  [LANGUAGE] int,
  [CASECOUNTRYCODE] nvarchar(3)
    constraint RI_992
    references COUNTRY,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLETTERSUBSTITUTE
  primary key (LETTERNO, SEQUENCE)
)
;

create index XIE1LETTERSUBSTITUTE
  on LETTERSUBSTITUTE (CASEID)
;

create index XIE2LETTERSUBSTITUTE
  on LETTERSUBSTITUTE (LANGUAGE)
;

create index XIE3LETTERSUBSTITUTE
  on LETTERSUBSTITUTE (CATEGORY)
;

create table LINKAPPLICATIONS
(
  [SEQUENCENO] int not null,
  [EXTERNALAPPNAME] nvarchar(20) not null
    constraint R_1491
    references APPLICATIONS,
  [APPLICATIONNAME] nvarchar(20) not null
    constraint R_1492
    references APPLICATIONS,
  [FORMNAME] nchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLINKAPPLICATIONS
  primary key (SEQUENCENO, EXTERNALAPPNAME, APPLICATIONNAME)
)
;

create index XIE1LINKAPPLICATIONS
  on LINKAPPLICATIONS (FORMNAME, EXTERNALAPPNAME)
;

create table MENU
(
  [MENUNAME] nvarchar(20) not null
    constraint XPKMENU
    primary key,
  [MENUSEQUENCE] smallint not null,
  [MENUNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table APPLICATIONS
  add constraint R_1443
foreign key (MENUNAME) references MENU
;

create table MOVEMENTLABEL
(
  [LEDGERID] smallint not null,
  [MOVEMENTCLASS] smallint not null,
  [LABEL] nvarchar(20) not null,
  [SORTSEQUENCE] smallint not null,
  [GLDESCRIPTION] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKMOVEMENTLABEL
  primary key (LEDGERID, MOVEMENTCLASS)
)
;

alter table GLACCOUNTDEFAULTS
  add constraint R_1611
foreign key (LEDGERID, MOVEMENTCLASS) references MOVEMENTLABEL
;

create table NAME
(
  [NAMENO] int not null
    constraint XPKNAME
    primary key,
  [NAMECODE] nvarchar(10),
  [NAME] nvarchar(254) not null,
  [TITLE] nvarchar(20),
  [INITIALS] nvarchar(10),
  [FIRSTNAME] nvarchar(50),
  [SEARCHKEY1] nvarchar(20),
  [NAMESTYLE] int,
  [SEARCHKEY2] nvarchar(20),
  [SOUNDEX] nvarchar(10),
  [NATIONALITY] nvarchar(3)
    constraint R_843
    references COUNTRY,
  [REMARKS] nvarchar(254),
  [MAINPHONE] int,
  [FAX] int,
  [POSTALADDRESS] int
    constraint R_20013
    references ADDRESS,
  [STREETADDRESS] int
    constraint R_20014
    references ADDRESS,
  [DATECHANGED] datetime,
  [DATEENTERED] datetime,
  [DATECEASED] datetime,
  [USEDASFLAG] smallint,
  [EXTENDEDNAMEFLAG] decimal(1),
  [FAMILYNO] smallint,
  [INSTRUCTORPREFIX] nvarchar(10),
  [CASESEQUENCE] smallint,
  [MAINCONTACT] int,
  [REMARKS_TID] int,
  [TITLE_TID] int,
  [SUPPLIERFLAG] decimal(1),
  [MAINEMAIL] int,
  [AIRPORTCODE] nvarchar(5)
    constraint R_91422
    references AIRPORT,
  [TAXNO] nvarchar(30),
  [STATETAXNO] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [NAMESTATUS] int,
  [NAMESOURCE] int,
  [ESTIMATEDREV] decimal(11,2),
  [CRMONLY] bit
)
;

create index XIE1NAME
  on NAME (NAMECODE)
;

create index XIE2NAME
  on NAME (SOUNDEX)
;

create index XIE3NAME
  on NAME (MAINCONTACT)
;

create index XIE4NAME
  on NAME (SEARCHKEY1)
;

create index XIE5NAME
  on NAME (SEARCHKEY2)
;

create index XIE6NAME
  on NAME (FAMILYNO)
;

create index XIE7NAME
  on NAME (POSTALADDRESS)
;

create index XIE8NAME
  on NAME (NAMESTYLE)
;

alter table ACCOUNT
  add constraint R_162
foreign key (NAMENO) references NAME
;

alter table ACTIVITYREQUEST
  add constraint R_749
foreign key (INSTRUCTOR) references NAME
;

alter table ACTIVITYREQUEST
  add constraint R_1058
foreign key (OWNER) references NAME
;

alter table ACTIVITYREQUEST
  add constraint R_178
foreign key (EMPLOYEENO) references NAME
;

alter table ACTIVITYREQUEST
  add constraint R_1525
foreign key (DISBEMPLOYEENO) references NAME
;

alter table ACTIVITYREQUEST
  add constraint R_1528
foreign key (SERVEMPLOYEENO) references NAME
;

alter table ACTIVITYREQUEST
  add constraint RI_1134
foreign key (DEBTOR) references NAME
;

alter table ALERT
  add constraint R_179
foreign key (EMPLOYEENO) references NAME
;

alter table ALERT
  add constraint R_91538
foreign key (NAMENO) references NAME
;

alter table ASSOCIATEDNAME
  add constraint R_835
foreign key (NAMENO) references NAME
;

alter table ASSOCIATEDNAME
  add constraint R_833
foreign key (RELATEDNAME) references NAME
;

alter table BANKACCOUNT
  add constraint R_1417
foreign key (ACCOUNTOWNER) references NAME
;

alter table BANKACCOUNT
  add constraint R_1461
foreign key (BRANCHNAMENO) references NAME
;

alter table BILLFORMAT
  add constraint R_1506
foreign key (NAMENO) references NAME
;

alter table BILLRULE
  add constraint R_163
foreign key (DEBTORNO) references NAME
;

alter table CASELOCATION
  add constraint R_182
foreign key (ISSUEDBY) references NAME
;

alter table CASENAME
  add constraint RI_928
foreign key (NAMENO) references NAME
;

alter table CASENAME
  add constraint R_842
foreign key (CORRESPONDNAME) references NAME
;

alter table CASENAME
  add constraint R_1530
foreign key (INHERITEDNAMENO) references NAME
;

alter table CASEPROFITCENTRE
  add constraint R_1232
foreign key (INSTRUCTOR) references NAME
;

alter table CASHITEM
  add constraint R_91459
foreign key (ACCTNAMENO) references NAME
;

alter table COSTTRACK
  add constraint R_1493
foreign key (AGENTNO) references NAME
;

alter table COSTTRACKALLOC
  add constraint R_1501
foreign key (DEBTORNO) references NAME
;

alter table COSTTRACKALLOC
  add constraint R_1509
foreign key (DIVISIONNO) references NAME
;

/*alter table CPAUPDATE
	add constraint R_1600
foreign key (NAMEID) references NAME
;*/

alter table CRITERIA
  add constraint R_91839
foreign key (DATASOURCENAMENO) references NAME
;

alter table DEBITNOTEIMAGE
  add constraint R_164
foreign key (DEBTORNO) references NAME
;

alter table DISCOUNT
  add constraint R_165
foreign key (NAMENO) references NAME
;

alter table DISCOUNT
  add constraint R_91646
foreign key (CASEOWNER) references NAME
;

alter table EMPLOYEE
  add constraint R_251
foreign key (EMPLOYEENO) references NAME
;

alter table EXPENSEIMPORT
  add constraint R_185
foreign key (EMPLOYEENO) references NAME
;

alter table EXPENSEIMPORT
  add constraint R_166
foreign key (NAMENO) references NAME
;

alter table EXPENSEIMPORT
  add constraint R_1488
foreign key (SUPPLIERNAMENO) references NAME
;

alter table FEELIST
  add constraint R_91871
foreign key (FEELISTNAME) references NAME
;

alter table FEELIST
  add constraint R_91450
foreign key (IPOFFICE) references NAME
;

alter table FEESCALCULATION
  add constraint R_169
foreign key (AGENT) references NAME
;

alter table FEESCALCULATION
  add constraint R_168
foreign key (DEBTOR) references NAME
;

alter table FEESCALCULATION
  add constraint R_187
foreign key (DISBEMPLOYEENO) references NAME
;

alter table FEESCALCULATION
  add constraint R_186
foreign key (SERVEMPLOYEENO) references NAME
;

alter table FEESCALCULATION
  add constraint R_1563
foreign key (OWNER) references NAME
;

alter table FEESCALCULATION
  add constraint R_167
foreign key (INSTRUCTOR) references NAME
;

alter table FILEREQUEST
  add constraint R_188
foreign key (EMPLOYEENO) references NAME
;

alter table FILESIN
  add constraint R_919
foreign key (NAMENO) references NAME
;

alter table FUNCTIONSECURITY
  add constraint R_190
foreign key (OWNERNO) references NAME
;

alter table FUNCTIONSECURITY
  add constraint R_189
foreign key (ACCESSSTAFFNO) references NAME
;

alter table GLACCOUNTMAPPING
  add constraint R_191
foreign key (WIPEMPLOYEENO) references NAME
;

alter table IMPORTBATCH
  add constraint R_91467
foreign key (FROMNAMENO) references NAME
;

alter table INDIVIDUAL
  add constraint R_829
foreign key (NAMENO) references NAME
;

alter table IPNAME
  add constraint R_362
foreign key (NAMENO) references NAME
;

alter table IRALLOCATION
  add constraint R_192
foreign key (EMPLOYEENO) references NAME
;

alter table LETTERSUBSTITUTE
  add constraint RI_1104
foreign key (NAMENO) references NAME
;

create table NAMEADDRESS
(
  [NAMENO] int not null
    constraint R_298
    references NAME,
  [ADDRESSTYPE] int not null,
  [ADDRESSCODE] int not null
    constraint R_20011
    references ADDRESS,
  [ADDRESSSTATUS] int,
  [DATECEASED] datetime,
  [OWNEDBY] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMEADDRESS
  primary key (NAMENO, ADDRESSTYPE, ADDRESSCODE)
)
;

create index XIE1NAMEADDRESS
  on NAMEADDRESS (ADDRESSCODE)
;

create index XIE2NAMEADDRESS
  on NAMEADDRESS (ADDRESSTYPE)
;

create index XIE3NAMEADDRESS
  on NAMEADDRESS (ADDRESSSTATUS)
;

create table NAMEADDRESSSNAP
(
  [NAMESNAPNO] int not null
    constraint XPKNAMEADDRESSSNAP
    primary key,
  [NAMENO] int
    constraint R_1423
    references NAME,
  [FORMATTEDNAME] nvarchar(254),
  [FORMATTEDADDRESS] nvarchar(254),
  [FORMATTEDATTENTION] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ATTNNAMENO] int
    constraint R_92464
    references NAME,
  [ADDRESSCODE] int
    constraint R_92465
    references ADDRESS,
  [REASONCODE] int
)
;

create index XIE1NAMEADDRESSSNAP
  on NAMEADDRESSSNAP (NAMENO)
;

create table NAMEALIAS
(
  [NAMENO] int not null
    constraint RI_1133
    references NAME,
  [ALIAS] nvarchar(30) not null,
  [ALIASTYPE] nvarchar(2) not null
    constraint R_1134
    references ALIASTYPE,
  [PRIORITY] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ALIASNO] int identity,
  [COUNTRYCODE] nvarchar(3)
    constraint R_81617
    references COUNTRY,
  [PROPERTYTYPE] nchar(1),
  constraint XPKNAMEALIAS
  primary key (NAMENO, ALIAS, ALIASTYPE, ALIASNO)
)
;

create unique index XAK1NAMEALIAS
  on NAMEALIAS (NAMENO, ALIAS, ALIASTYPE, COUNTRYCODE, PROPERTYTYPE)
;

create index XIE1NAMEALIAS
  on NAMEALIAS (ALIAS)
;

create index XIE2NAMEALIAS
  on NAMEALIAS (COUNTRYCODE)
;

create index XIE3NAMEALIAS
  on NAMEALIAS (PROPERTYTYPE)
;

create table NAMEFAMILY
(
  [FAMILYNO] smallint not null
    constraint XPKNAMEFAMILY
    primary key,
  [FAMILYTITLE] nvarchar(50),
  [FAMILYCOMMENTS] nvarchar(254),
  [FAMILYCOMMENTS_TID] int,
  [FAMILYTITLE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1NAMEFAMILY
  on NAMEFAMILY (FAMILYTITLE)
;

alter table FUNCTIONSECURITY
  add constraint R_1474
foreign key (ACCESSGROUP) references NAMEFAMILY
;

alter table NAME
  add constraint R_1300
foreign key (FAMILYNO) references NAMEFAMILY
;

create table NAMEGROUPS
(
  [NAMEGROUP] smallint not null
    constraint XPKNAMEGROUPS
    primary key,
  [GROUPDESCRIPTION] nvarchar(50),
  [GROUPDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GROUPMEMBERS
  add constraint RI_1068
foreign key (NAMEGROUP) references NAMEGROUPS
;

create table NAMEIMAGE
(
  [NAMENO] int not null
    constraint R_746
    references NAME,
  [IMAGEID] int not null
    constraint R_20103
    references IMAGE,
  [IMAGETYPE] int,
  [IMAGESEQUENCE] smallint,
  [NAMEIMAGEDESC] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMEIMAGE
  primary key (NAMENO, IMAGEID)
)
;

create index XIE1NAMEIMAGE
  on NAMEIMAGE (IMAGETYPE)
;

create table NAMEINSTRUCTIONS
(
  [NAMENO] int not null
    constraint R_172
    references NAME,
  [INTERNALSEQUENCE] int not null,
  [RESTRICTEDTONAME] int
    constraint R_1522
    references NAME,
  [INSTRUCTIONCODE] smallint
    constraint R_20116
    references INSTRUCTIONS,
  [CASEID] int
    constraint RI_1014
    references CASES,
  [COUNTRYCODE] nvarchar(3)
    constraint R_20060
    references COUNTRY,
  [PROPERTYTYPE] nchar(1),
  [PERIOD1AMT] smallint,
  [PERIOD1TYPE] nchar(1),
  [PERIOD2AMT] smallint,
  [PERIOD2TYPE] nchar(1),
  [PERIOD3AMT] smallint,
  [PERIOD3TYPE] nchar(1),
  [ADJUSTMENT] nvarchar(4)
    constraint R_91640
    references ADJUSTMENT,
  [ADJUSTDAY] tinyint,
  [ADJUSTSTARTMONTH] tinyint,
  [ADJUSTDAYOFWEEK] tinyint,
  [ADJUSTTODATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [STANDINGINSTRTEXT] nvarchar(4000),
  constraint XPKNAMEINSTRUCTION
  primary key (NAMENO, INTERNALSEQUENCE)
)
;

create unique index XAK1NAMEINSTRUCTIONS
  on NAMEINSTRUCTIONS (INSTRUCTIONCODE, NAMENO, CASEID, PROPERTYTYPE, COUNTRYCODE, RESTRICTEDTONAME, INTERNALSEQUENCE)
;

create index XIE1NAMEINSTRUCTIO
  on NAMEINSTRUCTIONS (CASEID)
;

create table NAMELANGUAGE
(
  [NAMENO] int not null
    constraint R_1341
    references NAME,
  [SEQUENCENO] smallint not null,
  [LANGUAGE] int not null,
  [ACTION] nvarchar(2)
    constraint R_1340
    references ACTIONS,
  [PROPERTYTYPE] nchar(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMELANGUAGE
  primary key (NAMENO, SEQUENCENO)
)
;

create index XIE1NAMELANGUAGE
  on NAMELANGUAGE (LANGUAGE)
;

create table NAMERELATION
(
  [RELATIONSHIP] nvarchar(3) not null
    constraint XPKNAMERELATION
    primary key,
  [RELATIONDESCR] nvarchar(30),
  [REVERSEDESCR] nvarchar(30),
  [SHOWFLAG] decimal(1),
  [USEDBYNAMETYPE] decimal(1),
  [RELATIONDESCR_TID] int,
  [REVERSEDESCR_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CRMONLY] bit
)
;

alter table ALERT
  add constraint R_81707
foreign key (RELATIONSHIP) references NAMERELATION
;

alter table ASSOCIATEDNAME
  add constraint R_849
foreign key (RELATIONSHIP) references NAMERELATION
;

alter table CASENAME
  add constraint R_1531
foreign key (INHERITEDRELATIONS) references NAMERELATION
;

create table NAMEREPLACED
(
  [OLDNAMENO] int not null
    constraint XPKNAMEREPLACED
    primary key,
  [NEWNAMENO] int
    constraint R_1120
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1NAMEREPLACED
  on NAMEREPLACED (NEWNAMENO)
;

create table NAMETELECOM
(
  [NAMENO] int not null
    constraint R_305
    references NAME,
  [TELECODE] int not null,
  [TELECOMDESC] nvarchar(254),
  [OWNEDBY] decimal(1),
  [TELECOMDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMETELECOM
  primary key (NAMENO, TELECODE)
)
;

create table NAMETYPE
(
  [NAMETYPE] nvarchar(3) not null
    constraint XPKNAMETYPE
    primary key,
  [DESCRIPTION] nvarchar(50),
  [PATHRELATIONSHIP] nvarchar(3)
    constraint RI_1065
    references NAMERELATION,
  [HIERARCHYFLAG] decimal(1),
  [MANDATORYFLAG] decimal(1),
  [KEEPSTREETFLAG] decimal(1),
  [COLUMNFLAGS] smallint,
  [MAXIMUMALLOWED] smallint,
  [PICKLISTFLAGS] smallint,
  [SHOWNAMECODE] decimal(1),
  [DEFAULTNAMENO] int
    constraint R_1389
    references NAME,
  [PATHNAMETYPE] nvarchar(3),
  [DESCRIPTION_TID] int,
  [NAMERESTRICTFLAG] decimal(1),
  [CHANGEEVENTNO] int
    constraint R_91647
    references EVENTS,
  [FUTURENAMETYPE] nvarchar(3)
    constraint R_91648
    references NAMETYPE,
  [USEHOMENAMEREL] bit default 0 not null,
  [UPDATEFROMPARENT] bit default 1 not null,
  [OLDNAMETYPE] nvarchar(3)
    constraint R_91881
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [BULKENTRYFLAG] bit default 0,
  [NAMETYPEID] int identity,
  [KOTTEXTTYPE] nvarchar(2)
)
;

alter table ALERT
  add constraint R_81706
foreign key (NAMETYPE) references NAMETYPE
;

alter table CASENAME
  add constraint R_369
foreign key (NAMETYPE) references NAMETYPE
;

alter table CORRESPONDTO
  add constraint R_1114
foreign key (NAMETYPE) references NAMETYPE
;

alter table CORRESPONDTO
  add constraint R_1112
foreign key (COPIESTO) references NAMETYPE
;

alter table DELIVERYMETHOD
  add constraint R_91410
foreign key (NAMETYPE) references NAMETYPE
;

alter table FEESCALCULATION
  add constraint R_91814
foreign key (DISBSTAFFNAMETYPE) references NAMETYPE
;

alter table FEESCALCULATION
  add constraint R_91816
foreign key (SERVSTAFFNAMETYPE) references NAMETYPE
;

alter table GLFIELDRULECONTENT
  add constraint R_1594
foreign key (NAMETYPE) references NAMETYPE
;

alter table GROUPMEMBERS
  add constraint RI_1064
foreign key (NAMETYPE) references NAMETYPE
;

alter table INSTRUCTIONTYPE
  add constraint R_1383
foreign key (NAMETYPE) references NAMETYPE
;

alter table INSTRUCTIONTYPE
  add constraint R_1523
foreign key (RESTRICTEDBYTYPE) references NAMETYPE
;

create table NARRATIVESUBSTITUT
(
  [NARRATIVENO] smallint not null,
  [SEQUENCE] smallint not null,
  [ALTERNATENARRATIVE] smallint,
  [NAMENO] int
    constraint RI_1128
    references NAME,
  [LANGUAGE] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNARRATIVESUBSTITUTE
  primary key (NARRATIVENO, SEQUENCE)
)
;

create index XIE1NARRATIVESUBSTITUT
  on NARRATIVESUBSTITUT (LANGUAGE)
;

create table NUMBERTYPES
(
  [NUMBERTYPE] nchar(1) not null
    constraint XPKNUMBERTYPES
    primary key,
  [DESCRIPTION] nvarchar(30),
  [RELATEDEVENTNO] int
    constraint R_1636
    references EVENTS,
  [ISSUEDBYIPOFFICE] decimal(1),
  [DISPLAYPRIORITY] smallint,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DETAILCONTROL
  add constraint RI_929
foreign key (NUMBERTYPE) references NUMBERTYPES
;

alter table FEELISTCASE
  add constraint RI_1219
foreign key (NUMBERTYPE) references NUMBERTYPES
;

create table OFFICIALNUMBERS
(
  [CASEID] int not null
    constraint R_871
    references CASES,
  [OFFICIALNUMBER] nvarchar(36) not null,
  [NUMBERTYPE] nchar(1) not null
    constraint R_872
    references NUMBERTYPES,
  [ISCURRENT] decimal(1),
  [DATEENTERED] datetime,
  [OFFICIALNUMBER_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOFFICIALNUMBERS
  primary key (CASEID, OFFICIALNUMBER, NUMBERTYPE)
)
;

create index XIE1OFFICIALNUMBERS
  on OFFICIALNUMBERS (OFFICIALNUMBER)
;

create table OFFSITESTORAGE
(
  [CASEID] int not null,
  [FILELOCATION] int not null,
  [IRN] nvarchar(30),
  [DESTROYFLAG] decimal(1),
  [EXACTLOCATION] nvarchar(20),
  [DATETODESTROY] datetime,
  [DATEDESTROYED] nchar(18),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOFFSITESTORAGE
  primary key (CASEID, FILELOCATION)
)
;

create index XIE1OFFSITESTORAGE
  on OFFSITESTORAGE (IRN)
;

create index XIE2OFFSITESTORAGE
  on OFFSITESTORAGE (DATETODESTROY, CASEID)
;

create index XIE3OFFSITESTORAGE
  on OFFSITESTORAGE (FILELOCATION)
;

create table OPENACTION
(
  [CASEID] int not null
    constraint R_20030
    references CASES,
  [ACTION] nvarchar(2) not null
    constraint R_20005
    references ACTIONS,
  [CYCLE] smallint not null,
  [LASTEVENT] int
    constraint R_972
    references EVENTS,
  [CRITERIANO] int
    constraint R_956
    references CRITERIA,
  [DATEFORACT] datetime,
  [NEXTDUEDATE] datetime,
  [POLICEEVENTS] decimal(1),
  [STATUSCODE] smallint,
  [STATUSDESC] nvarchar(50),
  [DATEENTERED] datetime,
  [DATEUPDATED] datetime,
  [STATUSDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOPENACTION
  primary key nonclustered (CASEID, ACTION, CYCLE)
)
;

create clustered index XIE3OPENACTION
  on OPENACTION (CASEID)
;

create index XIE1OPENACTION
  on OPENACTION (CRITERIANO, POLICEEVENTS, CASEID)
;

create index XIE2OPENACTION
  on OPENACTION (POLICEEVENTS, CASEID, ACTION, CYCLE, CRITERIANO)
;

create index XIE4OPENACTION
  on OPENACTION (CRITERIANO)
;

create table OPENITEMTAX
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [TAXCODE] nvarchar(3) not null,
  [TAXRATE] decimal(8,4),
  [TAXABLEAMOUNT] decimal(11,2),
  [TAXAMOUNT] decimal(11,2),
  [COUNTRYCODE] nvarchar(3)
    constraint R_944
    references COUNTRY,
  [STATE] nvarchar(20),
  [HARMONISED] bit,
  [TAXONTAX] bit,
  [MODIFIED] bit,
  [ADJUSTMENT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOPENITEMTAX
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, TAXCODE)
)
;

create index XIE1OPENITEMTAX
  on OPENITEMTAX (TAXCODE, COUNTRYCODE)
;

create index XIE2OPENITEMTAX
  on OPENITEMTAX (TAXCODE, COUNTRYCODE, STATE)
;

create table ORGANISATION
(
  [NAMENO] int not null
    constraint XPKOrRGANISATION
    primary key
    constraint R_845
    references NAME,
  [REGISTRATIONNO] nvarchar(30),
  [VATNO] nvarchar(30),
  [INCORPORATED] nvarchar(254),
  [PARENT] int,
  [INCORPORATED_TID] int,
  [STATETAXNO] nvarchar(30),
  [NUMBEROFSTAFF] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1ORGANISATION
  on ORGANISATION (PARENT)
;

create table PAYMENTMETHODS
(
  [PAYMENTMETHOD] int not null
    constraint XPKPAYMENTMETHODS
    primary key,
  [PAYMENTDESCRIPTION] nvarchar(30) not null,
  [PRESENTPHYSICALLY] decimal(1) not null,
  [USEDBY] smallint,
  [PAYMENTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table BANKHISTORY
  add constraint R_1441
foreign key (PAYMENTMETHOD) references PAYMENTMETHODS
;

alter table CASHITEM
  add constraint R_1440
foreign key (ITEMTYPE) references PAYMENTMETHODS
;

create table PERIOD
(
  [PERIODID] int not null
    constraint XPKPERIOD
    primary key,
  [LABEL] nvarchar(20),
  [STARTDATE] datetime,
  [ENDDATE] datetime,
  [POSTINGCOMMENCED] datetime,
  [LABEL_TID] int,
  [YEARENDROLLOVERFL] smallint default 0 not null,
  [LEDGERPERIODOPENFL] decimal(1) default 1 not null,
  [CLOSEDFOR] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CONTROLTOTAL
  add constraint R_30006
foreign key (PERIODID) references PERIOD
;

alter table GLJOURNAL
  add constraint R_1566
foreign key (POSTPERIOD) references PERIOD
;

alter table GLJOURNAL
  add constraint R_1567
foreign key (JOURNALPERIOD) references PERIOD
;

create table POLICING
(
  [DATEENTERED] datetime not null,
  [POLICINGSEQNO] int not null,
  [POLICINGNAME] nvarchar(40) not null,
  [SYSGENERATEDFLAG] decimal(1),
  [ONHOLDFLAG] decimal(1),
  [IRN] nvarchar(30),
  [PROPERTYTYPE] nchar(1),
  [COUNTRYCODE] nvarchar(3)
    constraint R_997
    references COUNTRY,
  [DATEOFACT] datetime,
  [ACTION] nvarchar(2)
    constraint R_999
    references ACTIONS,
  [EVENTNO] int
    constraint R_1003
    references EVENTS,
  [NAMETYPE] nvarchar(3)
    constraint R_1002
    references NAMETYPE,
  [NAMENO] int
    constraint R_1000
    references NAME,
  [CASETYPE] nchar(1)
    constraint R_994
    references CASETYPE,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2),
  [FROMDATE] datetime,
  [UNTILDATE] datetime,
  [NOOFDAYS] smallint,
  [LETTERDATE] datetime,
  [CRITICALONLYFLAG] decimal(1),
  [CRITLETTERSFLAG] decimal(1),
  [CRITREMINDFLAG] decimal(1),
  [UPDATEFLAG] decimal(1),
  [REMINDERFLAG] decimal(1),
  [ADHOCFLAG] decimal(1),
  [CRITERIAFLAG] decimal(1),
  [DUEDATEFLAG] decimal(1),
  [CALCREMINDERFLAG] decimal(1),
  [EXCLUDEPROPERTY] decimal(1),
  [EXCLUDECOUNTRY] decimal(1),
  [EXCLUDEACTION] decimal(1),
  [EMPLOYEENO] int
    constraint R_194
    references NAME,
  [CASEID] int
    constraint R_1387
    references CASES,
  [CRITERIANO] int
    constraint R_1388
    references CRITERIA,
  [CYCLE] smallint,
  [TYPEOFREQUEST] smallint,
  [COUNTRYFLAGS] int,
  [FLAGSETON] decimal(1),
  [SQLUSER] nvarchar(30),
  [DUEDATEONLYFLAG] decimal(1),
  [LETTERFLAG] decimal(1),
  [BATCHNO] int,
  [IDENTITYID] int,
  [ADHOCNAMENO] int,
  [ADHOCDATECREATED] datetime,
  [RECALCEVENTDATE] bit default 0,
  [POLICINGNAME_TID] int,
  [CASEOFFICEID] nvarchar(254),
  [SCHEDULEDDATETIME] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PENDING] bit default 0 not null,
  [SPIDINPROGRESS] int,
  constraint XPKPOLICING
  primary key (DATEENTERED, POLICINGSEQNO)
)
;

create unique index XAK1POLICING
  on POLICING (POLICINGNAME)
;

create index XIE1POLICING
  on POLICING (CASEID)
;

create table POLICINGERRORS
(
  [STARTDATETIME] datetime not null,
  [ERRORSEQNO] smallint not null,
  [CASEID] int
    constraint R_1315
    references CASES,
  [CRITERIANO] int
    constraint R_1317
    references CRITERIA,
  [EVENTNO] int
    constraint R_1316
    references EVENTS,
  [CYCLENO] smallint,
  [MESSAGE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKPOLICINGERRORS
  primary key (STARTDATETIME, ERRORSEQNO)
)
;

create index XIE1POLICINGERRORS
  on POLICINGERRORS (CASEID)
;

create table POLICINGLOG
(
  [STARTDATETIME] datetime not null
    constraint XPKPOLICINGLOG
    primary key,
  [USERNAME] nvarchar(40),
  [POLICINGNAME] nvarchar(40),
  [FROMDATE] datetime,
  [NOOFDAYS] smallint,
  [FINISHDATETIME] datetime,
  [OPENACTIONCOUNT] int,
  [CASEEVENTCOUNT] int,
  [REMINDERCOUNT] smallint,
  [LETTERCOUNT] smallint,
  [PROGRAMVERSION] float,
  [FAILMESSAGE] nvarchar(254),
  [PROCESSINGCASEID] int,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table POLICINGERRORS
  add constraint R_1314
foreign key (STARTDATETIME) references POLICINGLOG
;

create table PROFITCENTRE
(
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint XPKPROFITCENTRE
    primary key,
  [ENTITYNO] int not null,
  [DESCRIPTION] nvarchar(50),
  [DESCRIPTION_TID] int,
  [INCLUDEONLYWIP] nvarchar(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table BANKACCOUNT
  add constraint R_1161
foreign key (CABPROFITCENTRE) references PROFITCENTRE
;

alter table BANKACCOUNT
  add constraint R_1163
foreign key (CABCPROFITCENTRE) references PROFITCENTRE
;

alter table CASEPROFITCENTRE
  add constraint R_1235
foreign key (PROFITCENTRECODE) references PROFITCENTRE
;

--alter table CASES
--  add constraint R_81498
--foreign key (PROFITCENTRECODE) references PROFITCENTRE
--;

alter table EMPLOYEE
  add constraint RI_1230
foreign key (PROFITCENTRECODE) references PROFITCENTRE
;

alter table GENERALLEDGERACCTS
  add constraint R_1025
foreign key (PROFITCENTRECODE) references PROFITCENTRE
;

alter table GLJOURNALLINE
  add constraint R_1092
foreign key (ACCTPROFITCENTRE) references PROFITCENTRE
;

create table PROGRAM
(
  [PROGRAMID] nvarchar(8) not null
    constraint XPKPROGRAM
    primary key,
  [PROGRAMNAME] nvarchar(50),
  [PARENTPROGRAM] nvarchar(8),
  [PROGRAMNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROGRAMGROUP] nvarchar(1)
)
;

alter table CRITERIA
  add constraint R_764
foreign key (PROGRAMID) references PROGRAM
;

create table PROPERTY
(
  [CASEID] int not null
    constraint XPKPROPERTY
    primary key
    constraint R_897
    references CASES,
  [BASIS] nvarchar(2)
    constraint R_814
    references APPLICATIONBASIS,
  [REGISTEREDUSERS] nchar(1),
  [DEBTORTYPE] int,
  [EXAMTYPE] int,
  [NOOFCLAIMS] smallint,
  [GOODSSERVICES] nchar(1),
  [RENEWALSTATUS] smallint,
  [RENEWALTYPE] int,
  [RENEWALCYCLE] smallint,
  [RENEWALNOTES] nvarchar(254),
  [PAYMENTFLAG] decimal(1),
  [DEBITRAISEDFLAG] decimal(1),
  [WORKINGINSTR] decimal(1),
  [PLACEFIRSTUSED] nvarchar(254),
  [PROPOSEDUSE] nvarchar(254),
  [PLACEFIRSTUSED_TID] int,
  [PROPOSEDUSE_TID] int,
  [RENEWALNOTES_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1PROPERTY
  on PROPERTY (RENEWALTYPE)
;

create index XIE2PROPERTY
  on PROPERTY (DEBTORTYPE)
;

create index XIE3PROPERTY
  on PROPERTY (EXAMTYPE)
;

create table PROPERTYTYPE
(
  [PROPERTYTYPE] nchar(1) not null
    constraint XPKPROPERTYTYPE
    primary key,
  [PROPERTYNAME] nvarchar(50),
  [ALLOWSUBCLASS] decimal(1) default 0 not null,
  [PROPERTYNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CRMONLY] bit default 0
)
;

alter table ASSOCIATEDNAME
  add constraint R_836
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table BILLFORMAT
  add constraint RI_1298
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table BILLRULE
  add constraint R_1481
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table CASEPROFITCENTRE
  add constraint R_1233
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

--alter table CASES
--  add constraint R_446
--foreign key (PROPERTYTYPE) references PROPERTYTYPE
--;

alter table CRITERIA
  add constraint R_437
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table CRITERIA
  add constraint R_91506
foreign key (NEWPROPERTYTYPE) references PROPERTYTYPE
;

alter table DISCOUNT
  add constraint RI_926
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table FEELIST
  add constraint R_1085
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table GLACCOUNTMAPPING
  add constraint R_1579
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table IMPORTCONTROL
  add constraint R_1454
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table INTERNALREFSTEM
  add constraint RI_1089
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table LETTER
  add constraint RI_1109
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table NAMEALIAS
  add constraint R_81618
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table NAMEINSTRUCTIONS
  add constraint R_381
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table NAMELANGUAGE
  add constraint R_1339
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

alter table POLICING
  add constraint R_996
foreign key (PROPERTYTYPE) references PROPERTYTYPE
;

create table PROTECTCODES
(
  [PROTECTKEY] smallint not null
    constraint XPKPROTECTCODES
    primary key,
  [TABLECODE] int,
  [TABLETYPE] smallint,
  [EVENTNO] int
    constraint RI_1039
    references EVENTS,
  [CASERELATIONSHIP] nvarchar(3)
    constraint RI_1048
    references CASERELATION,
  [NAMERELATIONSHIP] nvarchar(3)
    constraint RI_1047
    references NAMERELATION,
  [NUMBERTYPE] nchar(1)
    constraint RI_1051
    references NUMBERTYPES,
  [CASETYPE] nchar(1)
    constraint RI_1046
    references CASETYPE,
  [NAMETYPE] nvarchar(3)
    constraint RI_1045
    references NAMETYPE,
  [ADJUSTMENT] nvarchar(4)
    constraint RI_1044
    references ADJUSTMENT,
  [TEXTTYPE] nvarchar(2),
  [FAMILY] nvarchar(20)
    constraint R_1060
    references CASEFAMILY,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1PROTECTCODES
  on PROTECTCODES (TABLECODE)
;

create table QUESTION
(
  [QUESTIONNO] smallint not null
    constraint XPKQUESTION
    primary key,
  [IMPORTANCELEVEL] nvarchar(2)
    constraint R_1090
    references IMPORTANCE,
  [QUESTIONCODE] nvarchar(10),
  [QUESTION] nvarchar(100),
  [YESNOREQUIRED] decimal(1),
  [COUNTREQUIRED] decimal(1),
  [PERIODTYPEREQUIRED] decimal(1),
  [AMOUNTREQUIRED] decimal(1),
  [EMPLOYEEREQUIRED] decimal(1),
  [TEXTREQUIRED] decimal(1),
  [TABLETYPE] smallint,
  [QUESTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CHECKLISTITEM
  add constraint RI_1091
foreign key (QUESTIONNO) references QUESTION
;

alter table CHECKLISTITEM
  add constraint R_1713
foreign key (SOURCEQUESTION) references QUESTION
;

alter table CHECKLISTLETTER
  add constraint R_1390
foreign key (QUESTIONNO) references QUESTION
;

create table QUOTATIONWIPCODE
(
  [QUOTATIONNO] int not null,
  [WIPCODE] nvarchar(6) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUOTATIONWIPCODE
  primary key (QUOTATIONNO, WIPCODE)
)
;

create table RATES
(
  [RATENO] int not null
    constraint XPKRATES
    primary key,
  [RATEDESC] nvarchar(50),
  [RATETYPE] int,
  [USETYPEOFMARK] decimal(1),
  [RATENOSORT] int,
  [RATEDESC_TID] int,
  [CALCLABEL1] nvarchar(30),
  [CALCLABEL2] nvarchar(30),
  [CALCLABEL1_TID] int,
  [CALCLABEL2_TID] int,
  [ACTION] nvarchar(2)
    constraint R_91652
    references ACTIONS,
  [AGENTNAMETYPE] nvarchar(3)
    constraint R_91408
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1RATES
  on RATES (RATENOSORT)
;

create index XIE2RATES
  on RATES (RATETYPE)
;

alter table ACTIVITYREQUEST
  add constraint R_720
foreign key (RATENO) references RATES
;

alter table CRITERIA
  add constraint R_801
foreign key (RATENO) references RATES
;

alter table FEETYPES
  add constraint R_1273
foreign key (RATENO) references RATES
;

create table REASON
(
  [REASONCODE] nvarchar(2) not null
    constraint XPKREASON
    primary key,
  [DESCRIPTION] nvarchar(50),
  [USED_BY] int,
  [SHOWONDEBITNOTE] decimal(1),
  [ISPROTECTED] decimal(1),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table BILLEDITEM
  add constraint RI_1251
foreign key (REASONCODE) references REASON
;

alter table FEESCALCULATION
  add constraint R_1561
foreign key (WRITEUPREASON) references REASON
;

alter table GLACCOUNTMAPPING
  add constraint R_1582
foreign key (REASONCODE) references REASON
;

create table RECIPROCITY
(
  [CASETYPE] nchar(1) not null
    constraint R_868
    references CASETYPE,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_863
    references PROPERTYTYPE,
  [YEAROFRECEIPT] smallint not null,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_864
    references COUNTRY,
  [CATEGORY] int not null,
  [NAMENO] int not null
    constraint R_173
    references NAME,
  [NAMETYPE] nvarchar(3) not null
    constraint R_867
    references NAMETYPE,
  [TOTALCASES] smallint,
  [SERVICECHARGE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKRECIPROCITY
  primary key (CASETYPE, PROPERTYTYPE, YEAROFRECEIPT, COUNTRYCODE, CATEGORY, NAMENO, NAMETYPE)
)
;

create index XIE1RECIPROCITY
  on RECIPROCITY (CATEGORY)
;

create table RECORDTYPE
(
  [RECORDTYPE] nchar(1) not null
    constraint XPKRECORDTYPE
    primary key,
  [RECORDTYPEDESC] nvarchar(10) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table RELATEDCASE
(
  [CASEID] int not null
    constraint R_20022
    references CASES,
  [RELATIONSHIPNO] int not null,
  [RELATIONSHIP] nvarchar(3)
    constraint R_704
    references CASERELATION,
  [RELATEDCASEID] int
    constraint R_980
    references CASES,
  [OFFICIALNUMBER] nvarchar(36),
  [COUNTRYCODE] nvarchar(3)
    constraint R_898
    references COUNTRY,
  [COUNTRYFLAGS] int,
  [CLASS] nvarchar(254),
  [QUOTE] decimal(7,2),
  [AGENT] int
    constraint R_992
    references NAME,
  [TRANSLATOR] int
    constraint R_993
    references NAME,
  [TREATYCODE] nvarchar(3)
    constraint R_20062
    references COUNTRY,
  [PRIORITYDATE] datetime,
  [SEARCHDATE] datetime,
  [RECORDALFLAGS] smallint,
  [ACCEPTANCEDETAILS] nvarchar(2000),
  [CURRENTSTATUS] int,
  [CYCLE] smallint,
  [TITLE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKRELATEDCASE
  primary key (CASEID, RELATIONSHIPNO)
)
;

create index XIE1RELATEDCASE
  on RELATEDCASE (RELATEDCASEID, RELATIONSHIP)
;

create index XIE2RELATEDCASE
  on RELATEDCASE (COUNTRYCODE, RELATIONSHIP)
;

create index XIE3RELATEDCASE
  on RELATEDCASE (TRANSLATOR)
;

create index XIE4RELATEDCASE
  on RELATEDCASE (AGENT)
;

create table RELATEDEVENTS
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [RELATEDNO] smallint not null,
  [RELATEDEVENT] int
    constraint R_20094
    references EVENTS,
  [CLEAREVENT] decimal(1),
  [CLEARDUE] decimal(1),
  [SATISFYEVENT] decimal(1),
  [UPDATEEVENT] decimal(1),
  [CREATENEXTCYCLE] decimal(1),
  [ADJUSTMENT] nvarchar(4)
    constraint R_20018
    references ADJUSTMENT,
  [INHERITED] decimal(1),
  [RELATIVECYCLE] smallint default 0,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CLEAREVENTONDUECHANGE] bit,
  [CLEARDUEONDUECHANGE] bit,
  constraint XPKRELATEDEVENTS
  primary key (CRITERIANO, EVENTNO, RELATEDNO)
)
;

create index XIE1RELATEDEVENTS
  on RELATEDEVENTS (EVENTNO)
;

create index XIE2RELATEDEVENTS
  on RELATEDEVENTS (RELATEDEVENT)
;

create table REPORTCOLUMNS
(
  [PROGRAMID] nvarchar(8) not null,
  [REPORTNAME] nvarchar(30) not null,
  [DISPLAYNAME] nvarchar(30) not null,
  [COLUMNNAME] nvarchar(18) not null,
  [PARAMETER] nvarchar(20),
  [DISPLAYSEQUENCE] smallint,
  [SORTORDER] smallint,
  [SORTDIRECTION] nvarchar(4),
  [COLUMNDESC] nvarchar(254),
  [DISPLAYNAME_TID] int,
  [COLUMNDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREPORTCOLUMNS
  primary key (PROGRAMID, REPORTNAME, DISPLAYNAME)
)
;

create table REPORTS
(
  [PROGRAMID] nvarchar(8) not null,
  [REPORTNAME] nvarchar(30) not null,
  [MENUCODE] int,
  [USERID] nvarchar(30),
  [CASETYPE] nchar(1)
    constraint R_1285
    references CASETYPE,
  [DONOTDELETEFLAG] decimal(1),
  [PROPERTYTYPE] nchar(1)
    constraint R_1284
    references PROPERTYTYPE,
  [LANGUAGE_CODE] int
    constraint R_1358
    references LANGUAGE,
  [DEFAULTTITLE] nvarchar(80),
  [REPORTDESCRIPTION] nvarchar(254),
  [QRPFILE] nvarchar(254),
  [REPORTNAME_TID] int,
  [DEFAULTTITLE_TID] int,
  [REPORTDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREPORTS
  primary key (PROGRAMID, REPORTNAME)
)
;

create index XIE1REPORTS
  on REPORTS (MENUCODE)
;

alter table REPORTCOLUMNS
  add constraint R_1360
foreign key (PROGRAMID, REPORTNAME) references REPORTS
;

create table REQATTRIBUTES
(
  [CRITERIANO] int not null
    constraint R_895
    references CRITERIA,
  [TABLETYPE] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREQATTRIBUTES
  primary key (CRITERIANO, TABLETYPE)
)
;

create table ROWACCESS
(
  [ACCESSNAME] nvarchar(30) not null
    constraint XPKROWACCESS
    primary key,
  [ACCESSDESC] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GROUPROWACCESS
  add constraint R_1534
foreign key (ACCESSNAME) references ROWACCESS
;

create table ROWACCESSDETAIL
(
  [ACCESSNAME] nvarchar(30) not null
    constraint R_1532
    references ROWACCESS,
  [SEQUENCENO] int not null,
  [RECORDTYPE] nchar(1)
    constraint R_1555
    references RECORDTYPE,
  [OFFICE] int,
  [CASETYPE] nchar(1)
    constraint R_1536
    references CASETYPE,
  [PROPERTYTYPE] nchar(1)
    constraint R_1537
    references PROPERTYTYPE,
  [SECURITYFLAG] smallint not null,
  [NAMETYPE] nvarchar(3)
    constraint R_241
    references NAMETYPE,
  [NAMENO] int
    constraint R_242
    references NAME,
  [SUBSTITUTENAME] smallint,
  [CRM] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKROWACCESSDETAIL
  primary key (ACCESSNAME, SEQUENCENO)
)
;

create unique index XAK1ROWACCESSDETAIL
  on ROWACCESSDETAIL (ACCESSNAME, RECORDTYPE, OFFICE, CASETYPE, PROPERTYTYPE, NAMETYPE, NAMENO, SUBSTITUTENAME)
;

create table SCREENCONTROL
(
  [CRITERIANO] int not null
    constraint R_20070
    references CRITERIA,
  [SCREENNAME] nvarchar(32) not null,
  [SCREENID] smallint not null,
  [ENTRYNUMBER] smallint,
  [SCREENTITLE] nvarchar(50),
  [DISPLAYSEQUENCE] smallint,
  [CHECKLISTTYPE] smallint
    constraint R_20045
    references CHECKLISTS,
  [TEXTTYPE] nvarchar(2),
  [NAMETYPE] nvarchar(3)
    constraint RI_960
    references NAMETYPE,
  [NAMEGROUP] smallint
    constraint R_1067
    references NAMEGROUPS,
  [FLAGNUMBER] int,
  [CREATEACTION] nvarchar(2)
    constraint R_1070
    references ACTIONS,
  [RELATIONSHIP] nvarchar(3)
    constraint R_1069
    references CASERELATION,
  [INHERITED] decimal(1),
  [PROFILENAME] nvarchar(50),
  [SCREENTIP] nvarchar(254),
  [MANDATORYFLAG] decimal(1),
  [GENERICPARAMETER] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSCREENCONTROL
  primary key (CRITERIANO, SCREENNAME, SCREENID)
)
;

alter table FIELDCONTROL
  add constraint RI_959
foreign key (CRITERIANO, SCREENNAME, SCREENID) references SCREENCONTROL
;

create table SEARCHRESULTS
(
  [COUNTRYCODE] nvarchar(3)
    constraint R_918
    references COUNTRY,
  [OFFICIALNO] nvarchar(36),
  [ISSUEDDATE] datetime,
  [RECEIVEDDATE] datetime,
  [PUBLICATIONDATE] datetime,
  [PRIORITYDATE] datetime,
  [PUBLICATION] nvarchar(254),
  [ISSUINGCOUNTRY] nvarchar(3)
    constraint R_1124
    references COUNTRY,
  [PRIORARTID] int identity
    constraint XPKSEARCHRESULTS
    primary key,
  [TITLE] nvarchar(254),
  [CITATION] nvarchar(254),
  [DESCRIPTION] nvarchar(254),
  [REFPAGES] nvarchar(254),
  [INVENTORNAME] nvarchar(254),
  [CLASS] nvarchar(254),
  [SUBCLASS] nvarchar(254),
  [SOURCE] int,
  [KINDCODE] nvarchar(254),
  [PATENTRELATED] bit,
  [TRANSLATION] int,
  [TITLE_TID] int,
  [CITATION_TID] int,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [GRANTEDDATE] datetime,
  [ISSOURCEDOCUMENT] bit,
  [APPFILEDDATE] datetime,
  [PTOCITEDDATE] datetime
)
;

create index XIE1SEARCHRESULTS
  on SEARCHRESULTS (SOURCE)
;

create index XIE2SEARCHRESULTS
  on SEARCHRESULTS (TRANSLATION)
;

create table SECURITYGROUP
(
  [SECURITYGROUP] nvarchar(30) not null
    constraint XPKSECURITYGROUPS
    primary key,
  [SECURITYGROUP_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ASSIGNEDUSERS
  add constraint R_906
foreign key (SECURITYGROUP) references SECURITYGROUP
;

alter table GROUPAPPLICATION
  add constraint R_1304
foreign key (SECURITYGROUP) references SECURITYGROUP
;

alter table GROUPCONTROL
  add constraint R_902
foreign key (SECURITYGROUP) references SECURITYGROUP
;

alter table GROUPPROFILES
  add constraint R_1310
foreign key (SECURITYGROUP) references SECURITYGROUP
;

alter table GROUPROWACCESS
  add constraint R_1539
foreign key (SECURITYGROUP) references SECURITYGROUP
;

alter table GROUPSTATUS
  add constraint R_983
foreign key (SECURITYGROUP) references SECURITYGROUP
;

create table SECURITYPROFILE
(
  [PROFILE] nvarchar(30) not null
    constraint XPKSECURITYPROFILE
    primary key,
  [PROFILEDESC] nvarchar(254),
  [PROFILE_TID] int,
  [PROFILEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GROUPPROFILES
  add constraint R_1311
foreign key (PROFILE) references SECURITYPROFILE
;

create table SECURITYTEMPLATE
(
  [NAMEOFTABLE] nvarchar(30) not null,
  [PROFILE] nvarchar(30) not null
    constraint R_1308
    references SECURITYPROFILE,
  [SECURITYFLAG] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSECURITYTEMPLAT
  primary key (NAMEOFTABLE, PROFILE)
)
;

create table SELECTIONTYPES
(
  [PARENTTABLE] nvarchar(50) not null,
  [TABLETYPE] smallint not null,
  [MINIMUMALLOWED] smallint,
  [MAXIMUMALLOWED] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSELECTIONTYPES
  primary key (PARENTTABLE, TABLETYPE)
)
;

create table SITECONTROL
(
  [CONTROLID] nvarchar(30) not null
    constraint XPKSITECONTROL
    primary key,
  [OWNER] nvarchar(1),
  [DATATYPE] nvarchar(1),
  [COLINTEGER] int,
  [COLCHARACTER] nvarchar(254),
  [COLDECIMAL] decimal(12,2),
  [COLDATE] datetime,
  [COLBOOLEAN] decimal(1),
  [COMMENTS] nvarchar(254),
  [COMMENTS_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table SITEOPTIONS
(
  [SITEKEY] nvarchar(1) not null
    constraint XPKSITEOPTIONS
    primary key,
  [CHECKSTATUSORDER] decimal(1),
  [KEEPREQUESTS] decimal(1),
  [GENERATENAMECODE] decimal(1),
  [NAMECODELENGTH] smallint,
  [LASTNAMECODE] nvarchar(10),
  [IRNLENGTH] smallint,
  [LASTIRN] nvarchar(12),
  [LASTDEBITNO] nvarchar(10),
  [HOLDEXCLUDEDAYS] smallint,
  [MAXSTREETLINES] smallint,
  [MAXLOCATIONS] smallint,
  [DEFAULTDEBITCOPIES] smallint,
  [LANGUAGE] int,
  [KEEPSPECIHISTORY] decimal(1),
  [PROMPTCOUNTRY] decimal(1),
  [TAXLITERAL] nvarchar(15),
  [TAXREQUIRED] decimal(1),
  [TAXSERVICE] decimal(1),
  [TAXFEES] decimal(1),
  [TAXDISBURSEMENTS] decimal(1),
  [HOMECOUNTRY] nvarchar(3)
    constraint RI_987
    references COUNTRY,
  [CURRENCY] nvarchar(3)
    constraint R_1034
    references CURRENCY,
  [LETTERSAFTERDAYS] smallint,
  [CASEDETAILFLAG] decimal(1),
  [HOMENAMENO] int
    constraint R_1012
    references NAME,
  [IPOFFICE] int
    constraint R_1013
    references NAME,
  [SHOWNAMECODEFLAG] decimal(1),
  [SEARCHSOUNDEXFLAG] decimal(1),
  [EXTACCOUNTSFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1SITEOPTIONS
  on SITEOPTIONS (LANGUAGE)
;

create table SPECIALNAME
(
  [NAMENO] int not null
    constraint XPKSPECIALNAME
    primary key
    constraint R_1119
    references NAME,
  [ENTITYFLAG] decimal(1),
  [IPOFFICEFLAG] decimal(1),
  [BANKFLAG] decimal(1),
  [LASTOPENITEMNO] int,
  [LASTDRAFTNO] int,
  [LASTARNO] int,
  [LASTINTERNALITEMNO] int,
  [CURRENCY] nvarchar(3)
    constraint R_91420
    references CURRENCY,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [LASTAPNO] int
)
;

alter table ACCOUNT
  add constraint R_1217
foreign key (ENTITYNO) references SPECIALNAME
;

alter table ACTIVITYREQUEST
  add constraint R_1349
foreign key (ENTITYNO) references SPECIALNAME
;

alter table BANKACCOUNT
  add constraint R_1416
foreign key (BANKNAMENO) references SPECIALNAME
;

alter table BILLFORMAT
  add constraint R_1507
foreign key (ENTITYNO) references SPECIALNAME
;

alter table BILLRULE
  add constraint R_1478
foreign key (ENTITYNO) references SPECIALNAME
;

alter table BILLRULE
  add constraint R_1483
foreign key (BILLINGENTITY) references SPECIALNAME
;

alter table CASHITEM
  add constraint R_1459
foreign key (ACCTENTITYNO) references SPECIALNAME
;

alter table CONTROLTOTAL
  add constraint R_7000
foreign key (ENTITYNO) references SPECIALNAME
;

alter table DEBITNOTEIMAGE
  add constraint R_1549
foreign key (ENTITYNO) references SPECIALNAME
;

alter table EMPLOYEE
  add constraint R_91448
foreign key (DEFAULTENTITYNO) references SPECIALNAME
;

alter table EXPENSEIMPORT
  add constraint R_1484
foreign key (ENTITYNAMENO) references SPECIALNAME
;

alter table GENERALLEDGERACCTS
  add constraint R_1024
foreign key (ENTITYNO) references SPECIALNAME
;

alter table GLACCOUNTMAPPING
  add constraint R_1573
foreign key (ENTITY) references SPECIALNAME
;

alter table GLJOURNALLINE
  add constraint R_1091
foreign key (ACCTENTITYNO) references SPECIALNAME
;

alter table PROFITCENTRE
  add constraint RI_1171
foreign key (ENTITYNO) references SPECIALNAME
;

create table STATE
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_20057
    references COUNTRY,
  [STATE] nvarchar(20) not null,
  [STATENAME] nvarchar(40),
  [STATENAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTATE
  primary key (COUNTRYCODE, STATE)
)
;

create index XIESTATE
  on STATE (STATE)
;

create table STATUS
(
  [STATUSCODE] smallint not null
    constraint XPKSTATUS
    primary key,
  [DISPLAYSEQUENCE] smallint,
  [USERSTATUSCODE] nvarchar(10),
  [INTERNALDESC] nvarchar(50),
  [EXTERNALDESC] nvarchar(50),
  [LIVEFLAG] decimal(1),
  [REGISTEREDFLAG] decimal(1),
  [RENEWALFLAG] decimal(1),
  [POLICERENEWALS] decimal(1),
  [POLICEEXAM] decimal(1),
  [POLICEOTHERACTIONS] decimal(1),
  [LETTERSALLOWED] decimal(1),
  [CHARGESALLOWED] decimal(1),
  [REMINDERSALLOWED] decimal(1),
  [CONFIRMATIONREQ] decimal(1),
  [STOPPAYREASON] nchar(1),
  [EXTERNALDESC_TID] int,
  [INTERNALDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PREVENTWIP] bit,
  [PREVENTBILLING] bit,
  [PREVENTPREPAYMENT] bit,
  [PRIORARTFLAG] bit
)
;

alter table ACTIVITYREQUEST
  add constraint R_817
foreign key (STATUSCODE) references STATUS
;

--alter table CASES
--  add constraint R_690
--foreign key (STATUSCODE) references STATUS
--;

alter table CRITERIA
  add constraint R_91840
foreign key (RENEWALSTATUS) references STATUS
;

alter table CRITERIA
  add constraint R_91841
foreign key (STATUSCODE) references STATUS
;

alter table DETAILCONTROL
  add constraint R_775
foreign key (STATUSCODE) references STATUS
;

alter table DETAILCONTROL
  add constraint R_778
foreign key (RENEWALSTATUS) references STATUS
;

alter table GROUPSTATUS
  add constraint RI_984
foreign key (STATUSCODE) references STATUS
;

alter table OPENACTION
  add constraint R_933
foreign key (STATUSCODE) references STATUS
;

alter table PROPERTY
  add constraint R_696
foreign key (RENEWALSTATUS) references STATUS
;

create table STATUSSEQUENCE
(
  [STATUSCODE] smallint not null
    constraint R_394
    references STATUS,
  [PRECEEDINGSTATUS] smallint not null
    constraint R_393
    references STATUS,
  [PROGRESSIONFLAG] nchar(1),
  [WARNINGMESSAGE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTATUSSEQUENCE
  primary key (STATUSCODE, PRECEEDINGSTATUS)
)
;

create index XIE1STATUSSEQUENCE
  on STATUSSEQUENCE (PRECEEDINGSTATUS)
;

create table SUBTYPE
(
  [SUBTYPE] nvarchar(2) not null
    constraint XPKSUBTYPE
    primary key,
  [SUBTYPEDESC] nvarchar(50),
  [SUBTYPEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

--alter table CASES
--  add constraint R_875
--foreign key (SUBTYPE) references SUBTYPE
--;

alter table CRITERIA
  add constraint R_439
foreign key (SUBTYPE) references SUBTYPE
;

alter table POLICING
  add constraint R_998
foreign key (SUBTYPE) references SUBTYPE
;

create table SYNONYMS
(
  [KEYWORDNO] int not null,
  [KWSYNONYM] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSYNONYMS
  primary key (KEYWORDNO, KWSYNONYM)
)
;

create table TABLEATTRIBUTES
(
  [PARENTTABLE] nvarchar(50) not null,
  [GENERICKEY] nvarchar(20) not null,
  [TABLECODE] int not null,
  [TABLETYPE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTABLEATTRIBUTES
  primary key (PARENTTABLE, GENERICKEY, TABLECODE)
)
;

create index XIE2TABLEATTRIBUTES
  on TABLEATTRIBUTES (TABLETYPE)
;

create index XIE1TABLEATTRIBUTES
  on TABLEATTRIBUTES (TABLECODE)
;

create index XIE100TABLEATTRIBUTES
  on TABLEATTRIBUTES (GENERICKEY, TABLECODE, TABLETYPE)
;

create table TABLECODES
(
  [TABLECODE] int not null
    constraint XPKTABLECODES
    primary key,
  [TABLETYPE] smallint,
  [DESCRIPTION] nvarchar(80),
  [USERCODE] nvarchar(50),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [BOOLEANFLAG] bit
)
;

create index XIE1TABLECODES
  on TABLECODES (TABLETYPE, USERCODE)
;

alter table ACTIVITYATTACHMENT
  add constraint R_1274
foreign key (ATTACHMENTTYPE) references TABLECODES
;

alter table ACTIVITYATTACHMENT
  add constraint R_1275
foreign key (LANGUAGENO) references TABLECODES
;

alter table ACTIVITYREQUEST
  add constraint R_759
foreign key (ACTIVITYCODE) references TABLECODES
;

alter table ACTIVITYREQUEST
  add constraint R_1272
foreign key (PRODUCTCODE) references TABLECODES
;

alter table ACTIVITYREQUEST
  add constraint R_91865
foreign key (EDEOUTPUTTYPE) references TABLECODES
;

alter table ALERT
  add constraint RI_1279
foreign key (SENDMETHOD) references TABLECODES
;

alter table ASSOCIATEDNAME
  add constraint R_837
foreign key (JOBROLE) references TABLECODES
;

alter table ASSOCIATEDNAME
  add constraint R_838
foreign key (POSITIONCATEGORY) references TABLECODES
;

alter table ASSOCIATEDNAME
  add constraint R_892
foreign key (VALEDICTION) references TABLECODES
;

alter table AUDITLOCATION
  add constraint R_1377
foreign key (FILELOCATION) references TABLECODES
;

alter table BANKACCOUNT
  add constraint R_1419
foreign key (ACCOUNTTYPE) references TABLECODES
;

alter table BANKACCOUNT
  add constraint R_1130
foreign key (BANKOPERATIONCODE) references TABLECODES
;

alter table BANKACCOUNT
  add constraint R_1131
foreign key (DETAILSOFCHARGES) references TABLECODES
;

alter table BILLFORMAT
  add constraint R_1414
foreign key (LANGUAGE) references TABLECODES
;

alter table BILLRULE
  add constraint R_1475
foreign key (RULETYPE) references TABLECODES
;

alter table BILLRULE
  add constraint R_1479
foreign key (NAMECATEGORY) references TABLECODES
;

alter table CASEIMAGE
  add constraint R_686
foreign key (IMAGETYPE) references TABLECODES
;

alter table CASELOCATION
  add constraint R_30007
foreign key (FILELOCATION) references TABLECODES
;

alter table CASENAME
  add constraint R_81501
foreign key (CORRESPRECEIVED) references TABLECODES
;

--alter table CASES
--  add constraint R_979
--foreign key (TYPEOFMARK) references TABLECODES
--;

--alter table CASES
--  add constraint RI_1023
--foreign key (ENTITYSIZE) references TABLECODES
--;

alter table CASHITEM
  add constraint R_1432
foreign key (CREDITCARDTYPE) references TABLECODES
;

alter table CASHITEM
  add constraint R_1133
foreign key (BANKOPERATIONCODE) references TABLECODES
;

alter table CASHITEM
  add constraint R_1132
foreign key (DETAILSOFCHARGES) references TABLECODES
;

alter table CASHITEM
  add constraint RI_1119
foreign key (EFTFILEFORMAT) references TABLECODES
;

alter table CASHITEM
  add constraint R_81569
foreign key (INSTRUCTIONCODE) references TABLECODES
;

alter table COUNTRY
  add constraint R_1617
foreign key (NAMESTYLE) references TABLECODES
;

alter table COUNTRY
  add constraint R_1618
foreign key (ADDRESSSTYLE) references TABLECODES
;

alter table CRITERIA
  add constraint RI_964
foreign key (TABLECODE) references TABLECODES
;

alter table CRITERIA
  add constraint RI_1261
foreign key (GROUPID) references TABLECODES
;

alter table CRITERIA
  add constraint RI_1270
foreign key (PRODUCTCODE) references TABLECODES
;

alter table CRITERIA
  add constraint R_91836
foreign key (RULETYPE) references TABLECODES
;

alter table CRITERIA
  add constraint R_91837
foreign key (DATASOURCETYPE) references TABLECODES
;

alter table DEBITNOTEIMAGE
  add constraint R_1548
foreign key (LANGUAGECODE) references TABLECODES
;

alter table DEFAULTACTIVITY
  add constraint R_5001
foreign key (ACTIVITYTYPE) references TABLECODES
;

alter table DEFAULTACTIVITY
  add constraint R_5002
foreign key (ACTIVITYCATEGORY) references TABLECODES
;

alter table DELIVERYMETHOD
  add constraint R_1344
foreign key (DELIVERYTYPE) references TABLECODES
;

alter table DETAILCONTROL
  add constraint R_777
foreign key (FILELOCATION) references TABLECODES
;

alter table DISCOUNT
  add constraint RI_1297
foreign key (PRODUCTCODE) references TABLECODES
;

alter table EMPLOYEE
  add constraint R_827
foreign key (STAFFCLASS) references TABLECODES
;

alter table EMPLOYEE
  add constraint R_869
foreign key (CAPACITYTOSIGN) references TABLECODES
;

alter table EVENTS
  add constraint R_91882
foreign key (EVENTGROUP) references TABLECODES
;

alter table FEELISTCASE
  add constraint RI_1274
foreign key (QUANTITYDESC) references TABLECODES
;

alter table FEESCALCULATION
  add constraint R_793
foreign key (DEBTORTYPE) references TABLECODES
;

alter table FEESCALCULATION
  add constraint R_1271
foreign key (PRODUCTCODE) references TABLECODES
;

alter table FILEPART
  add constraint R_81754
foreign key (FILEPARTTYPE) references TABLECODES
;

alter table FILEPART
  add constraint R_81755
foreign key (FILERECORDSTATUS) references TABLECODES
;

alter table FILEREQUEST
  add constraint R_1373
foreign key (FILELOCATION) references TABLECODES
;

alter table FILEREQUEST
  add constraint R_81743
foreign key (PRIORITY) references TABLECODES
;

alter table GLACCOUNTDEFAULTS
  add constraint R_1612
foreign key (AMOUNTTYPE) references TABLECODES
;

alter table GLACCOUNTING
  add constraint R_1571
foreign key (AMOUNTTYPE) references TABLECODES
;

alter table GLACCOUNTMAPPING
  add constraint R_77
foreign key (STAFFCLASS) references TABLECODES
;

alter table GLFIELDRULECONTENT
  add constraint R_1595
foreign key (NAMEDATA) references TABLECODES
;

alter table GLJOURNAL
  add constraint R_1568
foreign key (STATUS) references TABLECODES
;

alter table IMAGEDETAIL
  add constraint RI_1011
foreign key (IMAGESTATUS) references TABLECODES
;

alter table IMPORTBATCH
  add constraint R_1458
foreign key (BATCHTYPE) references TABLECODES
;

alter table IPNAME
  add constraint R_20120
foreign key (DEBTORTYPE) references TABLECODES
;

alter table IPNAME
  add constraint R_344
foreign key (USEDEBTORTYPE) references TABLECODES
;

alter table IPNAME
  add constraint R_364
foreign key (CATEGORY) references TABLECODES
;

alter table IPNAME
  add constraint R_39
foreign key (BILLINGFREQUENCY) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91518
foreign key (SEGMENT1CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91519
foreign key (SEGMENT2CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91520
foreign key (SEGMENT3CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91521
foreign key (SEGMENT4CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91522
foreign key (SEGMENT5CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91523
foreign key (SEGMENT6CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91524
foreign key (SEGMENT7CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91525
foreign key (SEGMENT8CODE) references TABLECODES
;

alter table IRFORMAT
  add constraint R_91526
foreign key (SEGMENT9CODE) references TABLECODES
;

alter table LETTER
  add constraint R_91579
foreign key (ACTIVITYTYPE) references TABLECODES
;

alter table LETTER
  add constraint R_91580
foreign key (ACTIVITYCATEGORY) references TABLECODES
;

alter table LETTER
  add constraint R_91888
foreign key (ENTRYPOINTTYPE) references TABLECODES
;

alter table LETTERSUBSTITUTE
  add constraint RI_1105
foreign key (CATEGORY) references TABLECODES
;

alter table LETTERSUBSTITUTE
  add constraint R_1115
foreign key (LANGUAGE) references TABLECODES
;

alter table NAME
  add constraint R_1619
foreign key (NAMESTYLE) references TABLECODES
;

alter table NAMEADDRESS
  add constraint R_322
foreign key (ADDRESSTYPE) references TABLECODES
;

alter table NAMEADDRESS
  add constraint R_891
foreign key (ADDRESSSTATUS) references TABLECODES
;

alter table NAMEADDRESSSNAP
  add constraint R_81655
foreign key (REASONCODE) references TABLECODES
;

alter table NAMEIMAGE
  add constraint R_748
foreign key (IMAGETYPE) references TABLECODES
;

alter table NAMELANGUAGE
  add constraint R_1338
foreign key (LANGUAGE) references TABLECODES
;

alter table NARRATIVESUBSTITUT
  add constraint R_1129
foreign key (LANGUAGE) references TABLECODES
;

alter table OFFSITESTORAGE
  add constraint R_1375
foreign key (FILELOCATION) references TABLECODES
;

alter table PROPERTY
  add constraint R_694
foreign key (DEBTORTYPE) references TABLECODES
;

alter table PROPERTY
  add constraint R_695
foreign key (EXAMTYPE) references TABLECODES
;

alter table PROPERTY
  add constraint R_932
foreign key (RENEWALTYPE) references TABLECODES
;

alter table PROTECTCODES
  add constraint RI_1050
foreign key (TABLECODE) references TABLECODES
;

alter table RATES
  add constraint R_761
foreign key (RATETYPE) references TABLECODES
;

alter table RECIPROCITY
  add constraint R_865
foreign key (CATEGORY) references TABLECODES
;

alter table REPORTS
  add constraint R_1620
foreign key (MENUCODE) references TABLECODES
;

alter table SEARCHRESULTS
  add constraint R_91435
foreign key (SOURCE) references TABLECODES
;

alter table SEARCHRESULTS
  add constraint R_91510
foreign key (TRANSLATION) references TABLECODES
;

alter table SITEOPTIONS
  add constraint RI_943
foreign key (LANGUAGE) references TABLECODES
;

create table TABLETYPE
(
  [TABLETYPE] smallint not null
    constraint XPKTABLETYPE
    primary key,
  [TABLENAME] nvarchar(50),
  [MODIFIABLE] decimal(1),
  [ACTIVITYFLAG] decimal(1),
  [DATABASETABLE] nvarchar(18),
  [TABLENAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ACTIVITYREQUEST
  add constraint R_758
foreign key (ACTIVITYTYPE) references TABLETYPE
;

alter table PROTECTCODES
  add constraint RI_1049
foreign key (TABLETYPE) references TABLETYPE
;

alter table QUESTION
  add constraint R_1096
foreign key (TABLETYPE) references TABLETYPE
;

alter table REQATTRIBUTES
  add constraint R_896
foreign key (TABLETYPE) references TABLETYPE
;

alter table SELECTIONTYPES
  add constraint R_313
foreign key (TABLETYPE) references TABLETYPE
;

alter table TABLEATTRIBUTES
  add constraint R_850
foreign key (TABLETYPE) references TABLETYPE
;

alter table TABLECODES
  add constraint R_318
foreign key (TABLETYPE) references TABLETYPE
;

create table TAXHISTORY
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [HISTORYLINENO] smallint not null,
  [TAXCODE] nvarchar(3) not null,
  [TAXRATE] decimal(8,4),
  [TAXABLEAMOUNT] decimal(11,2),
  [TAXAMOUNT] decimal(11,2),
  [COUNTRYCODE] nvarchar(3)
    constraint R_943
    references COUNTRY,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [STATE] nvarchar(20),
  [HARMONISED] bit,
  [TAXONTAX] bit,
  [MODIFIED] bit,
  [ADJUSTMENT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDNTAXHISTORY
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, HISTORYLINENO, TAXCODE)
)
;

create index XIE1TAXHISTORY
  on TAXHISTORY (TAXCODE, COUNTRYCODE)
;

create index XIE2TAXHISTORY
  on TAXHISTORY (TAXCODE, COUNTRYCODE, STATE)
;

create table taxrates_new
(
  [TAXCODE] varchar(3) not null,
  [DESCRIPTION] varchar(30)
)
;

create unique index XPKTAXRATES
  on taxrates_new (TAXCODE)
;

create table TELECOMMUNICATION
(
  [TELECODE] int not null
    constraint XPKTELECOMMUNICATION
    primary key,
  [TELECOMTYPE] int
    /*constraint R_321
    references TABLECODES*/,
  [ISD] nvarchar(5),
  [AREACODE] nvarchar(5),
  [TELECOMNUMBER] nvarchar(100),
  [EXTENSION] nvarchar(5),
  [CARRIER] int
    /*constraint R_713
    references TABLECODES*/,
  [REMINDEREMAILS] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1TELECOMMUNICATION
  on TELECOMMUNICATION (TELECOMNUMBER)
;

create index XIE2TELECOMMUNICATION
  on TELECOMMUNICATION (AREACODE)
;

create index XIE3TELECOMMUNICATION
  on TELECOMMUNICATION (TELECOMTYPE)
;

create index XIE4TELECOMMUNICATION
  on TELECOMMUNICATION (CARRIER)
;

alter table ADDRESS
  add constraint R_323
foreign key (TELEPHONE) references TELECOMMUNICATION
;

alter table ADDRESS
  add constraint R_324
foreign key (FAX) references TELECOMMUNICATION
;

alter table ADDRESSTELECOM
  add constraint R_890
foreign key (TELECODE) references TELECOMMUNICATION
;

alter table ASSOCIATEDNAME
  add constraint R_825
foreign key (TELEPHONE) references TELECOMMUNICATION
;

alter table ASSOCIATEDNAME
  add constraint R_826
foreign key (FAX) references TELECOMMUNICATION
;

alter table NAME
  add constraint R_301
foreign key (MAINPHONE) references TELECOMMUNICATION
;

alter table NAME
  add constraint R_302
foreign key (FAX) references TELECOMMUNICATION
;

alter table NAME
  add constraint R_1103
foreign key (MAINEMAIL) references TELECOMMUNICATION
;

alter table NAMETELECOM
  add constraint R_306
foreign key (TELECODE) references TELECOMMUNICATION
;

create table TEMPLATECOLUMNS
(
  [NAMEOFTABLE] nvarchar(30) not null,
  [PROFILE] nvarchar(30) not null,
  [COLUMNNAME] nvarchar(18) not null,
  [SECURITYFLAG] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTEMPLATECOLUMNS
  primary key (NAMEOFTABLE, PROFILE, COLUMNNAME),
  constraint R_1326
  foreign key (NAMEOFTABLE, PROFILE) references SECURITYTEMPLATE
)
;

create table TEXTTYPE
(
  [TEXTTYPE] nvarchar(2) not null
    constraint XPKTEXTTYPE
    primary key,
  [TEXTDESCRIPTION] nvarchar(50),
  [USEDBYFLAG] smallint,
  [TEXTDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CASETYPE
  add constraint R_81704
foreign key (KOTTEXTTYPE) references TEXTTYPE
;

alter table NAMETYPE
  add constraint R_81705
foreign key (KOTTEXTTYPE) references TEXTTYPE
;

alter table PROTECTCODES
  add constraint RI_1053
foreign key (TEXTTYPE) references TEXTTYPE
;

alter table SCREENCONTROL
  add constraint R_908
foreign key (TEXTTYPE) references TEXTTYPE
;

create table TIMECOSTING
(
  [COSTINGSEQNO] smallint not null
    constraint XPKTIMECOSTING
    primary key,
  [OFFICE] int,
  [STAFFCLASS] int
    constraint R_1295
    references TABLECODES,
  [EMPLOYEENO] int
    constraint R_197
    references NAME,
  [CASEID] int
    constraint R_1292
    references CASES,
  [NAMENO] int
    constraint R_203
    references NAME,
  [LOCALCLIENTFLAG] decimal(1),
  [DEBTORTYPE] int
    constraint R_1350
    references TABLECODES,
  [ACTIVITY] nvarchar(6),
  [EFFECTIVEDATE] datetime,
  [CHARGEUNITRATE] decimal(10,2),
  [FOREIGNCURRENCY] nvarchar(3)
    constraint R_1615
    references CURRENCY,
  [OWNER] int
    constraint R_1632
    references NAME,
  [INSTRUCTOR] int
    constraint R_1633
    references NAME,
  [LOCALOWNERFLAG] decimal(1),
  [LOCALINSTRUCTORFLG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CASEOFFICE] int,
  [ENDEFFECTIVEDATE] datetime
)
;

create index XIE1TIMECOSTING
  on TIMECOSTING (CASEID)
;

create index XIE2TIMECOSTING
  on TIMECOSTING (DEBTORTYPE)
;

create index XIE3TIMECOSTING
  on TIMECOSTING (STAFFCLASS)
;

create table TITLES
(
  [TITLE] nvarchar(20) not null
    constraint XPKTITLES
    primary key,
  [FULLTITLE] nvarchar(30),
  [GENDERFLAG] nchar(1),
  [DEFAULTFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TRANSACTION_STATUS
(
  [STATUS_ID] smallint not null
    constraint XPKTRANSACTION_STATUS
    primary key,
  [STATUS_DESCRIPTION] nvarchar(20),
  [STATUS_DESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TRANSACTIONHEADER
(
  [ENTITYNO] int not null
    constraint R_1169
    references SPECIALNAME,
  [TRANSNO] int not null,
  [TRANSTATUS] smallint
    constraint R_1616
    references TRANSACTION_STATUS,
  [TRANSDATE] datetime not null,
  [TRANSTYPE] smallint not null,
  [BATCHNO] nvarchar(10),
  [EMPLOYEENO] int
    constraint R_198
    references NAME,
  [USERID] nvarchar(30) not null,
  [ENTRYDATE] datetime not null,
  [SOURCE] int not null,
  [TRANPOSTPERIOD] int
    constraint R_1587
    references PERIOD,
  [TRANPOSTDATE] datetime,
  [GLSTATUS] tinyint,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRANSHEADER
  primary key (ENTITYNO, TRANSNO)
)
;

create index XIE3TRANSHEADER
  on TRANSACTIONHEADER (TRANSTYPE)
;

create index XIE2TRANSHEADER
  on TRANSACTIONHEADER (EMPLOYEENO)
;

create index XIE5TRANSACTIONHEADER
  on TRANSACTIONHEADER (TRANSNO)
;

alter table BANKHISTORY
  add constraint R_1442
foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
;

alter table BILLEDITEM
  add constraint RI_1282
foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER
;

alter table CASHHISTORY
  add constraint R_1436
foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
;

alter table CASHITEM
  add constraint R_1428
foreign key (TRANSENTITYNO, TRANSNO) references TRANSACTIONHEADER
;

alter table CASHITEM
  add constraint R_1430
foreign key (BANKEDBYENTITYNO, BANKEDBYTRANSNO) references TRANSACTIONHEADER
;

alter table CASHITEM
  add constraint R_81503
foreign key (TRANSFERENTITYNO, TRANSFERTRANSNO) references TRANSACTIONHEADER
;

alter table EXPENSEIMPORT
  add constraint R_1470
foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
;

alter table FEELISTCASE
  add constraint R_81594
foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
;

alter table GLJOURNAL
  add constraint R_1565
foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER
;

alter table TAXHISTORY
  add constraint R_91764
foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
;

create table TRANSADJUSTMENT
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [POSTDATE] datetime,
  [TRANSVALUE] decimal(11,2),
  [TOWIPCODE] nvarchar(6),
  [TOCASEID] int
    constraint R_1265
    references CASES,
  [TOFAMILY] nvarchar(20)
    constraint R_1280
    references CASEFAMILY,
  [TOEMPLOYEENO] int
    constraint R_199
    references NAME,
  [TOACCTENTITYNO] int,
  [TOACCTNAMENO] int,
  [REASONCODE] nvarchar(2)
    constraint R_1225
    references REASON,
  [ADJENTITYNO] int not null,
  [ADJTRANSNO] int,
  [ADJSEQNO] int,
  [ADJACCTENTITYNO] int,
  [ADJACCTDEBTORNO] int,
  [STATUS] smallint,
  [APPLYTOENTITYNO] int,
  [APPLYTOTRANSNO] int,
  [APPLYTOSEQNO] int,
  [FOREIGNCURRENCY] nvarchar(3),
  [FOREIGNTRANSVALUE] decimal(11,2),
  [TOPRODUCTCODE] int
    constraint R_1268
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRANSADJUSTMENT
  primary key (ENTITYNO, TRANSNO),
  constraint R_2
  foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER,
  constraint R_1281
  foreign key (TOACCTENTITYNO, TOACCTNAMENO) references ACCOUNT,
  constraint R_142
  foreign key (ADJENTITYNO, ADJTRANSNO) references TRANSACTIONHEADER
)
;

create index XIE1TRANSADJUSTMENT
  on TRANSADJUSTMENT (ADJENTITYNO, ADJTRANSNO, ADJSEQNO, ADJACCTENTITYNO, ADJACCTDEBTORNO)
;

create index XIE2TRANSADJUSTMENT
  on TRANSADJUSTMENT (TOEMPLOYEENO)
;

create index XIE3TRANSADJUSTMENT
  on TRANSADJUSTMENT (TOCASEID)
;

create index XIE4TRANSADJUSTMENT
  on TRANSADJUSTMENT (TOPRODUCTCODE)
;

create table TRANSLATEDATA
(
  [LANGUAGE] int not null
    constraint R_1516
    references TABLECODES,
  [DATATOTRANSLATE] nvarchar(254) not null,
  [TRANSLATEDDATA] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRANSLATEDATA
  primary key (LANGUAGE, DATATOTRANSLATE)
)
;

create index XIE1TRANSLATEDATA
  on TRANSLATEDATA (LANGUAGE)
;

create table TRANSLATION
(
  [LANGUAGE_CODE] int not null
    constraint R_1351
    references LANGUAGE,
  [TRANSLATION_CODE] int not null,
  [BELONGS_TO] nvarchar(100),
  [PROGRAM_TEXT] nvarchar(100),
  [DESIRED_TEXT] nvarchar(100),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRANSLATION
  primary key (LANGUAGE_CODE, TRANSLATION_CODE)
)
;

create table TRUSTACCOUNT
(
  [ENTITYNO] int not null,
  [NAMENO] int not null,
  [BALANCE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRUSTACCOUNT
  primary key (ENTITYNO, NAMENO),
  constraint R_1201
  foreign key (ENTITYNO, NAMENO) references ACCOUNT
)
;

create table USERAPPLICATIONS
(
  [USERID] nvarchar(30) not null,
  [APPLICATIONNAME] nvarchar(20) not null
    constraint R_1306
    references APPLICATIONS,
  [DISPLAYSEQUENCE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKUSERAPPLICATIONS
  primary key nonclustered (USERID, APPLICATIONNAME)
)
;

create clustered index XIE1USERAPPLICATIONS
  on USERAPPLICATIONS (USERID, APPLICATIONNAME, DISPLAYSEQUENCE)
;

create table USERCONTROL
(
  [USERID] nvarchar(30) not null,
  [CRITERIANO] int not null,
  [ENTRYNUMBER] smallint not null,
  [INHERITED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKUSERCONTROL
  primary key (USERID, CRITERIANO, ENTRYNUMBER),
  constraint R_905
  foreign key (CRITERIANO, ENTRYNUMBER) references DETAILCONTROL
)
;

create table USERPROFILES
(
  [USERID] nvarchar(30) not null,
  [PROFILE] nvarchar(30) not null
    constraint R_1312
    references SECURITYPROFILE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKUSERFUNCTIONS
  primary key (USERID, PROFILE)
)
;

create table USERROWACCESS
(
  [ACCESSNAME] nvarchar(30) not null
    constraint R_1535
    references ROWACCESS,
  [USERID] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKUSERROWACCESS
  primary key (ACCESSNAME, USERID)
)
;

create table USERSTATUS
(
  [USERID] nvarchar(30) not null,
  [STATUSCODE] smallint not null
    constraint R_982
    references STATUS,
  [SECURITYFLAG] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKUSERSTATUS
  primary key (USERID, STATUSCODE)
)
;

create table VALIDACTDATES
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_91641
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_91643
    references PROPERTYTYPE,
  [DATEOFACT] datetime not null,
  [SEQUENCENO] smallint not null,
  [RETROSPECTIVEACTIO] nvarchar(2)
    constraint R_921
    references ACTIONS,
  [ACTEVENTNO] int
    constraint R_1342
    references EVENTS,
  [RETROEVENTNO] int
    constraint R_1343
    references EVENTS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDACTDATES
  primary key (COUNTRYCODE, PROPERTYTYPE, DATEOFACT, SEQUENCENO)
)
;

create table VALIDACTION
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1083
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1084
    references PROPERTYTYPE,
  [CASETYPE] nchar(1) not null
    constraint R_885
    references CASETYPE,
  [ACTION] nvarchar(2) not null
    constraint R_20009
    references ACTIONS,
  [ACTIONNAME] nvarchar(50),
  [ACTEVENTNO] int
    constraint R_20085
    references EVENTS,
  [RETROEVENTNO] int
    constraint R_922
    references EVENTS,
  [DISPLAYSEQUENCE] smallint,
  [ACTIONNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDACTION
  primary key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, ACTION)
)
;

create table VALIDBASIS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1076
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1075
    references PROPERTYTYPE,
  [BASIS] nvarchar(2) not null
    constraint R_819
    references APPLICATIONBASIS,
  [BASISDESCRIPTION] nvarchar(50),
  [BASISDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDBASIS
  primary key (COUNTRYCODE, PROPERTYTYPE, BASIS)
)
;

create table VALIDCATEGORY
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1077
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1078
    references PROPERTYTYPE,
  [CASETYPE] nchar(1) not null,
  [CASECATEGORY] nvarchar(2) not null,
  [CASECATEGORYDESC] nvarchar(50),
  [PROPERTYEVENTNO] int
    constraint R_20092
    references EVENTS,
  [CASECATEGORYDESC_TID] int,
  [MULTICLASSPROPERTYAPP] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDCATEGORY
  primary key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, CASECATEGORY),
  constraint R_20034
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create table VALIDCHECKLISTS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1081
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1082
    references PROPERTYTYPE,
  [CASETYPE] nchar(1) not null
    constraint R_940
    references CASETYPE,
  [CHECKLISTTYPE] smallint not null
    constraint R_941
    references CHECKLISTS,
  [CHECKLISTDESC] nvarchar(50),
  [CHECKLISTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDCHECKLISTS
  primary key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, CHECKLISTTYPE)
)
;

create table VALIDPROPERTY
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_20056
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_421
    references PROPERTYTYPE,
  [PROPERTYNAME] nvarchar(50),
  [OFFSET] int,
  [PROPERTYNAME_TID] int,
  [CYCLEOFFSET] tinyint,
  [ANNUITYTYPE] tinyint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDPROPERTY
  primary key (COUNTRYCODE, PROPERTYTYPE)
)
;

create table VALIDRELATIONSHIPS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1079
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1080
    references PROPERTYTYPE,
  [RELATIONSHIP] nvarchar(3) not null
    constraint R_945
    references CASERELATION,
  [RECIPRELATIONSHIP] nvarchar(3)
    constraint R_946
    references CASERELATION,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDRELATIONSHIPS
  primary key (COUNTRYCODE, PROPERTYTYPE, RELATIONSHIP)
)
;

create table VALIDSTATUS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1074
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_1073
    references PROPERTYTYPE,
  [CASETYPE] nchar(1) not null
    constraint R_1009
    references CASETYPE,
  [STATUSCODE] smallint not null
    constraint R_862
    references STATUS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDSTATUS
  primary key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, STATUSCODE)
)
;

create table VALIDSUBTYPE
(
  [COUNTRYCODE] nvarchar(3) not null,
  [PROPERTYTYPE] nchar(1) not null,
  [CASETYPE] nchar(1) not null,
  [CASECATEGORY] nvarchar(2) not null,
  [SUBTYPE] nvarchar(2) not null
    constraint R_428
    references SUBTYPE,
  [SUBTYPEDESC] nvarchar(50),
  [SUBTYPEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDSUBTYPE
  primary key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, CASECATEGORY, SUBTYPE),
  constraint R_427
  foreign key (COUNTRYCODE, PROPERTYTYPE, CASETYPE, CASECATEGORY) references VALIDCATEGORY
)
;

create table WIPATTRIBUTE
(
  [WIPATTRIBUTE] nvarchar(6) not null
    constraint XPKWIPATTRIBUTE
    primary key,
  [DESCRIPTION] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table WIPCATEGORY
(
  [CATEGORYCODE] nvarchar(3) not null
    constraint XPKWIPCATEGORY
    primary key,
  [DESCRIPTION] nvarchar(50),
  [CATEGORYSORT] smallint,
  [DESCRIPTION_TID] int,
  [HISTORICALEXCHRATE] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DISCOUNT
  add constraint R_38
foreign key (WIPCATEGORY) references WIPCATEGORY
;

alter table GLACCOUNTMAPPING
  add constraint R_1576
foreign key (WIPCATEGORYCODE) references WIPCATEGORY
;

create table WIPTEMPLATE
(
  [WIPCODE] nvarchar(6) not null
    constraint XPKWIPTEMPLATE
    primary key,
  [CASETYPE] nchar(1)
    /*constraint R_1395
    references CASETYPE*/,
  [COUNTRYCODE] nvarchar(3)
    /*constraint R_1396
    references COUNTRY*/,
  [PROPERTYTYPE] nchar(1)
    /*constraint R_1394
    references PROPERTYTYPE*/,
  [ACTION] nvarchar(2)
    /*constraint RI_1174
    references ACTIONS*/,
  [WIPTYPEID] nvarchar(6),
  [DESCRIPTION] nvarchar(30),
  [WIPATTRIBUTE] nvarchar(6)
    /*constraint R_1301
    references WIPATTRIBUTE*/,
  [CONSOLIDATE] decimal(1),
  [TAXCODE] nvarchar(3),
  [ENTERCREDITWIP] decimal(1),
  [REINSTATEWIP] decimal(1),
  [NARRATIVENO] smallint,
  [WIPCODESORT] smallint,
  [USEDBY] smallint,
  [TOLERANCEPERCENT] decimal(5,2),
  [TOLERANCEAMT] numeric(11,2),
  [CREDITWIPCODE] nvarchar(6)
    /*constraint R_1610
    references WIPTEMPLATE*/,
  [DESCRIPTION_TID] int,
  [RENEWALFLAG] decimal(1) default 0,
  [STATETAXCODE] nvarchar(3),
  [NOTINUSEFLAG] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ENFORCEWIPATTRFLAG] bit,
  [PREVENTWRITEDOWNFLAG] bit default 0
)
;

create index XIE1WIPTEMPLATE
  on WIPTEMPLATE (RENEWALFLAG)
;

alter table ACTIVITYREQUEST
  add constraint R_1354
foreign key (DISBWIPCODE) references WIPTEMPLATE
;

alter table ACTIVITYREQUEST
  add constraint R_1355
foreign key (SERVICEWIPCODE) references WIPTEMPLATE
;

alter table BILLRULE
  add constraint R_91817
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table DEFAULTACTIVITY
  add constraint R_5003
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table FEESCALCULATION
  add constraint R_1277
foreign key (DISBWIPCODE) references WIPTEMPLATE
;

alter table FEESCALCULATION
  add constraint R_1278
foreign key (SERVWIPCODE) references WIPTEMPLATE
;

alter table FEESCALCULATION
  add constraint R_1562
foreign key (VARWIPCODE) references WIPTEMPLATE
;

alter table FEETYPES
  add constraint R_1356
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table FEETYPES
  add constraint R_1521
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table GLACCOUNTMAPPING
  add constraint R_1574
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table QUOTATIONWIPCODE
  add constraint R_20
foreign key (WIPCODE) references WIPTEMPLATE
;

alter table TIMECOSTING
  add constraint R_1294
foreign key (ACTIVITY) references WIPTEMPLATE
;

alter table TRANSADJUSTMENT
  add constraint R_1279
foreign key (TOWIPCODE) references WIPTEMPLATE
;

create table WIPTYPE
(
  [WIPTYPEID] nvarchar(6) not null
    constraint XPKWIPTYPE
    primary key,
  [CATEGORYCODE] nvarchar(3)
    constraint RI_1216
    references WIPCATEGORY,
  [DESCRIPTION] nvarchar(50),
  [CONSOLIDATE] decimal(1),
  [WIPTYPESORT] smallint,
  [DESCRIPTION_TID] int,
  [RECORDASSOCDETAILS] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DISCOUNT
  add constraint R_58
foreign key (WIPTYPEID) references WIPTYPE
;

alter table GLACCOUNTMAPPING
  add constraint R_1575
foreign key (WIPTYPEID) references WIPTYPE
;

alter table WIPTEMPLATE
  add constraint RI_1214
foreign key (WIPTYPEID) references WIPTYPE
;

create table MARGIN
(
  [MARGINNO] int not null
    constraint XPKMARGIN
    primary key,
  [MARGINPERCENTAGE] decimal(6,2),
  [WIPCATEGORY] nvarchar(3) not null
    constraint RI_28
    references WIPCATEGORY,
  [ENTITYNO] int
    constraint R_29
    references SPECIALNAME,
  [WIPTYPE] nvarchar(6)
    constraint R_30
    references WIPTYPE,
  [CASEID] int
    constraint R_31
    references CASES,
  [INSTRUCTOR] int
    constraint R_171
    references NAME,
  [DEBTOR] int,
  [INSTRUCTORCOUNTRY] nvarchar(3)
    constraint R_34
    references COUNTRY,
  [DEBTORCOUNTRY] nvarchar(3),
  [PROPERTYTYPE] nchar(1)
    constraint R_36
    references PROPERTYTYPE,
  [ACTION] nvarchar(2)
    constraint R_37
    references ACTIONS,
  [EFFECTIVEDATE] datetime,
  [MARGINAMOUNT] decimal(10,2),
  [MARGINCURRENCY] nvarchar(3)
    constraint R_1137
    references CURRENCY,
  [DEBTORCURRENCY] nvarchar(3)
    constraint R_91561
    references CURRENCY,
  [AGENT] int
    constraint R_91565
    references NAME,
  [MARGINTYPENO] int,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91567
    references COUNTRY,
  [CASETYPE] nchar(1),
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_91778
    references SUBTYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [MARGINCAP] decimal(10,2),
  [WIPCODE] nvarchar(6)
    constraint R_81659
    references WIPTEMPLATE,
  constraint R_91777
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create index XIE1MARGIN
  on MARGIN (AGENT)
;

create index XIE2MARGIN
  on MARGIN (INSTRUCTOR)
;

create index XIE3MARGIN
  on MARGIN (DEBTOR)
;

create index XIE4MARGIN
  on MARGIN (MARGINTYPENO)
;

create index XIE5MARGIN
  on MARGIN (COUNTRYCODE)
;

create index XIE6MARGIN
  on MARGIN (CASEID)
;

alter table ACTIVITYHISTORY
  add constraint R_81511
foreign key (DISBMARGINNO) references MARGIN
;

alter table ACTIVITYHISTORY
  add constraint R_81512
foreign key (SERVMARGINNO) references MARGIN
;

alter table ACTIVITYREQUEST
  add constraint R_81508
foreign key (DISBMARGINNO) references MARGIN
;

alter table ACTIVITYREQUEST
  add constraint R_81510
foreign key (SERVMARGINNO) references MARGIN
;

create table PA10110
(
  [CaseID] char(21) not null
    constraint PKPA10110
    primary key nonclustered,
  [Case_Description] char(255) not null,
  [DEX_ROW_ID] int identity
)
;

create table SS_WIP1
(
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [NAME] varchar(254) not null,
  [FIRSTNAME] varchar(50) not null,
  [INITIALS] varchar(10) not null,
  [NAMENO] int,
  [CASEID] int,
  [IRN] varchar(20),
  [INSTRUCTOR] varchar(254) not null,
  [TRANSDATE] datetime,
  [SHORTNARRATIVE] varchar(254),
  [BALANCE] decimal(11,2),
  [FILELOCATION] varchar(10) not null,
  [WIPCODE] varchar(6),
  [INDICATOR_CURRENT] decimal(11,2),
  [INDICATOR_OVER30] decimal(11,2),
  [INDICATOR_OVER90] decimal(11,2),
  [INDICATOR_OVER180] decimal(11,2),
  [INDICATOR_OVERDUE] decimal(11,2),
  [FOREIGNCURRENCY] varchar(3),
  [EXCHRATE] decimal(8,4),
  [PROPERTYTYPE] char(1),
  constraint PK_SS_WIP
  primary key (TRANSNO, WIPSEQNO)
)
;

create table WIP_RECAL2
(
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null
)
;

create table NARRATIVERULE
(
  [NARRATIVERULENO] int not null
    constraint XPKNARRATIVERULE
    primary key,
  [NARRATIVENO] smallint not null,
  [WIPCODE] nvarchar(6) not null
    constraint R_48
    references WIPTEMPLATE,
  [EMPLOYEENO] int
    constraint R_193
    references NAME,
  [CASETYPE] nchar(1)
    constraint R_43
    references CASETYPE,
  [PROPERTYTYPE] nchar(1)
    constraint R_44
    references PROPERTYTYPE,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_46
    references SUBTYPE,
  [TYPEOFMARK] int
    constraint R_47
    references TABLECODES,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91419
    references COUNTRY,
  [LOCALCOUNTRYFLAG] bit,
  [FOREIGNCOUNTRYFLAG] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [DEBTORNO] int
    constraint R_81611
    references IPNAME,
  constraint R_45
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create unique index XAK1NARRATIVERULE
  on NARRATIVERULE (WIPCODE, NARRATIVENO, EMPLOYEENO, CASETYPE, COUNTRYCODE, LOCALCOUNTRYFLAG, FOREIGNCOUNTRYFLAG, PROPERTYTYPE, CASECATEGORY, SUBTYPE, TYPEOFMARK)
;

create index XIE1NARRATIVERULE
  on NARRATIVERULE (TYPEOFMARK)
;

create table OPENITEMCASE
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [CASEID] int not null
    constraint R_51
    references CASES,
  [STATUS] smallint
    constraint R_52
    references TRANSACTION_STATUS,
  [LOCALVALUE] decimal(11,2),
  [FOREIGNVALUE] decimal(11,2),
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOPENITEMCASE
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, CASEID)
)
;

create index XIE1OPENITEMCASE
  on OPENITEMCASE (CASEID)
;

create table DEBTORHISTORYCASE
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [HISTORYLINENO] smallint not null,
  [CASEID] int not null
    constraint R_54
    references CASES,
  [LOCALVALUE] decimal(11,2),
  [FOREIGNTRANVALUE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDEBTORHISTORYCASE
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, HISTORYLINENO, CASEID)
)
;

create index XIE1DEBTORHISTORYCASE
  on DEBTORHISTORYCASE (CASEID)
;

create table BILLEDCREDIT
(
  [DRITEMENTITYNO] int not null,
  [DRITEMTRANSNO] int not null,
  [DRACCTENTITYNO] int not null,
  [DRACCTDEBTORNO] int not null,
  [CRITEMENTITYNO] int not null,
  [CRITEMTRANSNO] int not null,
  [CRACCTENTITYNO] int not null,
  [CRACCTDEBTORNO] int not null,
  [CRCASEID] int
    constraint R_57
    references CASES,
  [LOCALSELECTED] decimal(11,2),
  [FOREIGNSELECTED] decimal(11,2),
  [FORCEDPAYOUT] decimal(1),
  [CREDITID] int identity
    constraint XPKBILLEDCREDIT
    primary key,
  [SELECTEDRENEWAL] decimal(11,2) default 0 not null,
  [SELECTEDNONRENEWAL] decimal(11,2) default 0 not null,
  [CREXCHVARIANCE] decimal(11,2),
  [CRFORCEDPAYOUT] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1BILLEDCREDIT
  on BILLEDCREDIT (DRITEMENTITYNO, DRITEMTRANSNO, DRACCTDEBTORNO, DRACCTENTITYNO, CRITEMENTITYNO, CRITEMTRANSNO, CRACCTENTITYNO, CRACCTDEBTORNO, CRCASEID)
;

create index XIE1BILLEDCREDIT
  on BILLEDCREDIT (CRCASEID)
;

create table WIP_RECAL1
(
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [Current] numeric(11,2),
  [Over30] numeric(11,2),
  [Over90] numeric(11,2),
  [Over180] numeric(11,2),
  [OverDue] numeric(11,2)
)
;

create table CPARECEIVE
(
  [CASEID] int,
  [SYSTEMID] nvarchar(3),
  [BATCHNO] int not null,
  [BATCHDATE] datetime,
  [PROPERTYTYPE] nchar(1),
  [CASECODE] nvarchar(15),
  [TRANSACTIONCODE] smallint,
  [ALTOFFICECODE] nvarchar(3),
  [FILENUMBER] nvarchar(15),
  [CLIENTSREFERENCE] nvarchar(35),
  [CPACOUNTRYCODE] nvarchar(2),
  [RENEWALTYPECODE] nvarchar(2),
  [MARK] nvarchar(100),
  [ENTITYSIZE] nchar(1),
  [PRIORITYDATE] datetime,
  [PARENTDATE] datetime,
  [NEXTTAXDATE] datetime,
  [NEXTDECOFUSEDATE] datetime,
  [PCTFILINGDATE] datetime,
  [ASSOCDESIGNDATE] datetime,
  [NEXTAFFIDAVITDATE] datetime,
  [APPLICATIONDATE] datetime,
  [ACCEPTANCEDATE] datetime,
  [PUBLICATIONDATE] datetime,
  [REGISTRATIONDATE] datetime,
  [RENEWALDATE] datetime,
  [NOMINALWORKINGDATE] datetime,
  [EXPIRYDATE] datetime,
  [CPASTARTPAYDATE] datetime,
  [CPASTOPPAYDATE] datetime,
  [STOPPAYINGREASON] nchar(1),
  [PRIORITYNO] nvarchar(30),
  [PARENTNO] nvarchar(30),
  [PCTFILINGNO] nvarchar(30),
  [ASSOCDESIGNNO] nvarchar(30),
  [APPLICATIONNO] nvarchar(30),
  [ACCEPTANCENO] nvarchar(30),
  [PUBLICATIONNO] nvarchar(30),
  [REGISTRATIONNO] nvarchar(30),
  [INTLCLASSES] nvarchar(150),
  [LOCALCLASSES] nvarchar(150),
  [NUMBEROFYEARS] smallint,
  [NUMBEROFCLAIMS] smallint,
  [NUMBEROFDESIGNS] smallint,
  [NUMBEROFCLASSES] smallint,
  [NUMBEROFSTATES] smallint,
  [DESIGNATEDSTATES] nvarchar(200),
  [OWNERNAME] nvarchar(100),
  [OWNERNAMECODE] nvarchar(35),
  [OWNADDRESSLINE1] nvarchar(50),
  [OWNADDRESSLINE2] nvarchar(50),
  [OWNADDRESSLINE3] nvarchar(50),
  [OWNADDRESSLINE4] nvarchar(50),
  [OWNADDRESSCOUNTRY] nvarchar(50),
  [OWNADDRESSPOSTCODE] nvarchar(16),
  [CLIENTCODE] nvarchar(15),
  [CPACLIENTNO] int,
  [CLIENTNAME] nvarchar(100),
  [CLIENTATTENTION] nvarchar(50),
  [CLTADDRESSLINE1] nvarchar(50),
  [CLTADDRESSLINE2] nvarchar(50),
  [CLTADDRESSLINE3] nvarchar(50),
  [CLTADDRESSLINE4] nvarchar(50),
  [CLTADDRESSCOUNTRY] nvarchar(50),
  [CLTADDRESSPOSTCODE] nvarchar(16),
  [CLIENTTELEPHONE] nvarchar(20),
  [CLIENTFAX] nvarchar(20),
  [CLIENTEMAIL] nvarchar(100),
  [DIVISIONCODE] nvarchar(6),
  [DIVISIONNAME] nvarchar(100),
  [DIVISIONATTENTION] nvarchar(50),
  [DIVADDRESSLINE1] nvarchar(50),
  [DIVADDRESSLINE2] nvarchar(50),
  [DIVADDRESSLINE3] nvarchar(50),
  [DIVADDRESSLINE4] nvarchar(50),
  [DIVADDRESSCOUNTRY] nvarchar(50),
  [DIVADDRESSPOSTCODE] nvarchar(16),
  [FOREIGNAGENTCODE] nvarchar(8),
  [FOREIGNAGENTNAME] nvarchar(100),
  [ATTORNEYCODE] nvarchar(8),
  [ATTORNEYNAME] nvarchar(100),
  [INVOICEECODE] nvarchar(15),
  [CPAINVOICEENO] int,
  [INVOICEENAME] nvarchar(100),
  [INVOICEEATTENTION] nvarchar(50),
  [INVADDRESSLINE1] nvarchar(50),
  [INVADDRESSLINE2] nvarchar(50),
  [INVADDRESSLINE3] nvarchar(50),
  [INVADDRESSLINE4] nvarchar(50),
  [INVADDRESSCOUNTRY] nvarchar(50),
  [INVADDRESSPOSTCODE] nvarchar(16),
  [INVOICEETELEPHONE] nvarchar(20),
  [INVOICEEFAX] nvarchar(20),
  [INVOICEEEMAIL] nvarchar(100),
  [NARRATIVE] nvarchar(50),
  [IPRURN] nvarchar(7),
  [ACKNOWLEDGED] decimal(1),
  [ROWID] int identity
    constraint XPKCPARECEIVE
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPARECEIVE
  on CPARECEIVE (BATCHNO)
;

create index XIE2CPARECEIVE
  on CPARECEIVE (CASECODE)
;

create index XIE3CPARECEIVE
  on CPARECEIVE (CASEID)
;

create index XIE4CPARECEIVE
  on CPARECEIVE (BATCHNO, CASECODE, CASEID)
;

create index XIE5CPARECEIVE
  on CPARECEIVE (SYSTEMID, BATCHNO, CASECODE, CLIENTCODE, DIVISIONCODE, INVOICEECODE)
;

create table CPASEND
(
  [CASEID] int,
  [SYSTEMID] nvarchar(3),
  [BATCHNO] int not null,
  [BATCHDATE] datetime,
  [PROPERTYTYPE] nchar(1),
  [CASECODE] nvarchar(15),
  [TRANSACTIONCODE] smallint,
  [ALTOFFICECODE] nvarchar(3),
  [FILENUMBER] nvarchar(15),
  [CLIENTSREFERENCE] nvarchar(35),
  [CPACOUNTRYCODE] nvarchar(2),
  [RENEWALTYPECODE] nvarchar(2),
  [MARK] nvarchar(100),
  [ENTITYSIZE] nchar(1),
  [PRIORITYDATE] datetime,
  [PARENTDATE] datetime,
  [NEXTTAXDATE] datetime,
  [NEXTDECOFUSEDATE] datetime,
  [PCTFILINGDATE] datetime,
  [ASSOCDESIGNDATE] datetime,
  [NEXTAFFIDAVITDATE] datetime,
  [APPLICATIONDATE] datetime,
  [ACCEPTANCEDATE] datetime,
  [PUBLICATIONDATE] datetime,
  [REGISTRATIONDATE] datetime,
  [RENEWALDATE] datetime,
  [NOMINALWORKINGDATE] datetime,
  [EXPIRYDATE] datetime,
  [CPASTARTPAYDATE] datetime,
  [CPASTOPPAYDATE] datetime,
  [STOPPAYINGREASON] nchar(1),
  [PRIORITYNO] nvarchar(30),
  [PARENTNO] nvarchar(30),
  [PCTFILINGNO] nvarchar(30),
  [ASSOCDESIGNNO] nvarchar(30),
  [APPLICATIONNO] nvarchar(30),
  [ACCEPTANCENO] nvarchar(30),
  [PUBLICATIONNO] nvarchar(30),
  [REGISTRATIONNO] nvarchar(30),
  [INTLCLASSES] nvarchar(150),
  [LOCALCLASSES] nvarchar(150),
  [NUMBEROFYEARS] smallint,
  [NUMBEROFCLAIMS] smallint,
  [NUMBEROFDESIGNS] smallint,
  [NUMBEROFCLASSES] smallint,
  [NUMBEROFSTATES] smallint,
  [DESIGNATEDSTATES] nvarchar(200),
  [OWNERNAME] nvarchar(100),
  [OWNERNAMECODE] nvarchar(35),
  [OWNADDRESSLINE1] nvarchar(50),
  [OWNADDRESSLINE2] nvarchar(50),
  [OWNADDRESSLINE3] nvarchar(50),
  [OWNADDRESSLINE4] nvarchar(50),
  [OWNADDRESSCOUNTRY] nvarchar(50),
  [OWNADDRESSPOSTCODE] nvarchar(16),
  [CLIENTCODE] nvarchar(15),
  [CPACLIENTNO] int,
  [CLIENTNAME] nvarchar(100),
  [CLIENTATTENTION] nvarchar(50),
  [CLTADDRESSLINE1] nvarchar(50),
  [CLTADDRESSLINE2] nvarchar(50),
  [CLTADDRESSLINE3] nvarchar(50),
  [CLTADDRESSLINE4] nvarchar(50),
  [CLTADDRESSCOUNTRY] nvarchar(50),
  [CLTADDRESSPOSTCODE] nvarchar(16),
  [CLIENTTELEPHONE] nvarchar(20),
  [CLIENTFAX] nvarchar(20),
  [CLIENTEMAIL] nvarchar(100),
  [DIVISIONCODE] nvarchar(6),
  [DIVISIONNAME] nvarchar(100),
  [DIVISIONATTENTION] nvarchar(50),
  [DIVADDRESSLINE1] nvarchar(50),
  [DIVADDRESSLINE2] nvarchar(50),
  [DIVADDRESSLINE3] nvarchar(50),
  [DIVADDRESSLINE4] nvarchar(50),
  [DIVADDRESSCOUNTRY] nvarchar(50),
  [DIVADDRESSPOSTCODE] nvarchar(16),
  [FOREIGNAGENTCODE] nvarchar(8),
  [FOREIGNAGENTNAME] nvarchar(100),
  [ATTORNEYCODE] nvarchar(8),
  [ATTORNEYNAME] nvarchar(100),
  [INVOICEECODE] nvarchar(15),
  [CPAINVOICEENO] int,
  [INVOICEENAME] nvarchar(100),
  [INVOICEEATTENTION] nvarchar(50),
  [INVADDRESSLINE1] nvarchar(50),
  [INVADDRESSLINE2] nvarchar(50),
  [INVADDRESSLINE3] nvarchar(50),
  [INVADDRESSLINE4] nvarchar(50),
  [INVADDRESSCOUNTRY] nvarchar(50),
  [INVADDRESSPOSTCODE] nvarchar(16),
  [INVOICEETELEPHONE] nvarchar(20),
  [INVOICEEFAX] nvarchar(20),
  [INVOICEEEMAIL] nvarchar(100),
  [NARRATIVE] nvarchar(50),
  [IPRURN] nvarchar(7),
  [ACKNOWLEDGED] decimal(1),
  [ROWID] int identity
    constraint XPKCPASEND
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPASEND
  on CPASEND (BATCHNO)
;

create index XIE2CPASEND
  on CPASEND (CASECODE)
;

create index XIE3CPASEND
  on CPASEND (CASEID)
;

create index XIE4CPASEND
  on CPASEND (BATCHNO, CASECODE, CASEID)
;

create index XIE5CPASEND
  on CPASEND (SYSTEMID, BATCHNO, CASECODE, CLIENTCODE, DIVISIONCODE, INVOICEECODE)
;

create table CPAPORTFOLIO
(
  [PORTFOLIONO] int not null
    constraint XPKCPAPORTFOLIO
    primary key,
  [DATEOFPORTFOLIOLST] datetime,
  [CLIENTNO] int,
  [CLIENTCURRENCY] nvarchar(3),
  [IPCOUNTRYCODE] nvarchar(2),
  [TYPECODE] nvarchar(2),
  [TYPENAME] nvarchar(16),
  [IPRENEWALNO] nvarchar(15),
  [IPRURN] nvarchar(7),
  [PARENTNO] nvarchar(15),
  [PATENTPCTNO] nvarchar(15),
  [FIRSTPRIORITYNO] nvarchar(15),
  [APPLICATIONNO] nvarchar(15),
  [PUBLICATIONNO] nvarchar(15),
  [REGISTRATIONNO] nvarchar(15),
  [NEXTRENEWALDATE] datetime,
  [BASEDATE] datetime,
  [EXPIRYDATE] datetime,
  [PARENTDATE] datetime,
  [PCTFILINGDATE] datetime,
  [FIRSTPRIORITYDATE] datetime,
  [APPLICATIONDATE] datetime,
  [PUBLICATIONDATE] datetime,
  [GRANTDATE] datetime,
  [PROPRIETOR] nvarchar(100),
  [CLIENTREF] nvarchar(35),
  [CLIENTCASECODE] nvarchar(15),
  [DIVISIONCODE] nvarchar(6),
  [DIVISIONNAME] nvarchar(35),
  [ANNUITY] int,
  [TRADEMARKREF] nvarchar(15),
  [AGENTCASECODE] nvarchar(15),
  [RESPONSIBLEPARTY] nvarchar(1),
  [LASTAMENDDATE] datetime,
  [STATUSINDICATOR] nchar(1),
  [CASEID] int,
  [PROPOSEDIRN] nvarchar(15),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPAPORTFOLIO
  on CPAPORTFOLIO (AGENTCASECODE)
;

create index XIE2CPAPORTFOLIO
  on CPAPORTFOLIO (DATEOFPORTFOLIOLST)
;

create index XIE3CPAPORTFOLIO
  on CPAPORTFOLIO (AGENTCASECODE, DATEOFPORTFOLIOLST)
;

create index XIE4CPAPORTFOLIO
  on CPAPORTFOLIO (CASEID, PROPOSEDIRN)
;

create table EVENTUPDATEPROFILE
(
  [PROFILEREFNO] int not null
    constraint XPKEVENTUPDATEPROFILE
    primary key,
  [DESCRIPTION] nvarchar(50) not null,
  [EVENT1NO] int not null
    constraint R_220
    references EVENTS,
  [EVENT1TEXT] nvarchar(15),
  [EVENT2NO] int
    constraint R_221
    references EVENTS,
  [EVENT2TEXT] nvarchar(15),
  [NAMETYPE] nvarchar(3)
    constraint R_222
    references NAMETYPE,
  [DESCRIPTION_TID] int,
  [EVENT1TEXT_TID] int,
  [EVENT2TEXT_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table EVENTS
  add constraint R_1176
foreign key (PROFILEREFNO) references EVENTUPDATEPROFILE
;

create table CPACOMPARE
(
  [PROPERTYTYPEKEY] nchar(1) not null
    constraint XPKCPACOMPARE
    primary key
    constraint RI_904
    references PROPERTYTYPE,
  [PROPERTYTYPE] decimal(1),
  [ALTOFFICECODE] decimal(1),
  [FILENUMBER] decimal(1),
  [CLIENTSREFERENCE] decimal(1),
  [CPACOUNTRYCODE] decimal(1),
  [RENEWALTYPECODE] decimal(1),
  [MARK] decimal(1),
  [ENTITYSIZE] decimal(1),
  [PRIORITYDATE] decimal(1),
  [PARENTDATE] decimal(1),
  [NEXTTAXDATE] decimal(1),
  [NEXTDECOFUSEDATE] decimal(1),
  [PCTFILINGDATE] decimal(1),
  [ASSOCDESIGNDATE] decimal(1),
  [NEXTAFFIDAVITDATE] decimal(1),
  [APPLICATIONDATE] decimal(1),
  [ACCEPTANCEDATE] decimal(1),
  [PUBLICATIONDATE] decimal(1),
  [REGISTRATIONDATE] decimal(1),
  [RENEWALDATE] decimal(1),
  [NOMINALWORKINGDATE] decimal(1),
  [EXPIRYDATE] decimal(1),
  [CPASTARTPAYDATE] decimal(1),
  [CPASTOPPAYDATE] decimal(1),
  [STOPPAYINGREASON] decimal(1),
  [PRIORITYNO] decimal(1),
  [PARENTNO] decimal(1),
  [PCTFILINGNO] decimal(1),
  [ASSOCDESIGNNO] decimal(1),
  [APPLICATIONNO] decimal(1),
  [ACCEPTANCENO] decimal(1),
  [PUBLICATIONNO] decimal(1),
  [REGISTRATIONNO] decimal(1),
  [INTLCLASSES] decimal(1),
  [LOCALCLASSES] decimal(1),
  [NUMBEROFYEARS] decimal(1),
  [NUMBEROFCLAIMS] decimal(1),
  [NUMBEROFDESIGNS] decimal(1),
  [NUMBEROFCLASSES] decimal(1),
  [NUMBEROFSTATES] decimal(1),
  [DESIGNATEDSTATES] decimal(1),
  [OWNERNAME] decimal(1),
  [OWNERNAMECODE] decimal(1),
  [OWNADDRESSLINE1] decimal(1),
  [OWNADDRESSLINE2] decimal(1),
  [OWNADDRESSLINE3] decimal(1),
  [OWNADDRESSLINE4] decimal(1),
  [OWNADDRESSCOUNTRY] decimal(1),
  [OWNADDRESSPOSTCODE] decimal(1),
  [CLIENTCODE] decimal(1),
  [CPACLIENTNO] decimal(1),
  [CLIENTNAME] decimal(1),
  [CLIENTATTENTION] decimal(1),
  [CLTADDRESSLINE1] decimal(1),
  [CLTADDRESSLINE2] decimal(1),
  [CLTADDRESSLINE3] decimal(1),
  [CLTADDRESSLINE4] decimal(1),
  [CLTADDRESSCOUNTRY] decimal(1),
  [CLTADDRESSPOSTCODE] decimal(1),
  [CLIENTTELEPHONE] decimal(1),
  [CLIENTFAX] decimal(1),
  [CLIENTEMAIL] decimal(1),
  [DIVISIONCODE] decimal(1),
  [DIVISIONNAME] decimal(1),
  [DIVISIONATTENTION] decimal(1),
  [DIVADDRESSLINE1] decimal(1),
  [DIVADDRESSLINE2] decimal(1),
  [DIVADDRESSLINE3] decimal(1),
  [DIVADDRESSLINE4] decimal(1),
  [DIVADDRESSCOUNTRY] decimal(1),
  [DIVADDRESSPOSTCODE] decimal(1),
  [FOREIGNAGENTCODE] decimal(1),
  [FOREIGNAGENTNAME] decimal(1),
  [ATTORNEYCODE] decimal(1),
  [ATTORNEYNAME] decimal(1),
  [INVOICEECODE] decimal(1),
  [CPAINVOICEENO] decimal(1),
  [INVOICEENAME] decimal(1),
  [INVOICEEATTENTION] decimal(1),
  [INVADDRESSLINE1] decimal(1),
  [INVADDRESSLINE2] decimal(1),
  [INVADDRESSLINE3] decimal(1),
  [INVADDRESSLINE4] decimal(1),
  [INVADDRESSCOUNTRY] decimal(1),
  [INVADDRESSPOSTCODE] decimal(1),
  [INVOICEETELEPHONE] decimal(1),
  [INVOICEEFAX] decimal(1),
  [INVOICEEEMAIL] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table VALIDATENUMBERS
(
  [VALIDATIONID] int not null
    constraint XPKVALIDATENUMBERS
    primary key,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_229
    references COUNTRY,
  [PROPERTYTYPE] nchar(1) not null
    constraint R_230
    references PROPERTYTYPE,
  [NUMBERTYPE] nchar(1) not null
    constraint R_231
    references NUMBERTYPES,
  [VALIDFROM] datetime,
  [PATTERN] nvarchar(254) not null,
  [WARNINGFLAG] decimal(1) not null,
  [ERRORMESSAGE] nvarchar(254) not null,
  [VALIDATINGSPID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ERRORMESSAGE_TID] int,
  [CASETYPE] nchar(1),
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_81614
    references SUBTYPE,
  constraint R_81613
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create unique index XAK1VALIDATENUMBERS
  on VALIDATENUMBERS (COUNTRYCODE, PROPERTYTYPE, NUMBERTYPE, VALIDFROM)
;

create table CPAEVENT
(
  [CEFNO] int not null
    constraint XPKCPAEVENT
    primary key,
  [BATCHNO] int not null,
  [CASEID] int,
  [EVENTCODE] nvarchar(2),
  [EVENTDATE] datetime,
  [IPRURN] nvarchar(7),
  [PROPRIETOR] nvarchar(35),
  [CPAACCOUNTNO] nvarchar(7),
  [CLIENTCASECODE] nvarchar(15),
  [AGENTCASECODE] nvarchar(15),
  [FILENUMBER] nvarchar(15),
  [CLIENTREF] nvarchar(35),
  [CLIENTKEY] nvarchar(15),
  [COUNTRYCODE] nvarchar(2),
  [TYPECODE] nvarchar(2),
  [TYPENAME] nvarchar(16),
  [REGISTRATIONNO] nvarchar(15),
  [DIVISIONCODE] nvarchar(6),
  [LINKEDCASEFLAG] nchar(1),
  [ANNUITY] int,
  [RENEWALEVENTDATE] datetime,
  [NEXTRENEWALDATE] datetime,
  [EXPIRYDATE] datetime,
  [EVENTAMOUNT] decimal(12,2),
  [CURRENCY] nvarchar(3),
  [INVOICENO] nvarchar(7),
  [INVOICEITEMNO] nvarchar(4),
  [CASELAPSEDATE] datetime,
  [EVENTNARRATIVE] nvarchar(200),
  [CASEEVENTNO] int,
  [CASEEVENTCYCLE] smallint,
  [CASEEVENTDATE] datetime,
  [FINEAMOUNT] decimal(12,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FILESEQNUMBER] nvarchar(5) default 0 not null
)
;

create index XIE1CPAEVENT
  on CPAEVENT (AGENTCASECODE)
;

create index XIE2CPAEVENT
  on CPAEVENT (EVENTCODE)
;

create index XIE3CPAEVENT
  on CPAEVENT (BATCHNO)
;

create index XIE4CPAEVENT
  on CPAEVENT (FILESEQNUMBER)
;

create table FEESCALCALT
(
  [CRITERIANO] int not null,
  [UNIQUEID] smallint not null,
  [COMPONENTTYPE] smallint not null,
  [SUPPLEMENTNO] smallint not null,
  [PROCEDURENAME] nvarchar(20) not null,
  [DESCRIPTION] nvarchar(20),
  [COUNTRYCODE] nvarchar(3)
    constraint R_237
    references COUNTRY,
  [SUPPNUMERICVALUE] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFEESCALCALT
  primary key (CRITERIANO, UNIQUEID, COMPONENTTYPE, SUPPLEMENTNO, PROCEDURENAME),
  constraint R_236
  foreign key (CRITERIANO, UNIQUEID) references FEESCALCULATION
)
;

create table CPAEVENTCODE
(
  [CPAEVENTCODE] nvarchar(2) not null
    constraint XPKCPAEVENTCODE
    primary key,
  [DESCRIPTION] nvarchar(80),
  [CASEEVENTNO] int
    constraint R_238
    references EVENTS,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPAEVENTCODE
  on CPAEVENTCODE (CPAEVENTCODE, CASEEVENTNO)
;

create table CPANARRATIVE
(
  [CPANARRATIVE] nvarchar(50) not null
    constraint XPKCPANARRATIVE
    primary key,
  [CASEEVENTNO] int
    constraint R_243
    references EVENTS,
  [EXCLUDEFLAG] decimal(1) not null,
  [CPANARRATIVE_TID] int,
  [NARRATIVEDESC] nvarchar(1500),
  [NARRATIVEDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPANARRATIVE
  on CPANARRATIVE (EXCLUDEFLAG, CPANARRATIVE, CASEEVENTNO)
;

create table USERIDENTITY
(
  [IDENTITYID] int identity
    constraint XPKUSERIDENTITY
    primary key,
  [LOGINID] nvarchar(50) not null,
  [PASSWORD] binary(16),
  [NAMENO] int not null
    constraint R_64
    references NAME,
  [ISEXTERNALUSER] bit default 0 not null,
  [ISADMINISTRATOR] bit default 0 not null,
  [ACCOUNTID] int,
  [HASTEMPPASSWORD] bit default 0,
  [ISVALIDINPROSTART] bit default 0 not null,
  [ISVALIDWORKBENCH] bit default 0 not null,
  [DEFAULTPORTALID] int,
  [INVALIDLOGINS] int default 0 not null,
  [ISLOCKED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROFILEID] int
)
;

create unique index XAK1USERIDENTITY
  on USERIDENTITY (LOGINID)
;

create table IDENTITYNAMES
(
  [IDENTITYID] int not null
    constraint R_67
    references USERIDENTITY,
  [NAMENO] int not null
    constraint R_68
    references NAME,
  [ADMINISTRATOR] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIDENTITYNAMES
  primary key (IDENTITYID, NAMENO)
)
;

create table IDENTITYROLES
(
  [IDENTITYID] int not null
    constraint R_70
    references USERIDENTITY,
  [ROLEID] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIDENTITYROLES
  primary key (IDENTITYID, ROLEID)
)
;

create table IDENTITYTASKS
(
  [IDENTITYID] int not null
    constraint R_71
    references USERIDENTITY,
  [TASKID] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIDENTITYTASKS
  primary key (IDENTITYID, TASKID)
)
;

create table GROUPEDSETTINGS
(
  [GROUPID] smallint not null,
  [SETTINGID] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGROUPEDSETTINGS
  primary key (GROUPID, SETTINGID)
)
;

create table ROLETASKS
(
  [ROLEID] int not null,
  [TASKID] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKROLETASKS
  primary key (ROLEID, TASKID)
)
;

create table REPORTJOBS
(
  [JOBID] int identity
    constraint XPKREPORTJOBS
    primary key,
  [JOBNAME] nvarchar(100) not null,
  [REPORTID] int not null,
  [NOTES] ntext,
  [OUTPUTMETHOD] nvarchar(1) not null,
  [OUTPUTOPTIONS] ntext,
  [PARAMETERS] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TRANSLATEDITEMS
(
  [TID] int identity
    constraint XPKTRANSLATEDITEMS
    primary key,
  [TRANSLATIONSOURCEID] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TRANSLATIONSOURCE
(
  [TRANSLATIONSOURCEID] int identity
    constraint XPKTRANSLATIONSOURCE
    primary key,
  [TABLENAME] nvarchar(30) not null,
  [SHORTCOLUMN] nvarchar(30),
  [LONGCOLUMN] nvarchar(30),
  [TIDCOLUMN] nvarchar(30) not null,
  [INUSE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table TRANSLATEDITEMS
  add constraint R_84
foreign key (TRANSLATIONSOURCEID) references TRANSLATIONSOURCE
;

create table PORTALTAB
(
  [TABID] int identity
    constraint XPKPORTALTAB
    primary key,
  [TABNAME] nvarchar(50) not null,
  [IDENTITYID] int
    constraint R_1153
    references USERIDENTITY,
  [TABNAME_TID] int,
  [TABSEQUENCE] tinyint default 1 not null,
  [PORTALID] int,
  [CSSCLASSNAME] nvarchar(50),
  [CANRENAME] bit default 1 not null,
  [CANDELETE] bit default 1 not null,
  [PARENTTABID] int
    constraint R_1409
    references PORTALTAB,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1PORTALTAB
  on PORTALTAB (IDENTITYID, PORTALID, TABSEQUENCE)
;

create table PORTALTABCONFIGURATION
(
  [CONFIGURATIONID] int identity
    constraint XPKPORTALTABCONFIGURATION
    primary key,
  [IDENTITYID] int
    constraint R_206
    references USERIDENTITY,
  [TABID] int not null
    constraint R_207
    references PORTALTAB,
  [TABSEQUENCE] int not null,
  [PORTALID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table DATAVIEW
(
  [VIEWID] int identity
    constraint XPKDATAVIEW
    primary key,
  [CATEGORY] int not null,
  [TITLE] nvarchar(50) not null,
  [DESCRIPTION] ntext,
  [IDENTITYID] int
    constraint R_208
    references USERIDENTITY,
  [STYLE] int not null,
  [SORTID] int,
  [FILTERID] int,
  [FORMATID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table PORTALMENU
(
  [MENUID] int identity
    constraint XPKPORTALMENU
    primary key,
  [ANONYMOUSUSER] bit not null,
  [HEADER] bit not null,
  [PARENTID] int
    constraint R_210
    references PORTALMENU,
  [LABEL] nvarchar(256),
  [SEQUENCE] int not null,
  [IDENTITYID] int
    constraint R_211
    references USERIDENTITY,
  [OVERRIDDEN] bit not null,
  [TASKID] int,
  [HREF] nvarchar(512),
  [VIEWID] int
    constraint R_212
    references DATAVIEW,
  [LABEL_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table MODULEDEFINITION
(
  [MODULEDEFID] int identity
    constraint XPKMODULEDEFINITION
    primary key,
  [NAME] nvarchar(128) not null,
  [DESKTOPSRC] nvarchar(256),
  [MOBILESRC] nvarchar(256),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table MODULE
(
  [MODULEID] int identity
    constraint XPKMODULE
    primary key,
  [MODULEDEFID] int not null
    constraint R_213
    references MODULEDEFINITION,
  [TITLE] nvarchar(256),
  [CACHETIME] int not null,
  [TITLE_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table MODULECONFIGURATION
(
  [CONFIGURATIONID] int identity
    constraint XPKMODULECONFIGURATION
    primary key,
  [IDENTITYID] int
    constraint R_214
    references USERIDENTITY,
  [TABID] int not null
    constraint R_215
    references PORTALTAB,
  [MODULEID] int not null
    constraint R_216
    references MODULE,
  [MODULESEQUENCE] int not null,
  [PANELLOCATION] nvarchar(50) not null,
  [PORTALID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table HTMLTEXT
(
  [HTMLTEXT] nvarchar(4000),
  [PORTALMODULEID] int not null
    constraint R_217
    references MODULE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table SEARCHES
(
  [SEARCHID] int identity
    constraint XPKSEARCHES
    primary key,
  [IDENTITYID] int not null
    constraint R_218
    references USERIDENTITY,
  [USEASDEFAULT] bit,
  [DESCRIPTION] nvarchar(256) not null,
  [CRITERIA] ntext not null,
  [COLUMNS] ntext,
  [CATEGORY] nvarchar(50),
  [ORIGIN] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUICKINDEX
(
  [INDEXID] int identity
    constraint XPKQUICKINDEX
    primary key,
  [INDEXFORTABLE] nvarchar(30) not null,
  [ENTRYDATATYPE] nchar(1) not null,
  [AUTOPOPULATEFLAG] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUICKINDEXRULE
(
  [RULEID] int identity
    constraint XPKQUICKINDEXRULE
    primary key,
  [INDEXID] int not null
    constraint R_224
    references QUICKINDEX,
  [IDENTITYID] int
    constraint R_225
    references USERIDENTITY,
  [INDEXNAME] nvarchar(50) not null,
  [MAXENTRIES] tinyint,
  [INDEXNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUICKINDEXRULE
  on QUICKINDEXRULE (INDEXID, IDENTITYID)
;

create table IDENTITYINDEX
(
  [ENTRYID] int identity
    constraint XPKIDENTITYINDEX
    primary key,
  [INDEXID] int not null
    constraint R_227
    references QUICKINDEX,
  [IDENTITYID] int not null
    constraint R_228
    references USERIDENTITY,
  [COLINTEGER] int,
  [COLCHARACTER] nvarchar(100),
  [LASTACCESSED] datetime not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1IDENTITYINDEX
  on IDENTITYINDEX (INDEXID, IDENTITYID, COLINTEGER, COLCHARACTER)
;

create table IDENTITYROWACCESS
(
  [ACCESSNAME] nvarchar(30) not null
    constraint R_239
    references ROWACCESS,
  [IDENTITYID] int not null
    constraint R_240
    references USERIDENTITY,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIDENTITYROWACCESS
  primary key (ACCESSNAME, IDENTITYID)
)
;

create table CREDITORITEM
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTCREDITORNO] int not null,
  [DOCUMENTREF] nvarchar(20) not null,
  [ITEMDATE] datetime not null,
  [ITEMDUEDATE] datetime,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [CLOSEPOSTDATE] datetime,
  [CLOSEPOSTPERIOD] int,
  [ITEMTYPE] int
    constraint R_910
    references TABLECODES,
  [CURRENCY] nvarchar(3)
    constraint Ri_911
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [LOCALPRETAXVALUE] decimal(11,2),
  [LOCALVALUE] decimal(11,2),
  [LOCALTAXAMOUNT] decimal(11,2),
  [FOREIGNVALUE] decimal(11,2),
  [FOREIGNTAXAMT] decimal(11,2),
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [STATUS] smallint
    constraint R_912
    references TRANSACTION_STATUS,
  [DESCRIPTION] nvarchar(254),
  [LONGDESCRIPTION] ntext,
  [RESTRICTIONID] int,
  [RESTNREASONCODE] nvarchar(2)
    constraint R_1101
    references REASON,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROTOCOLNO] nvarchar(20),
  [PROTOCOLDATE] datetime,
  constraint XPKCREDITORITEM
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO),
  constraint RI_905
  foreign key (ITEMENTITYNO, ITEMTRANSNO) references TRANSACTIONHEADER,
  constraint R_907
  foreign key (ACCTENTITYNO, ACCTCREDITORNO) references ACCOUNT
)
;

create index XIE1CREDITORITEM
  on CREDITORITEM (ACCTCREDITORNO)
;

create index XIE2CREDITORITEM
  on CREDITORITEM (ACCTENTITYNO, ACCTCREDITORNO, CLOSEPOSTPERIOD)
;

create index XIE3CREDITORITEM
  on CREDITORITEM (ITEMENTITYNO, CLOSEPOSTPERIOD)
;

create index XIE4CREDITORITEM
  on CREDITORITEM (ITEMTYPE)
;

create index XIE5CREDITORITEM
  on CREDITORITEM (PROTOCOLNO, PROTOCOLDATE)
;

create table CREDITORHISTORY
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTCREDITORNO] int not null,
  [HISTORYLINENO] smallint not null,
  [DOCUMENTREF] nvarchar(20) not null,
  [TRANSDATE] datetime not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [TRANSTYPE] smallint not null
    constraint R_936
    references ACCT_TRANS_TYPE,
  [MOVEMENTCLASS] smallint not null,
  [COMMANDID] smallint not null,
  [ITEMPRETAXVALUE] decimal(11,2),
  [LOCALTAXAMT] decimal(11,2),
  [LOCALVALUE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [FOREIGNTAXAMT] decimal(11,2),
  [FOREIGNTRANVALUE] decimal(11,2),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [FORCEDPAYOUT] decimal(1),
  [CURRENCY] nvarchar(3)
    constraint R_915
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [STATUS] smallint
    constraint RI_916
    references TRANSACTION_STATUS,
  [ASSOCLINENO] smallint,
  [ITEMIMPACT] smallint,
  [DESCRIPTION] nvarchar(254),
  [LONGDESCRIPTION] ntext,
  [GLMOVEMENTNO] int,
  [GLSTATUS] int,
  [REMITTANCENAMENO] int
    constraint R_1296
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCREDITORHISTORY
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO, HISTORYLINENO),
  constraint R_913
  foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO) references CREDITORITEM,
  constraint R_914
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create index XIE1CREDITORHISTORY
  on CREDITORHISTORY (ACCTCREDITORNO)
;

create index XIE2CREDITORHISTORY
  on CREDITORHISTORY (ITEMENTITYNO, DOCUMENTREF)
;

create index XIE3CREDITORHISTORY
  on CREDITORHISTORY (REFENTITYNO, REFTRANSNO)
;

create index XIE4CREDITORHISTORY
  on CREDITORHISTORY (ITEMENTITYNO, POSTPERIOD)
;

create index XIE5CREDITORHISTORY
  on CREDITORHISTORY (ACCTENTITYNO, ACCTCREDITORNO, POSTPERIOD)
;

create index XIE6CREDITORHISTORY
  on CREDITORHISTORY (MOVEMENTCLASS, POSTPERIOD, POSTDATE, LOCALVALUE)
;

create index XIE7CREDITORHISTORY
  on CREDITORHISTORY (REMITTANCENAMENO)
;

create table REVENUETRACK
(
  [REVENUEID] int not null
    constraint XPKREVENUETRACK
    primary key,
  [PAYERNO] int,
  [ENTRYDATE] datetime not null,
  [REVENUEDATE] datetime,
  [REFERENCE] nvarchar(12),
  [REVENUEAMT] decimal(11,2) not null,
  [COMMENTS] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table REVENUETRACKALLOC
(
  [REVENUEID] int not null
    constraint R_1021
    references REVENUETRACK,
  [REVENUEALLOCNO] smallint not null,
  [CASEID] int not null,
  [REVENUEPERCENTAGE] decimal(5,2),
  [REASON] int not null,
  [ALLOCAMT] decimal(11,2) not null,
  [INTERNALREVFLAG] decimal(1) not null,
  [FAMILY] nvarchar(20),
  [SHARERNO] int,
  [DIVISIONNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREVENUETRACKALLOC
  primary key (REVENUEID, REVENUEALLOCNO)
)
;

create table CREDITOR
(
  [NAMENO] int not null
    constraint XPKCREDITOR
    primary key
    constraint R_924
    references NAME,
  [SUPPLIERTYPE] int not null
    constraint R_926
    references TABLECODES,
  [DEFAULTTAXCODE] nvarchar(3),
  [TAXTREATMENT] int
    constraint R_928
    references TABLECODES,
  [PURCHASECURRENCY] nvarchar(3)
    constraint R_929
    references CURRENCY,
  [PAYMENTTERMNO] int,
  [CHEQUEPAYEE] nvarchar(254),
  [INSTRUCTIONS] nvarchar(254),
  [EXPENSEACCOUNT] int,
  [PROFITCENTRE] nvarchar(6)
    constraint R_1018
    references PROFITCENTRE,
  [PAYMENTMETHOD] int
    constraint R_1019
    references PAYMENTMETHODS,
  [BANKNAME] nvarchar(60),
  [BANKBRANCHNO] nvarchar(10),
  [BANKACCOUNTNO] nvarchar(20),
  [BANKACCOUNTNAME] nvarchar(60),
  [BANKACCOUNTOWNER] int,
  [BANKNAMENO] int,
  [BANKSEQUENCENO] int,
  [RESTRICTIONID] int,
  [RESTNREASONCODE] nvarchar(2)
    constraint R_1098
    references REASON,
  [PURCHASEDESC] nvarchar(254),
  [DISBWIPCODE] nvarchar(6)
    constraint R_1099
    references WIPTEMPLATE,
  [BEIBANKCODE] nvarchar(4),
  [BEICOUNTRYCODE] nvarchar(2),
  [BEILOCATIONCODE] nvarchar(2),
  [BEIBRANCHCODE] nvarchar(3),
  [INSTRUCTIONS_TID] int,
  [EXCHSCHEDULEID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_1032
  foreign key (BANKACCOUNTOWNER, BANKNAMENO, BANKSEQUENCENO) references BANKACCOUNT
)
;

create index XIE1CREDITOR
  on CREDITOR (SUPPLIERTYPE)
;

create index XIE2CREDITOR
  on CREDITOR (TAXTREATMENT)
;

create table CRENTITYDETAIL
(
  [NAMENO] int not null
    constraint R_931
    references CREDITOR,
  [ENTITYNAMENO] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [SUPPLIERACCOUNTNO] nvarchar(30) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCRENTITYDETAIL
  primary key (NAMENO, ENTITYNAMENO),
  constraint R_935
  foreign key (ENTITYNAMENO, BANKNAMENO, SEQUENCENO) references BANKACCOUNT
)
;

create table OFFICE
(
  [OFFICEID] int not null
    constraint XPKOFFICE
    primary key,
  [DESCRIPTION] nvarchar(80) not null,
  [USERCODE] nvarchar(10),
  [COUNTRYCODE] nvarchar(3)
    constraint R_939
    references COUNTRY,
  [DESCRIPTION_TID] int,
  [LANGUAGECODE] int
    constraint R_1255
    references TABLECODES,
  [CPACODE] nvarchar(3),
  [RESOURCENO] int,
  [ITEMNOPREFIX] nvarchar(2),
  [ITEMNOFROM] decimal(10),
  [ITEMNOTO] decimal(10),
  [LASTITEMNO] decimal(10),
  [REGION] int
    constraint R_91868
    references TABLECODES,
  [ORGNAMENO] int
    constraint R_91877
    references NAME,
  [IRNCODE] nvarchar(3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1OFFICE
  on OFFICE (DESCRIPTION)
;

create index XIE1OFFICE
  on OFFICE (OFFICEID, ITEMNOPREFIX, ITEMNOFROM, ITEMNOTO, LASTITEMNO)
;

create index XIE2OFFICE
  on OFFICE (LANGUAGECODE)
;

create index XIE3OFFICE
  on OFFICE (REGION)
;

alter table BILLFORMAT
  add constraint RI_945
foreign key (OFFICEID) references OFFICE
;

--alter table CASES
--  add constraint Ri_982
--foreign key (OFFICEID) references OFFICE
--;

alter table CRITERIA
  add constraint RI_983
foreign key (CASEOFFICEID) references OFFICE
;

alter table FEELIST
  add constraint R_91601
foreign key (OFFICEID) references OFFICE
;

alter table GLACCOUNTMAPPING
  add constraint R_1065
foreign key (SOURCEOFFICEID) references OFFICE
;

alter table INTERNALREFSTEM
  add constraint R_1247
foreign key (CASEOFFICEID) references OFFICE
;

alter table ROWACCESSDETAIL
  add constraint R_948
foreign key (OFFICE) references OFFICE
;

alter table TIMECOSTING
  add constraint R_1031
foreign key (OFFICE) references OFFICE
;

alter table TIMECOSTING
  add constraint R_81495
foreign key (CASEOFFICE) references OFFICE
;

create table TAXRATESCOUNTRY
(
  [TAXCODE] nvarchar(3) not null,
  [COUNTRYCODE] nvarchar(3) not null,
  [RATE] decimal(8,4),
  [TAXRATESCOUNTRYID] int identity
    constraint XPKTAXRATESCOUNTRY
    primary key,
  [STATE] nvarchar(20),
  [HARMONISED] bit,
  [TAXONTAX] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [EFFECTIVEDATE] datetime,
  constraint R_91895
  foreign key (COUNTRYCODE, STATE) references STATE
)
;

create unique index XAK1TAXRATESCOUNTRY
  on TAXRATESCOUNTRY (TAXCODE, COUNTRYCODE, STATE, EFFECTIVEDATE)
;

create index XIE1TAXRATESCOUNTRY
  on TAXRATESCOUNTRY (TAXCODE, COUNTRYCODE)
;

create table LEDGERACCOUNT
(
  [ACCOUNTID] int not null
    constraint XPKLEDGERACCOUNT
    primary key,
  [ACCOUNTCODE] nvarchar(100) not null,
  [DESCRIPTION] nvarchar(100) not null,
  [ACCOUNTTYPE] int not null
    constraint R_951
    references TABLECODES,
  [ISACTIVE] decimal(1),
  [PARENTACCOUNTID] int
    constraint R_952
    references LEDGERACCOUNT,
  [DISBURSETOWIP] decimal(1),
  [BUDGETMOVEMENT] decimal(1) default 1 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1LEDGERACCOUNT
  on LEDGERACCOUNT (ACCOUNTCODE)
;

create index XIE1LEDGERACCOUNT
  on LEDGERACCOUNT (DESCRIPTION)
;

create index XIE2LEDGERACCOUNT
  on LEDGERACCOUNT (ACCOUNTTYPE)
;

alter table BANKACCOUNT
  add constraint R_1162
foreign key (CABACCOUNTID) references LEDGERACCOUNT
;

alter table BANKACCOUNT
  add constraint R_1164
foreign key (CABCACCOUNTID) references LEDGERACCOUNT
;

alter table GENERALLEDGERACCTS
  add constraint R_1023
foreign key (LEDGERACCOUNTID) references LEDGERACCOUNT
;

alter table GLJOURNALLINE
  add constraint RI_1090
foreign key (LEDGERACCOUNTID) references LEDGERACCOUNT
;

alter table CREDITOR
  add constraint R_1017
foreign key (EXPENSEACCOUNT) references LEDGERACCOUNT
;

create table LEDGERJOURNAL
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [USERID] nvarchar(30),
  [DESCRIPTION] nvarchar(254),
  [REFERENCE] nvarchar(20),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [STATUS] smallint not null
    constraint R_967
    references TRANSACTION_STATUS,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLEDGERJOURNAL
  primary key (ENTITYNO, TRANSNO),
  constraint R_953
  foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER,
  constraint R_954
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create table LEDGERJOURNALLINE
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [SEQNO] int not null,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_957
    references PROFITCENTRE,
  [ACCOUNTID] int not null
    constraint R_958
    references LEDGERACCOUNT,
  [LOCALAMOUNT] decimal(11,2) not null,
  [NOTES] nvarchar(254),
  [ACCTENTITYNO] int default 0 not null
    constraint RI_1022
    references SPECIALNAME,
  [CURRENCY] nvarchar(3)
    constraint RI_1086
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [FOREIGNAMOUNT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLEDGERJOURNALLINE
  primary key (ENTITYNO, TRANSNO, SEQNO),
  constraint RI_956
  foreign key (ENTITYNO, TRANSNO) references LEDGERJOURNAL
)
;

create index XIE1LEDGERJOURNALLINE
  on LEDGERJOURNALLINE (ACCTENTITYNO, TRANSNO)
;

create table PAYMENTPLANDETAIL
(
  [PLANID] int not null,
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTCREDITORNO] int not null,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [PAYMENTAMOUNT] decimal(11,2) not null,
  [FXDEALERREF] nvarchar(16),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [PROFITCENTRECODE] nvarchar(6)
    constraint R_81535
    references PROFITCENTRE,
  [ACCOUNTID] int
    constraint R_81536
    references LEDGERACCOUNT,
  constraint XPKPAYMENTPLANDETAIL
  primary key (PLANID, ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO),
  constraint R_965
  foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO) references CREDITORITEM,
  constraint R_966
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create table CPALOAD
(
  [DATASTRING] ntext
)
;

create table test
(
  [irn] nvarchar(60)
)
;

create table taxrates
(
  [TAXCODE] nvarchar(3) not null
    constraint XPKTAXRATES
    primary key,
  [DESCRIPTION] nvarchar(30),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [WIPCODE] nvarchar(6)
    constraint R_81737
    references WIPTEMPLATE,
  [WIPCATEGORY] nvarchar(3)
    constraint R_81738
    references WIPCATEGORY,
  [NARRATIVENO] smallint,
  [CURRENCYCODE] nvarchar(3)
    constraint R_81740
    references CURRENCY,
  [MAXFREEAMOUNT] decimal(12,2),
  [FEEAMOUNT] decimal(12,2),
  [FEEPERCENTAGE] decimal(8,4),
  [HIDEFEEINDRAFT] bit default 0
)
;

alter table ACTIVITYHISTORY
  add constraint R_91415
foreign key (DISBSTATETAXCODE) references taxrates
;

alter table ACTIVITYHISTORY
  add constraint R_91416
foreign key (SERVSTATETAXCODE) references taxrates
;

alter table ACTIVITYREQUEST
  add constraint R_91413
foreign key (DISBSTATETAXCODE) references taxrates
;

alter table ACTIVITYREQUEST
  add constraint R_91414
foreign key (SERVSTATETAXCODE) references taxrates
;

alter table BILLEDITEM
  add constraint R_81742
foreign key (GENERATEDFROMTAXCODE) references taxrates
;

--alter table CASES
--  add constraint R_1556
--foreign key (TAXCODE) references taxrates
--;

--jalter table CASES
--j  add constraint R_91897
--jforeign key (STATETAXCODE) references taxrates
--j;

alter table COUNTRY
  add constraint R_61
foreign key (DEFAULTTAXCODE) references taxrates
;

alter table FEELISTCASE
  add constraint R_1520
foreign key (TAXCODE) references taxrates
;

alter table FEESCALCULATION
  add constraint R_20124
foreign key (DISBTAXCODE) references taxrates
;

alter table FEESCALCULATION
  add constraint R_20125
foreign key (SERVTAXCODE) references taxrates
;

alter table IPNAME
  add constraint R_848
foreign key (TAXCODE) references taxrates
;

alter table IPNAME
  add constraint R_91896
foreign key (STATETAXCODE) references taxrates
;

alter table OPENITEMTAX
  add constraint R_1246
foreign key (TAXCODE) references taxrates
;

alter table TAXHISTORY
  add constraint R_1257
foreign key (TAXCODE) references taxrates
;

alter table WIPTEMPLATE
  add constraint RI_1172
foreign key (TAXCODE) references taxrates
;

alter table WIPTEMPLATE
  add constraint R_91898
foreign key (STATETAXCODE) references taxrates
;

alter table CREDITOR
  add constraint R_927
foreign key (DEFAULTTAXCODE) references taxrates
;

alter table TAXRATESCOUNTRY
  add constraint RI_941
foreign key (TAXCODE) references taxrates
;

create table CHEQUEREGISTER
(
  [CHEQUEREGISTERID] int not null
    constraint XPKCHEQUEREGISTER
    primary key,
  [BANKENTITYNO] int not null,
  [BANKNAMENO] int not null,
  [BANKSEQUENCENO] int not null,
  [CHEQUENO] nvarchar(30) not null,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [MANUALFLAG] decimal(1),
  [STATUS] int not null
    constraint R_970
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_968
  foreign key (BANKENTITYNO, BANKNAMENO, BANKSEQUENCENO) references BANKACCOUNT,
  constraint R_969
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create unique index XAK1CHEQUEREGISTER
  on CHEQUEREGISTER (BANKENTITYNO, BANKNAMENO, BANKSEQUENCENO, CHEQUENO)
;

create index XIE1CHEQUEREGISTER
  on CHEQUEREGISTER (STATUS)
;

create table BANKSTATEMENT
(
  [STATEMENTNO] int not null
    constraint XPKBANKSTATEMENT
    primary key,
  [ACCOUNTOWNER] int not null,
  [BANKNAMENO] int not null,
  [ACCOUNTSEQUENCENO] int not null,
  [STATEMENTENDDATE] datetime not null,
  [CLOSINGBALANCE] decimal(13,2) not null,
  [ISRECONCILED] decimal(1) not null,
  [USERID] nvarchar(30) not null,
  [DATECREATED] datetime not null,
  [OPENINGBALANCE] decimal(13,2) default 0 not null,
  [RECONCILEDDATE] datetime,
  [IDENTITYID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint RI_972
  foreign key (ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO) references BANKACCOUNT
)
;

create unique index XAK1BANKSTATEMENT
  on BANKSTATEMENT (ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO, STATEMENTENDDATE)
;

create table STATEMENTTRANS
(
  [STATEMENTNO] int not null
    constraint R_973
    references BANKSTATEMENT,
  [ACCOUNTOWNER] int not null,
  [BANKNAMENO] int not null,
  [ACCOUNTSEQUENCENO] int not null,
  [HISTORYLINENO] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTATEMENTTRANS
  primary key (STATEMENTNO, ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO, HISTORYLINENO),
  constraint R_974
  foreign key (ACCOUNTOWNER, BANKNAMENO, ACCOUNTSEQUENCENO, HISTORYLINENO) references BANKHISTORY
)
;

create table PAYMENTPLAN
(
  [PLANID] int not null
    constraint XPKPAYMENTPLAN
    primary key,
  [PLANNAME] nvarchar(50) not null,
  [DATECREATED] datetime,
  [CREATEDBY] nvarchar(30),
  [ENTITYNO] int not null,
  [BANKNAMENO] int not null,
  [BANKSEQUENCENO] int not null,
  [DATEPROCESSED] datetime,
  [PAYMENTMETHOD] int not null
    constraint R_975
    references PAYMENTMETHODS,
  [IDENTITYID] int,
  [PAYMENTDATE] datetime default getdate() not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_962
  foreign key (ENTITYNO, BANKNAMENO, BANKSEQUENCENO) references BANKACCOUNT
)
;

create unique index XAK1PAYMENTPLAN
  on PAYMENTPLAN (PLANNAME)
;

alter table PAYMENTPLANDETAIL
  add constraint R_964
foreign key (PLANID) references PAYMENTPLAN
;

create table MERGEFIELD
(
  [FIELDID] int not null
    constraint XPKMERGEFIELD
    primary key,
  [FIELDNAME] nvarchar(40) not null,
  [MERGEFIELD] nvarchar(40),
  [ITEM_ID] int,
  [ITEMPARAMETER] nvarchar(254),
  [RESULTSEPARATOR] nvarchar(40),
  [FIELDDESCRIPTION] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1MERGEFIELD
  on MERGEFIELD (FIELDNAME)
;

create table MERGELETTERFIELD
(
  [LETTERNO] smallint not null
    constraint RI_977
    references LETTER,
  [FIELDID] int not null
    constraint RI_978
    references MERGEFIELD,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKMERGELETTERFIELD
  primary key (LETTERNO, FIELDID)
)
;

create table ANALYSISCODE
(
  [CODEID] int not null
    constraint XPKANALYSISCODE
    primary key,
  [CODE] nvarchar(20) not null,
  [DESCRIPTION] nvarchar(40) not null,
  [TYPEID] int not null
    constraint RI_979
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ANALYSISCODE
  on ANALYSISCODE (CODE, DESCRIPTION)
;

create index XIE1ANALYSISCODE
  on ANALYSISCODE (TYPEID)
;

create table PROFITCENTRERULE
(
  [ANALYSISCODE] int not null
    constraint RI_980
    references ANALYSISCODE,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint Ri_981
    references PROFITCENTRE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKPROFITCENTRERULE
  primary key (ANALYSISCODE, PROFITCENTRECODE)
)
;

create table DATESLOGIC
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [SEQUENCENO] int not null,
  [DATETYPE] smallint not null,
  [OPERATOR] nvarchar(2),
  [COMPAREEVENT] int,
  [MUSTEXIST] decimal(1) not null,
  [RELATIVECYCLE] smallint,
  [COMPAREDATETYPE] smallint not null,
  [CASERELATIONSHIP] nvarchar(3),
  [DISPLAYERRORFLAG] decimal(1),
  [ERRORMESSAGE] nvarchar(254),
  [INHERITED] decimal(1),
  [ERRORMESSAGE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDATESLOGIC
  primary key (CRITERIANO, EVENTNO, SEQUENCENO)
)
;

create table FREQUENCY
(
  [FREQUENCYNO] int not null
    constraint XPKFREQUENCY
    primary key,
  [DESCRIPTION] nvarchar(30) not null,
  [FREQUENCY] int not null,
  [PERIODTYPE] nchar(1) not null,
  [FREQUENCYTYPE] int not null,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1FREQUENCY
  on FREQUENCY (DESCRIPTION, FREQUENCYTYPE)
;

alter table CREDITOR
  add constraint R_991
foreign key (PAYMENTTERMNO) references FREQUENCY
;

create table STANDINGTEMPLT
(
  [TEMPLATENO] int not null
    constraint XPKSTANDINGTEMPLT
    primary key,
  [NAME] nvarchar(100) not null,
  [FREQUENCYNO] int not null
    constraint R_984
    references FREQUENCY,
  [DAYOFWEEK] int,
  [DAYOFMONTH] int,
  [MONTHOFYEAR] int
    constraint R_986
    references TABLECODES,
  [STARTDATE] datetime not null,
  [ENDDATE] datetime,
  [ENDAFTERENTRIES] int,
  [NEXTDUEDATE] datetime,
  [LASTPOSTED] datetime,
  [NUMBEROFPOSTS] int,
  [ENTITYNO] int not null
    constraint R_987
    references SPECIALNAME,
  [DESCRIPTION] nvarchar(254),
  [REFERENCE] nvarchar(20),
  [USERID] nvarchar(30) not null,
  [ONHOLD] decimal(1) default 0 not null,
  [IDENTITYID] int,
  [CURRENCY] nvarchar(3)
    constraint R_1104
    references CURRENCY,
  [EXCHRATETYPE] int,
  [EXCHRATE] decimal(8,4),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [TRANSTYPE] smallint default 810 not null
    constraint R_81649
    references ACCT_TRANS_TYPE
)
;

create unique index XAK1STANDINGTEMPLT
  on STANDINGTEMPLT (NAME)
;

create index XIE1STANDINGTEMPLT
  on STANDINGTEMPLT (MONTHOFYEAR)
;

create table STANDINGTEMPLTLINE
(
  [TEMPLATENO] int not null
    constraint R_988
    references STANDINGTEMPLT,
  [SEQNO] int not null,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_989
    references PROFITCENTRE,
  [ACCOUNTID] int not null
    constraint R_990
    references LEDGERACCOUNT,
  [LOCALAMOUNT] decimal(11,2) not null,
  [NOTES] nvarchar(254),
  [CURRENCY] nvarchar(3)
    constraint R_1087
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [FOREIGNAMOUNT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTANDINGTEMPLTLINE
  primary key (TEMPLATENO, SEQNO)
)
;

create table POSTCODE
(
  [POSTCODE] nvarchar(10) not null,
  [CITY] nvarchar(30) not null,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_1004
    references COUNTRY,
  [STATE] nvarchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKPOSTCODE
  primary key (POSTCODE, CITY, COUNTRYCODE)
)
;

create index XIE1POSTCODE
  on POSTCODE (POSTCODE)
;

create index XIE2POSTCODE
  on POSTCODE (CITY)
;

create index XIE3POSTCODE
  on POSTCODE (COUNTRYCODE)
;

create index XIE4POSTCODE
  on POSTCODE (STATE)
;

create table CLASSFIRSTUSE
(
  [CASEID] int not null
    constraint R_1006
    references CASES,
  [CLASS] nvarchar(11) not null,
  [FIRSTUSE] datetime,
  [FIRSTUSEINCOMMERCE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCLASSFIRSTUSE
  primary key (CASEID, CLASS)
)
;

create table DESIGNELEMENT
(
  [CASEID] int not null
    constraint RI_1007
    references CASES,
  [SEQUENCE] int not null,
  [FIRMELEMENTID] nvarchar(20) not null,
  [ELEMENTDESC] nvarchar(254),
  [CLIENTELEMENTID] nvarchar(20),
  [RENEWFLAG] decimal(1),
  [TYPEFACE] int not null,
  [OFFICIALELEMENTID] nvarchar(20),
  [REGISTRATIONNO] nvarchar(36),
  [ELEMENTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDESIGNELEMENT
  primary key (CASEID, SEQUENCE)
)
;

create table INTERENTITYACCOUNT
(
  [INTERENTITYACCTID] int not null
    constraint XPKINTERENTITYACCOUNT
    primary key,
  [MAINENTITYNO] int not null
    constraint R_1008
    references SPECIALNAME,
  [INTERENTITYNO] int not null
    constraint RI_1009
    references SPECIALNAME,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_1010
    references PROFITCENTRE,
  [ACCOUNTID] int not null
    constraint R_1011
    references LEDGERACCOUNT,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1INTERENTITYACCOUNT
  on INTERENTITYACCOUNT (MAINENTITYNO, INTERENTITYNO)
;

create table DEFAULTACCOUNT
(
  [DEFAULTACCOUNTID] int not null
    constraint XPKDEFAULTACCOUNT
    primary key,
  [CONTROLACCTYPEID] int not null
    constraint RI_1013
    references TABLECODES,
  [ENTITYNO] int not null
    constraint R_1014
    references SPECIALNAME,
  [ACCOUNTID] int not null
    constraint R_1015
    references LEDGERACCOUNT,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_1016
    references PROFITCENTRE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DEFAULTACCOUNT
  on DEFAULTACCOUNT (CONTROLACCTYPEID, ENTITYNO)
;

create index XIE1DEFAULTACCOUNT
  on DEFAULTACCOUNT (CONTROLACCTYPEID)
;

create table IMPORTMETHOD
(
  [IMPORTMETHODNO] int not null
    constraint XPKIMPORTMETHOD
    primary key,
  [IMPORTMETHODNAME] nvarchar(40) not null,
  [IMPORTMETHODDESC] nvarchar(254) not null,
  [IMPORTPROCEDURE] nvarchar(254) not null,
  [XSLTFILELOCATION] nvarchar(254),
  [SCHEMAFILELOCATION] nvarchar(254),
  [WORKINGDIRECTORY] nvarchar(254),
  [BULKFLAG] decimal(1),
  [IMPORTMETHODNAME_TID] int,
  [IMPORTMETHODDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1IMPORTMETHOD
  on IMPORTMETHOD (IMPORTMETHODNAME)
;

create table IMPORTQUEUE
(
  [IMPORTQUEUENO] int identity
    constraint XPKIMPORTQUEUE
    primary key,
  [IMPORTFILELOCATION] nvarchar(254),
  [IMPORTMETHODNO] int not null
    constraint R_1020
    references IMPORTMETHOD,
  [ONHOLDFLAG] decimal(1),
  [PROCESSEDFLAG] decimal(1),
  [WHENINSERTED] datetime default getdate() not null,
  [WHENPROCESSED] datetime,
  [ERRORMESSAGE] nvarchar(254),
  [IMPORTPROCEDURE] nvarchar(254),
  [PROCEDUREPARAM] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1IMPORTQUEUE
  on IMPORTQUEUE (PROCESSEDFLAG, WHENINSERTED)
;

create table ACCESSACCOUNT
(
  [ACCOUNTID] int identity
    constraint XPKACCESSACCOUNT
    primary key,
  [ACCOUNTNAME] nvarchar(50) not null,
  [ISINTERNAL] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ACCESSACCOUNT
  on ACCESSACCOUNT (ACCOUNTNAME)
;

create table ACCESSACCOUNTNAMES
(
  [ACCOUNTID] int not null
    constraint R_1028
    references ACCESSACCOUNT,
  [NAMENO] int not null
    constraint R_1029
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKACCESSACCOUNTNAMES
  primary key (ACCOUNTID, NAMENO)
)
;

create table CASEINDEXES
(
  [GENERICINDEX] nvarchar(254) not null,
  [CASEID] int not null
    constraint R_1033
    references CASES,
  [SOURCE] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEINDEXES
  primary key (GENERICINDEX, CASEID, SOURCE)
)
;

create index XIE1CASEINDEXES
  on CASEINDEXES (CASEID)
;

create table QUERYDATAITEM
(
  [DATAITEMID] int not null
    constraint XPKQUERYDATAITEM
    primary key,
  [PROCEDURENAME] nvarchar(50) not null,
  [PROCEDUREITEMID] nvarchar(50) not null,
  [QUALIFIERTYPE] smallint,
  [SORTDIRECTION] nvarchar(1),
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [ISMULTIRESULT] bit default 0 not null,
  [DATAFORMATID] int default 9100 not null
    constraint R_1071
    references TABLECODES,
  [DECIMALPLACES] tinyint,
  [FORMATITEMID] nvarchar(50),
  [FILTERNODENAME] nvarchar(50),
  [ISAGGREGATE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYDATAITEM
  on QUERYDATAITEM (PROCEDURENAME, PROCEDUREITEMID)
;

create index XIE1QUERYDATAITEM
  on QUERYDATAITEM (DATAFORMATID)
;

create table QUERYCOLUMN
(
  [COLUMNID] int identity
    constraint XPKQUERYCOLUMN
    primary key,
  [DATAITEMID] int not null
    constraint R_1037
    references QUERYDATAITEM,
  [QUALIFIER] nvarchar(20),
  [COLUMNLABEL] nvarchar(50) not null,
  [COLUMNLABEL_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [DOCITEMID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUERYCOLUMNGROUP
(
  [GROUPID] int identity
    constraint XPKQUERYCOLUMNGROUP
    primary key,
  [CONTEXTID] int not null,
  [GROUPNAME] nvarchar(50) not null,
  [GROUPNAME_TID] int,
  [DISPLAYSEQUENCE] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYCOLUMNGROUP
  on QUERYCOLUMNGROUP (CONTEXTID, GROUPNAME)
;

create unique index XAK2QUERYCOLUMNGROUP
  on QUERYCOLUMNGROUP (CONTEXTID, DISPLAYSEQUENCE)
;

create table QUERYCONTEXTCOLUMN
(
  [CONTEXTID] int not null,
  [COLUMNID] int not null
    constraint R_1044
    references QUERYCOLUMN,
  [GROUPID] int
    constraint R_1045
    references QUERYCOLUMNGROUP,
  [ISMANDATORY] bit default 0 not null,
  [ISSORTONLY] bit default 0 not null,
  [USAGE] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUERYCONTEXTCOLUMN
  primary key (CONTEXTID, COLUMNID)
)
;

create table QUERYFILTER
(
  [FILTERID] int identity
    constraint XPKQUERYFILTER
    primary key,
  [PROCEDURENAME] nvarchar(50) not null,
  [XMLFILTERCRITERIA] ntext not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUERYPRESENTATION
(
  [PRESENTATIONID] int identity
    constraint XPKQUERYPRESENTATION
    primary key,
  [CONTEXTID] int not null,
  [IDENTITYID] int
    constraint R_1047
    references USERIDENTITY,
  [ISDEFAULT] bit default 0 not null,
  [REPORTTITLE] nvarchar(80),
  [REPORTTEMPLATE] nvarchar(254),
  [REPORTTOOL] int
    constraint R_1125
    references TABLECODES,
  [EXPORTFORMAT] int
    constraint R_1126
    references TABLECODES,
  [REPORTTITLE_TID] int,
  [PRESENTATIONTYPE] nvarchar(30),
  [ACCESSACCOUNTID] int
    constraint R_91598
    references ACCESSACCOUNT,
  [ISPROTECT] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FREEZECOLUMNID] int
    constraint R_81603
    references QUERYCOLUMN
)
;

create index XIE1QUERYPRESENTATION
  on QUERYPRESENTATION (REPORTTOOL)
;

create index XIE2QUERYPRESENTATION
  on QUERYPRESENTATION (EXPORTFORMAT)
;

create table QUERYGROUP
(
  [GROUPID] int identity
    constraint XPKQUERYGROUP
    primary key,
  [CONTEXTID] int not null,
  [GROUPNAME] nvarchar(50) not null,
  [GROUPNAME_TID] int,
  [DISPLAYSEQUENCE] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYGROUP
  on QUERYGROUP (CONTEXTID, GROUPNAME)
;

create unique index XAK2QUERYGROUP
  on QUERYGROUP (CONTEXTID, DISPLAYSEQUENCE)
;

create table QUERY
(
  [QUERYID] int identity
    constraint XPKQUERY
    primary key,
  [CONTEXTID] int not null,
  [IDENTITYID] int
    constraint R_1051
    references USERIDENTITY,
  [QUERYNAME] nvarchar(50) not null,
  [QUERYNAME_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [PRESENTATIONID] int
    constraint R_1054
    references QUERYPRESENTATION,
  [FILTERID] int
    constraint R_1055
    references QUERYFILTER,
  [GROUPID] int
    constraint R_1056
    references QUERYGROUP,
  [ISCLIENTSERVER] bit default 0 not null,
  [ISPROTECTED] bit default 0 not null,
  [ISREADONLY] bit default 0 not null,
  [ALTPRESENTATIONID] int
    constraint R_91508
    references QUERYPRESENTATION,
  [ACCESSACCOUNTID] int
    constraint R_91600
    references ACCESSACCOUNT,
  [ISPUBLICTOEXTERNAL] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERY
  on QUERY (CONTEXTID, IDENTITYID, QUERYNAME)
;

create table QUERYCONTENT
(
  [CONTENTID] int identity
    constraint XPKQUERYCONTENT
    primary key,
  [PRESENTATIONID] int not null
    constraint R_1057
    references QUERYPRESENTATION,
  [COLUMNID] int not null,
  [DISPLAYSEQUENCE] smallint,
  [SORTORDER] smallint,
  [SORTDIRECTION] nvarchar(1),
  [CONTEXTID] int default 0 not null,
  [TITLE] nvarchar(254),
  [TITLE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ISMANDATORY] tinyint,
  [GROUPBYSEQUENCE] smallint,
  [GROUPBYSORTDIR] nvarchar(1),
  constraint R_1121
  foreign key (CONTEXTID, COLUMNID) references QUERYCONTEXTCOLUMN
)
;

create unique index XAK1QUERYCONTENT
  on QUERYCONTENT (PRESENTATIONID, COLUMNID)
;

create table DATATOPIC
(
  [TOPICID] smallint not null
    constraint XPKDATATOPIC
    primary key,
  [TOPICNAME] nvarchar(50) not null,
  [TOPICNAME_TID] int,
  [DESCRIPTION] nvarchar(1000),
  [DESCRIPTION_TID] int,
  [ISEXTERNAL] bit default 0 not null,
  [ISINTERNAL] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DATATOPIC
  on DATATOPIC (TOPICNAME)
;

create table ROLETOPICS
(
  [ROLEID] int not null,
  [TOPICID] smallint not null
    constraint R_1062
    references DATATOPIC,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKROLETOPICS
  primary key (ROLEID, TOPICID)
)
;

create table TOPICDATAITEMS
(
  [TOPICID] smallint not null
    constraint R_1063
    references DATATOPIC,
  [DATAITEMID] int not null
    constraint R_1064
    references QUERYDATAITEM,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTOPICDATAITEMS
  primary key (TOPICID, DATAITEMID)
)
;

create table QUERYIMPLIEDDATA
(
  [IMPLIEDDATAID] int not null
    constraint XPKQUERYIMPLIEDDATA
    primary key,
  [CONTEXTID] int not null,
  [DATAITEMID] int
    constraint RI_1067
    references QUERYDATAITEM,
  [TYPE] nvarchar(50) not null,
  [NOTES] nvarchar(254),
  [NOTES_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUERYIMPLIEDITEM
(
  [IMPLIEDDATAID] int not null
    constraint RI_1070
    references QUERYIMPLIEDDATA,
  [SEQUENCENO] tinyint not null,
  [PROCEDUREITEMID] nvarchar(50) not null,
  [USESQUALIFIER] bit default 0 not null,
  [USAGE] nvarchar(50),
  [PROCEDURENAME] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUERYIMPLIEDITEM
  primary key (IMPLIEDDATAID, SEQUENCENO)
)
;

create table COSTRATE
(
  [COSTRATENO] int not null
    constraint XPKCOSTRATE
    primary key,
  [RATEPERCENT1] decimal(6,2),
  [RATEPERCENT2] decimal(6,2),
  [RATEAMOUNT1] decimal(10,2),
  [RATEAMOUNT2] decimal(10,2),
  [WIPCODE] nvarchar(6)
    constraint RI_1074
    references WIPTEMPLATE,
  [WIPTYPE] nvarchar(6)
    constraint RI_1075
    references WIPTYPE,
  [WIPCATEGORY] nvarchar(3)
    constraint RI_1076
    references WIPCATEGORY,
  [STAFFCLASS] int
    constraint RI_1077
    references TABLECODES,
  [EMPLOYEENO] int
    constraint RI_1078
    references EMPLOYEE,
  [EFFECTIVEDATE] datetime not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1COSTRATE
  on COSTRATE (WIPCODE, WIPTYPE, WIPCATEGORY, STAFFCLASS, EMPLOYEENO, EFFECTIVEDATE)
;

create index XIE1COSTRATE
  on COSTRATE (STAFFCLASS)
;

create table CASEBUDGET
(
  [CASEID] int not null
    constraint RI_1079
    references CASES,
  [SEQUENCENO] smallint not null,
  [REVISEDFLAG] decimal(1) not null,
  [STAFFCLASS] int
    constraint RI_1080
    references TABLECODES,
  [EMPLOYEENO] int
    constraint RI_1081
    references EMPLOYEE,
  [WIPCODE] nvarchar(6)
    constraint RI_1082
    references WIPTEMPLATE,
  [HOURS] decimal(11,2),
  [CHARGEOUTRATE] decimal(11,2),
  [CHARGERATECURRENCY] nvarchar(3),
  [AMOUNT] decimal(11,2),
  [VALUE] decimal(11,2),
  [COSTCALCULATION1] decimal(11,2),
  [COSTCALCULATION2] decimal(11,2),
  [PROFIT1] decimal(11,2),
  [PROFIT2] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEBUDGET
  primary key (CASEID, SEQUENCENO)
)
;

create index XIE1CASEBUDGET
  on CASEBUDGET (REVISEDFLAG)
;

create index XIE2CASEBUDGET
  on CASEBUDGET (STAFFCLASS)
;

create table BUDGET
(
  [ENTITYNO] int not null
    constraint R_1095
    references NAME,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint Ri_1084
    references PROFITCENTRE,
  [LEDGERACCOUNTID] int not null
    constraint Ri_1083
    references LEDGERACCOUNT,
  [PERIODID] int not null
    constraint RI_1085
    references PERIOD,
  [BUDGETAMOUNT] decimal(13,2),
  [BUDGETCREATIONDATE] datetime,
  [BUDGETLASTMODIFIED] datetime,
  [FRCSTAMOUNT] decimal(13,2),
  [FRCSTCREATIONDATE] datetime,
  [FRCSTLASTMODIFIED] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKBUDGET
  primary key (ENTITYNO, PROFITCENTRECODE, LEDGERACCOUNTID, PERIODID)
)
;

create table QUERYCONTEXTHIDDEN
(
  [CONTEXTID] int not null,
  [COLUMNID] int not null
    constraint R_1089
    references QUERYCOLUMN,
  [DISPLAYSEQUENCE] int not null,
  [PRESENTATIONTYPE] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUERYCONTEXTHIDDEN
  primary key (CONTEXTID, COLUMNID)
)
;

create table RESOURCE
(
  [RESOURCENO] int not null
    constraint XPKRESOURCE
    primary key,
  [TYPE] smallint default 0 not null,
  [DESCRIPTION] nvarchar(254),
  [RESOURCE] nvarchar(254),
  [DRIVER] nvarchar(254),
  [PORT] nvarchar(254),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DELIVERYMETHOD
  add constraint R_1094
foreign key (RESOURCENO) references RESOURCE
;

alter table EMPLOYEE
  add constraint R_1093
foreign key (RESOURCENO) references RESOURCE
;

alter table FILEREQUEST
  add constraint R_1718
foreign key (RESOURCENO) references RESOURCE
;

alter table OFFICE
  add constraint R_91560
foreign key (RESOURCENO) references RESOURCE
;

create table CRRESTRICTION
(
  [CRRESTRICTIONID] int not null
    constraint XPKCRRESTRICTION
    primary key,
  [CRRESTRICTIONDESC] nvarchar(50) not null,
  [ACTIONFLAG] int not null
    constraint RI_1096
    references TABLECODES,
  [CLEARPASSWORD] nvarchar(10),
  [CRRESTRICTDESC_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1CRRESTRICTION
  on CRRESTRICTION (CRRESTRICTIONDESC)
;

create index XIE1CRRESTRICTION
  on CRRESTRICTION (ACTIONFLAG)
;

alter table CREDITORITEM
  add constraint R_1100
foreign key (RESTRICTIONID) references CRRESTRICTION
;

alter table CREDITOR
  add constraint R_1097
foreign key (RESTRICTIONID) references CRRESTRICTION
;

create table PORTAL
(
  [PORTALID] int identity
    constraint XPKPORTAL
    primary key,
  [NAME] nvarchar(50) default 'O' not null,
  [NAME_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [ISEXTERNAL] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1PORTAL
  on PORTAL (NAME)
;

alter table USERIDENTITY
  add constraint R_1154
foreign key (DEFAULTPORTALID) references PORTAL
;

alter table PORTALTAB
  add constraint R_1152
foreign key (PORTALID) references PORTAL
;

alter table PORTALTABCONFIGURATION
  add constraint R_1111
foreign key (PORTALID) references PORTAL
;

alter table MODULECONFIGURATION
  add constraint RI_1112
foreign key (PORTALID) references PORTAL
;

create table CASELIST
(
  [CASELISTNO] int not null
    constraint XPKCASELIST
    primary key,
  [CASELISTNAME] nvarchar(50) not null,
  [DESCRIPTION] nvarchar(254),
  [CASELISTNAME_TID] int,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1CASELIST
  on CASELIST (CASELISTNAME)
;

create table CASELISTMEMBER
(
  [CASELISTNO] int not null
    constraint RI_1114
    references CASELIST,
  [CASEID] int not null,
  [PRIMECASE] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASELISTMEMBER
  primary key (CASELISTNO, CASEID)
)
;

create table DATAWIZARD
(
  [WIZARDKEY] int not null
    constraint XPKDATAWIZARD
    primary key,
  [APPLICATIONNAME] nvarchar(20) not null
    constraint R_1122
    references APPLICATIONS,
  [DATASETNAME] nvarchar(20) not null,
  [WIZARDBEHAVIOUR] nvarchar(254) not null,
  [WIZARDPROCEDURE] nvarchar(50),
  [IMPORTMETHODNO] int not null
    constraint R_1179
    references IMPORTMETHOD,
  [EXPORTTEMPLATE] nvarchar(254),
  [REPORTPROCEDURE] nvarchar(50),
  [REPORTTEMPLATE] nvarchar(254),
  [DEFAULTSOURCENO] int
    constraint R_1178
    references NAME,
  [DEFAULTIMPORTFILE] nvarchar(254),
  [DEFAULTEXPORTFILE] nvarchar(254),
  [APPLICATIONNAME_TID] int,
  [DATASETNAME_TID] int,
  [WIZARDBEHAVIOUR_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DATAWIZARD
  on DATAWIZARD (APPLICATIONNAME)
;

create unique index XAK2DATAWIZARD
  on DATAWIZARD (DATASETNAME)
;

create table DATAWIZARDTRIP
(
  [WIZARDKEY] int not null
    constraint R_1123
    references DATAWIZARD,
  [TRIPNO] int not null,
  [TRIPORDER] int not null,
  [TRIPTITLE] nvarchar(40) not null,
  [TRIPTITLE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDATAWIZARDTRIP
  primary key (WIZARDKEY, TRIPNO)
)
;

create table DATAWIZARDTRIPTAB
(
  [WIZARDKEY] int not null,
  [TRIPNO] int not null,
  [TABNO] int not null,
  [TABTITLE] nvarchar(100) not null,
  [TABPROCEDURE] nvarchar(50) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDATAWIZARDTRIPTAB
  primary key (WIZARDKEY, TRIPNO, TABNO),
  constraint RI_1124
  foreign key (WIZARDKEY, TRIPNO) references DATAWIZARDTRIP
)
;

create table TAXPAIDITEM
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTCREDITORNO] int not null,
  [TAXCODE] nvarchar(3) not null
    constraint R_91900
    references taxrates,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_91417
    references COUNTRY,
  [TAXRATE] decimal(8,4),
  [TAXABLEAMOUNT] decimal(11,2),
  [TAXAMOUNT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTAXPAIDITEM
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO, TAXCODE)
)
;

create table TAXPAIDHISTORY
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTCREDITORNO] int not null,
  [HISTORYLINENO] smallint not null,
  [TAXCODE] nvarchar(3) not null
    constraint R_91899
    references taxrates,
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_91418
    references COUNTRY,
  [TAXRATE] decimal(8,4),
  [TAXABLEAMOUNT] decimal(11,2),
  [TAXAMOUNT] decimal(11,2),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTAXPAIDHISTORY
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTCREDITORNO, HISTORYLINENO, TAXCODE),
  constraint R_91763
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create table RPTTOOLEXPORTFMT
(
  [ID] int identity
    constraint XPKRPTTOOLEXPORTFMT
    primary key,
  [REPORTTOOL] int
    constraint R_1128
    references TABLECODES,
  [EXPORTFORMAT] int not null
    constraint RI_1129
    references TABLECODES,
  [USEDBYWORKBENCH] bit default 0 not null,
  [USEDBYCLIENTSERVER] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1RPTTOOLEXPORTFMT
  on RPTTOOLEXPORTFMT (REPORTTOOL)
;

create index XIE2RPTTOOLEXPORTFMT
  on RPTTOOLEXPORTFMT (EXPORTFORMAT)
;

create table ACCOUNTCASECONTACT
(
  [ACCOUNTID] int not null
    constraint R_1138
    references ACCESSACCOUNT,
  [ACCOUNTCASEID] int not null
    constraint R_1139
    references CASES,
  [CASEID] int not null,
  [NAMETYPE] nvarchar(3) not null,
  [NAMENO] int not null,
  [SEQUENCE] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKACCOUNTCASECONTACT
  primary key (ACCOUNTID, ACCOUNTCASEID)
)
;

create index XIE1ACCOUNTCASECONTACT
  on ACCOUNTCASECONTACT (ACCOUNTCASEID)
;

create table LICENSE
(
  [DATA] nvarchar(268),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table LICENSEDUSER
(
  [MODULEID] int not null,
  [USERIDENTITYID] int not null
    constraint R_1142
    references USERIDENTITY,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLICENSEDUSER
  primary key (MODULEID, USERIDENTITYID)
)
;

create table LICENSEMODULE
(
  [MODULEID] int not null
    constraint XPKLICENSEMODULE
    primary key,
  [MODULENAME] nvarchar(100) not null,
  [EXTERNALUSE] bit,
  [INTERNALUSE] bit,
  [MODULEFLAG] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table LICENSEDUSER
  add constraint R_1146
foreign key (MODULEID) references LICENSEMODULE
;

create table MODULEUSAGE
(
  [MODULEID] int not null
    constraint R_1184
    references LICENSEMODULE,
  [IDENTITYID] int not null
    constraint R_1145
    references USERIDENTITY,
  [USAGETIME] datetime not null,
  [COMPUTERIDENTIFIER] nvarchar(100) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKMODULEUSAGE
  primary key (MODULEID, IDENTITYID)
)
;

create table PORTALSETTING
(
  [SETTINGID] int identity
    constraint XPKPORTALSETTING
    primary key,
  [MODULEID] int
    constraint R_1147
    references MODULE,
  [MODULECONFIGID] int
    constraint R_1148
    references MODULECONFIGURATION,
  [IDENTITYID] int
    constraint R_1149
    references USERIDENTITY,
  [SETTINGNAME] nvarchar(50) not null,
  [SETTINGVALUE] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1PORTALSETTING
  on PORTALSETTING (MODULEID, MODULECONFIGID, IDENTITYID, SETTINGNAME)
;

create table FEATURE
(
  [FEATUREID] smallint not null
    constraint XPKFEATURE
    primary key,
  [FEATURENAME] nvarchar(50) not null,
  [FEATURENAME_TID] int,
  [CATEGORYID] int
    constraint R_1156
    references TABLECODES,
  [ISEXTERNAL] bit default 0 not null,
  [ISINTERNAL] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1FEATURE
  on FEATURE (FEATURENAME, ISEXTERNAL, ISINTERNAL)
;

create index XIE1FEATURE
  on FEATURE (CATEGORYID)
;

create table FEATUREMODULE
(
  [FEATUREID] smallint not null
    constraint R_1157
    references FEATURE,
  [MODULEID] int not null
    constraint R_1158
    references MODULE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFEATUREMODULE
  primary key (FEATUREID, MODULEID)
)
;

create table FEATURETASK
(
  [FEATUREID] smallint not null
    constraint R_1159
    references FEATURE,
  [TASKID] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFEATURETASK
  primary key (FEATUREID, TASKID)
)
;

create table QUERYPROCEDUREUSED
(
  [PROCEDURENAME] nvarchar(50) not null,
  [USESPROCEDURENAME] nvarchar(50) not null,
  [EXCLUDEFILTERNODE] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUERYPROCEDUREUSED
  primary key (PROCEDURENAME, USESPROCEDURENAME)
)
;

create table PAYMENTPLANDEFACCT
(
  [DEFAULTACCOUNTID] int not null
    constraint XPKPAYMENTPLANDEFACCT
    primary key,
  [PLANID] int not null
    constraint R_1165
    references PAYMENTPLAN,
  [CONTROLACCTYPEID] int not null
    constraint R_1166
    references TABLECODES,
  [ACCOUNTID] int not null
    constraint R_1167
    references LEDGERACCOUNT,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_1168
    references PROFITCENTRE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1PAYMENTPLANDEFACCT
  on PAYMENTPLANDEFACCT (PLANID, CONTROLACCTYPEID)
;

create index XIE1PAYMENTPLANDEFACCT
  on PAYMENTPLANDEFACCT (CONTROLACCTYPEID)
;

create table QUERYDEFAULT
(
  [DEFAULTID] int identity
    constraint XPKQUERYDEFAULT
    primary key,
  [CONTEXTID] int not null,
  [IDENTITYID] int,
  [QUERYID] int not null,
  [ACCESSACCOUNTID] int
    constraint R_91599
    references ACCESSACCOUNT,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYDEFAULT
  on QUERYDEFAULT (CONTEXTID, IDENTITYID, ACCESSACCOUNTID)
;

create table EVENTCATEGORY
(
  [CATEGORYID] smallint not null
    constraint XPKEVENTCATEGORY
    primary key,
  [CATEGORYNAME] nvarchar(50) not null,
  [CATEGORYNAME_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [ICONIMAGEID] int not null
    constraint R_1174
    references IMAGE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EVENTCATEGORY
  on EVENTCATEGORY (CATEGORYNAME)
;

alter table EVENTS
  add constraint R_1175
foreign key (CATEGORYID) references EVENTCATEGORY
;

create table DATAMAP
(
  [MAPNO] int identity
    constraint XPKDATAMAP
    primary key,
  [SOURCENO] int not null
    constraint R_1177
    references NAME,
  [SOURCEVALUE] nvarchar(50) not null,
  [MAPTABLE] nvarchar(50) not null,
  [MAPCOLUMN] nvarchar(50) not null,
  [MAPVALUE] nvarchar(50) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DATAMAP
  on DATAMAP (SOURCENO, SOURCEVALUE, MAPTABLE, MAPCOLUMN)
;

create table QUERYLINE
(
  [LINEID] int not null
    constraint XPKQUERYLINE
    primary key,
  [QUERYID] int not null
    constraint R_1193
    references QUERY,
  [FILTERID] int
    constraint R_1194
    references QUERYFILTER,
  [LABEL] nvarchar(20) not null,
  [LABEL_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [ALIGNDESCRIPTION] nchar(1) not null,
  [LINEPOSITION] int not null,
  [ISPRINTABLE] decimal(1),
  [LINETYPE] int
    constraint R_1197
    references TABLECODES,
  [FONTNAME] nvarchar(50),
  [FONTSIZE] int,
  [BOLDSTYLE] decimal(1),
  [ITALICSTYLE] decimal(1),
  [UNDERLINESTYLE] int,
  [SHOWCURRENCYSYMBOL] decimal(1),
  [NEGATIVESIGNTYPE] int,
  [NEGATIVESIGNCOLOUR] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYLINE
  on QUERYLINE (QUERYID, LABEL)
;

create index XIE1QUERYLINE
  on QUERYLINE (LINETYPE)
;

create table QUERYLINETOTAL
(
  [LINEID] int not null
    constraint RI_1198
    references QUERYLINE,
  [TOTALLINEID] int not null
    constraint R_1199
    references QUERYLINE,
  [TOTALSIGN] nchar(1),
  [POSITION] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKQUERYLINETOTAL
  primary key (LINEID, TOTALLINEID)
)
;

create table CULTURE
(
  [CULTURE] nvarchar(10) not null
    constraint XPKCULTURE
    primary key,
  [DESCRIPTION] nvarchar(50) not null,
  [DESCRIPTION_TID] int,
  [ISTRANSLATED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table CULTURECODEPAGE
(
  [CODEPAGE] smallint not null,
  [CULTURE] nvarchar(10) not null
    constraint RI_1208
    references CULTURE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCULTURECODEPAGE
  primary key (CODEPAGE, CULTURE)
)
;

create table ROLE
(
  [ROLEID] int identity
    constraint XPKROLE
    primary key,
  [ROLENAME] nvarchar(254),
  [DESCRIPTION] nvarchar(1000),
  [DESCRIPTION_TID] int,
  [ROLENAME_TID] int,
  [ISEXTERNAL] bit default 0,
  [DEFAULTPORTALID] int
    constraint R_1110
    references PORTAL,
  [ISPROTECTED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ROLE
  on ROLE (ROLENAME)
;

alter table IDENTITYROLES
  add constraint R_69
foreign key (ROLEID) references ROLE
;

alter table ROLETASKS
  add constraint R_73
foreign key (ROLEID) references ROLE
;

alter table ROLETOPICS
  add constraint R_1061
foreign key (ROLEID) references ROLE
;

create table NAMEVARIANT
(
  [NAMEVARIANTNO] int not null
    constraint XPKNAMEVARIANT
    primary key,
  [NAMENO] int not null
    constraint RI_1244
    references NAME,
  [NAMEVARIANT] nvarchar(254) not null,
  [FIRSTNAMEVARIANT] nvarchar(50),
  [VARIANTREASON] int
    constraint RI_1245
    references TABLECODES,
  [PROPERTYTYPE] nchar(1),
  [DISPLAYSEQUENCENO] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1NAMEVARIANT
  on NAMEVARIANT (NAMEVARIANT)
;

create index XIE2NAMEVARIANT
  on NAMEVARIANT (VARIANTREASON)
;

alter table CASENAME
  add constraint RI_1246
foreign key (NAMEVARIANTNO) references NAMEVARIANT
;

create table TRANSLATEDTEXT
(
  [TID] int not null
    constraint R_86
    references TRANSLATEDITEMS,
  [CULTURE] nvarchar(10) not null
    constraint R_1206
    references CULTURE,
  [SHORTTEXT] nvarchar(3900),
  [LONGTEXT] ntext,
  [HASSOURCECHANGED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRANSLATEDTEXT
  primary key (TID, CULTURE)
)
;

create unique index XAK1TRANSLATEDTEXT
  on TRANSLATEDTEXT (CULTURE, TID)
;

create table EFTDETAIL
(
  [ACCOUNTOWNER] int not null,
  [BANKNAMENO] int not null,
  [SEQUENCENO] int not null,
  [BANKCODE] nvarchar(4),
  [COUNTRYCODE] nvarchar(2),
  [LOCATIONCODE] nvarchar(2),
  [BRANCHCODE] nvarchar(3),
  [BANKOPERATIONCODE] int
    constraint R_1253
    references TABLECODES,
  [DETAILSOFCHARGES] int
    constraint R_1254
    references TABLECODES,
  [FILEFORMATUSED] int,
  [ALIAS] nvarchar(16),
  [USERREFNO] nvarchar(6),
  [APPLICATIONID] nvarchar(9),
  [FORMATFILE] nvarchar(254),
  [SQLTEMPLATE] nvarchar(254),
  [PAYMENTREFPREFIX] nvarchar(8),
  [LASTPAYMENTREFNO] int,
  [SELFBALANCING] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEFTDETAIL
  primary key (ACCOUNTOWNER, BANKNAMENO, SEQUENCENO),
  constraint R_1252
  foreign key (ACCOUNTOWNER, BANKNAMENO, SEQUENCENO) references BANKACCOUNT
)
;

create index XIE1EFTDETAIL
  on EFTDETAIL (BANKOPERATIONCODE)
;

create index XIE2EFTDETAIL
  on EFTDETAIL (DETAILSOFCHARGES)
;

create table EVENTCONTROL
(
  [CRITERIANO] int not null
    constraint R_20066
    references CRITERIA,
  [EVENTNO] int not null
    constraint R_20087
    references EVENTS,
  [EVENTDESCRIPTION] nvarchar(100),
  [DISPLAYSEQUENCE] smallint,
  [PARENTCRITERIANO] int,
  [PARENTEVENTNO] int,
  [NUMCYCLESALLOWED] smallint,
  [IMPORTANCELEVEL] nvarchar(2)
    constraint RI_1008
    references IMPORTANCE,
  [WHICHDUEDATE] nchar(1),
  [COMPAREBOOLEAN] decimal(1),
  [CHECKCOUNTRYFLAG] int,
  [SAVEDUEDATE] smallint default 0,
  [STATUSCODE] smallint
    constraint R_472
    references STATUS,
  [SPECIALFUNCTION] nchar(1),
  [INITIALFEE] int,
  [PAYFEECODE] nchar(1),
  [CREATEACTION] nvarchar(2)
    constraint R_20008
    references ACTIONS,
  [STATUSDESC] nvarchar(50),
  [CLOSEACTION] nvarchar(2)
    constraint R_20001
    references ACTIONS,
  [UPDATEFROMEVENT] int
    constraint R_20091
    references EVENTS,
  [FROMRELATIONSHIP] nvarchar(3)
    constraint R_679
    references CASERELATION,
  [FROMANCESTOR] decimal(1) default 0,
  [UPDATEMANUALLY] decimal(1) default 0,
  [ADJUSTMENT] nvarchar(4)
    constraint R_20017
    references ADJUSTMENT,
  [DOCUMENTNO] smallint
    constraint R_887
    references DOCUMENT,
  [NOOFDOCS] smallint,
  [MANDATORYDOCS] smallint,
  [NOTES] ntext,
  [INHERITED] decimal(1) default 0,
  [INSTRUCTIONTYPE] nvarchar(3),
  [FLAGNUMBER] smallint,
  [SETTHIRDPARTYON] decimal(1) default 0,
  [RELATIVECYCLE] smallint default 0,
  [CREATECYCLE] smallint,
  [ESTIMATEFLAG] decimal(1),
  [EXTENDPERIOD] smallint,
  [EXTENDPERIODTYPE] nchar(1),
  [INITIALFEE2] int,
  [PAYFEECODE2] nchar(1),
  [ESTIMATEFLAG2] decimal(1),
  [EVENTDESCRIPTION_TID] int,
  [NOTES_TID] int,
  [STATUSDESC_TID] int,
  [PTADELAY] smallint,
  [SETTHIRDPARTYOFF] bit,
  [RECEIVINGCYCLEFLAG] bit,
  [RECALCEVENTDATE] bit default 0,
  [CHANGENAMETYPE] nvarchar(3)
    constraint R_91649
    references NAMETYPE,
  [COPYFROMNAMETYPE] nvarchar(3)
    constraint R_91650
    references NAMETYPE,
  [COPYTONAMETYPE] nvarchar(3)
    constraint R_91651
    references NAMETYPE,
  [DELCOPYFROMNAME] bit,
  [CASETYPE] nchar(1)
    constraint R_91753
    references CASETYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91755
    references COUNTRY,
  [COUNTRYCODEISTHISCASE] bit,
  [PROPERTYTYPE] nchar(1)
    constraint R_91756
    references PROPERTYTYPE,
  [PROPERTYTYPEISTHISCASE] bit,
  [CASECATEGORY] nvarchar(2),
  [CATEGORYISTHISCASE] bit,
  [SUBTYPE] nvarchar(2)
    constraint R_91757
    references SUBTYPE,
  [SUBTYPEISTHISCASE] bit,
  [BASIS] nvarchar(2),
  [BASISISTHISCASE] bit,
  [DIRECTPAYFLAG] bit,
  [DIRECTPAYFLAG2] bit,
  [OFFICEID] int
    constraint R_91776
    references OFFICE,
  [OFFICEIDISTHISCASE] bit,
  [DUEDATERESPNAMETYPE] nvarchar(3)
    constraint R_91431
    references NAMETYPE,
  [DUEDATERESPNAMENO] int
    constraint R_91432
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [LOADNUMBERTYPE] nchar(1)
    constraint R_81587
    references NUMBERTYPES,
  constraint XPKEVENTCONTROL
  primary key (CRITERIANO, EVENTNO),
  constraint RI_1123
  foreign key (INSTRUCTIONTYPE, FLAGNUMBER) references INSTRUCTIONLABEL
)
;

create index XIE1EVENTCONTROL
  on EVENTCONTROL (UPDATEFROMEVENT, UPDATEMANUALLY, CRITERIANO)
;

create index XIE3EVENTCONTROL
  on EVENTCONTROL (PARENTEVENTNO, PARENTCRITERIANO)
;

create index XIE4EVENTCONTROL
  on EVENTCONTROL (INSTRUCTIONTYPE, FLAGNUMBER)
;

create index XIE100EVENTCONTROL
  on EVENTCONTROL (EVENTNO, CRITERIANO, UPDATEFROMEVENT, FROMRELATIONSHIP, FROMANCESTOR, ADJUSTMENT, INSTRUCTIONTYPE, FLAGNUMBER)
;

alter table CRITERIACHANGES
  add constraint RI_1029
foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
;

alter table DUEDATECALC
  add constraint R_978
foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
;

alter table RELATEDEVENTS
  add constraint R_1072
foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
;

create table TMCLASS
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint R_20055
    references COUNTRY,
  [CLASS] nvarchar(5) not null,
  [EFFECTIVEDATE] datetime,
  [GOODSSERVICES] nchar(1),
  [INTERNATIONALCLASS] nvarchar(254),
  [ASSOCIATEDCLASSES] nvarchar(254),
  [CLASSHEADING] ntext,
  [CLASSNOTES] ntext,
  [PROPERTYTYPE] nchar(1) default 'T' not null,
  [SEQUENCENO] int default 0 not null,
  [SUBCLASS] nvarchar(5),
  [CLASSHEADING_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTMCLASS
  primary key (COUNTRYCODE, CLASS, PROPERTYTYPE, SEQUENCENO)
)
;

create table NAMETEXT
(
  [NAMENO] int not null
    constraint R_971
    references NAME,
  [TEXTTYPE] nvarchar(2) not null
    constraint RI_1055
    references TEXTTYPE,
  [TEXT] ntext,
  [TEXT_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMETEXT
  primary key (NAMENO, TEXTTYPE)
)
;

create index XIE1NAMETEXT
  on NAMETEXT (TEXTTYPE)
;

create table LINK
(
  [LINKID] int identity
    constraint XPKLINK
    primary key,
  [URL] nvarchar(254) not null,
  [TITLE] nvarchar(100) not null,
  [TITLE_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [DISPLAYSEQUENCE] smallint not null,
  [CATEGORYID] int not null
    constraint RI_1257
    references TABLECODES,
  [IDENTITYID] int
    constraint R_1258
    references USERIDENTITY,
  [ACCESSACCOUNTID] int
    constraint R_1259
    references ACCESSACCOUNT,
  [ISEXTERNAL] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1LINK
  on LINK (TITLE, CATEGORYID, IDENTITYID, ACCESSACCOUNTID, ISEXTERNAL)
;

create unique index XAK2LINK
  on LINK (DISPLAYSEQUENCE, CATEGORYID, IDENTITYID, ACCESSACCOUNTID, ISEXTERNAL)
;

create index XIE1LINK
  on LINK (CATEGORYID)
;

create table TASK
(
  [TASKID] smallint not null
    constraint XPKTASK
    primary key,
  [TASKNAME] nvarchar(254) not null,
  [DESCRIPTION] nvarchar(1000),
  [DESCRIPTION_TID] int,
  [TASKNAME_TID] int,
  [CANIMPERSONATE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table IDENTITYTASKS
  add constraint R_72
foreign key (TASKID) references TASK
;

alter table ROLETASKS
  add constraint R_74
foreign key (TASKID) references TASK
;

alter table FEATURETASK
  add constraint R_1160
foreign key (TASKID) references TASK
;

create table QUERYCONTEXT
(
  [CONTEXTID] int not null
    constraint XPKQUERYCONTEXT
    primary key,
  [CONTEXTNAME] nvarchar(50) not null,
  [CONTEXTNAME_TID] int,
  [PROCEDURENAME] nvarchar(50),
  [NOTES] nvarchar(254),
  [NOTES_TID] int,
  [FILTERXSLTTODB] nvarchar(254),
  [FILTERXSLTFROMDB] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table QUERYCOLUMNGROUP
  add constraint R_1041
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYCONTEXTCOLUMN
  add constraint R_1043
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYPRESENTATION
  add constraint R_1046
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYGROUP
  add constraint R_1048
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERY
  add constraint R_1050
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYIMPLIEDDATA
  add constraint R_1066
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYCONTEXTHIDDEN
  add constraint R_1088
foreign key (CONTEXTID) references QUERYCONTEXT
;

alter table QUERYDEFAULT
  add constraint RI_1169
foreign key (CONTEXTID) references QUERYCONTEXT
;

create table VALIDOBJECT
(
  [OBJECTID] int not null,
  [TYPE] int not null,
  [OBJECTDATA] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDOBJECT
  primary key (OBJECTID, TYPE)
)
;

create table LICENSEDACCOUNT
(
  [MODULEID] int not null
    constraint R_1263
    references LICENSEMODULE,
  [ACCOUNTID] int not null
    constraint R_1264
    references ACCESSACCOUNT,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLICENSEDACCOUNT
  primary key (MODULEID, ACCOUNTID)
)
;

create table LEDGERJOURNALLINEBALANCE
(
  [ACCTENTITYNO] int not null
    constraint R_91460
    references SPECIALNAME,
  [PROFITCENTRECODE] nvarchar(6) not null
    constraint R_91461
    references PROFITCENTRE,
  [ACCOUNTID] int not null
    constraint R_91462
    references LEDGERACCOUNT,
  [TRANPOSTPERIOD] int not null
    constraint R_91463
    references PERIOD,
  [LOCALAMOUNTBALANCE] decimal(13,2) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLEDGERJOURNALLINEBALANCE
  primary key (ACCTENTITYNO, PROFITCENTRECODE, ACCOUNTID, TRANPOSTPERIOD)
)
;

create index XIE1LEDGERJOURNALLINEBALANCE
  on LEDGERJOURNALLINEBALANCE (ACCTENTITYNO)
;

create index XIE2LEDGERJOURNALLINEBALANCE
  on LEDGERJOURNALLINEBALANCE (PROFITCENTRECODE)
;

create index XIE3LEDGERJOURNALLINEBALANCE
  on LEDGERJOURNALLINEBALANCE (ACCOUNTID)
;

create index XIE4LEDGERJOURNALLINEBALANCE
  on LEDGERJOURNALLINEBALANCE (TRANPOSTPERIOD)
;

create table OPENITEMBREAKDOWN
(
  [BREAKDOWNID] int identity
    constraint XPKOPENITEMBREAKDOWN
    primary key,
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [CASEID] int
    constraint R_91465
    references CASES,
  [RENEWALTOTAL] decimal(11,2) default 0 not null,
  [NONRENEWALTOTAL] decimal(11,2) default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1OPENITEMBREAKDOWN
  on OPENITEMBREAKDOWN (CASEID)
;

create table BATCHTYPERULES
(
  [BATCHTYPERULENO] int identity
    constraint XPKBATCHTYPERULES
    primary key,
  [BATCHTYPE] int not null
    constraint R_91468
    references TABLECODES,
  [FROMNAMENO] int
    constraint R_91469
    references NAME,
  [HEADERCASETYPE] nchar(1)
    constraint R_91470
    references CASETYPE,
  [HEADERCOUNTRY] nvarchar(3)
    constraint R_91471
    references COUNTRY,
  [HEADERPROPERTY] nchar(1)
    constraint R_91472
    references PROPERTYTYPE,
  [HEADERCATEGORY] nchar(1),
  [HEADERSUBTYPE] nvarchar(2)
    constraint R_91474
    references SUBTYPE,
  [HEADERBASIS] nvarchar(2)
    constraint R_91475
    references APPLICATIONBASIS,
  [HEADERTITLE] nvarchar(100),
  [HEADERACTION] nvarchar(2)
    constraint R_91476
    references ACTIONS,
  [HEADERINSTRUCTOR] int
    constraint R_91477
    references NAME,
  [HEADERSTAFFNAME] int
    constraint R_91478
    references NAME,
  [RELATETOVALIDCASE] nvarchar(3)
    constraint R_91479
    references CASERELATION,
  [RELATETOREJECT] nvarchar(3)
    constraint R_91480
    references CASERELATION,
  [INHERITTOHEADER] bit,
  [INHERITTOVALIDCASE] bit,
  [INHERITTOREJECT] bit,
  [PROGRAMID] nvarchar(8)
    constraint R_91481
    references PROGRAM,
  [IMPORTEDCASETYPE] nchar(1)
    constraint R_91482
    references CASETYPE,
  [IMPORTEDCOUNTRY] nvarchar(3)
    constraint R_91483
    references COUNTRY,
  [IMPORTEDPROPERTY] nchar(1)
    constraint R_91484
    references PROPERTYTYPE,
  [IMPORTEDCATEGORY] nchar(1),
  [IMPORTEDSUBTYPE] nvarchar(2)
    constraint R_91485
    references SUBTYPE,
  [IMPORTEDBASIS] nvarchar(2)
    constraint R_91486
    references APPLICATIONBASIS,
  [IMPORTEDACTION] nvarchar(2)
    constraint R_91489
    references ACTIONS,
  [IMPORTEDINSTRUCTOR] int
    constraint R_91487
    references NAME,
  [IMPORTEDSTAFFNAME] int
    constraint R_91488
    references NAME,
  [REJECTEDCASETYPE] nchar(1)
    constraint R_91490
    references CASETYPE,
  [REJECTEDCOUNTRY] nvarchar(3)
    constraint R_91491
    references COUNTRY,
  [REJECTEDPROPERTY] nchar(1)
    constraint R_91492
    references PROPERTYTYPE,
  [REJECTEDCATEGORY] nchar(1),
  [REJECTEDSUBTYPE] nvarchar(2)
    constraint R_91493
    references SUBTYPE,
  [REJECTEDBASIS] nvarchar(2)
    constraint R_91494
    references APPLICATIONBASIS,
  [REJECTEDACTION] nvarchar(2)
    constraint R_91495
    references ACTIONS,
  [REJECTEDINSTRUCTOR] int
    constraint R_91496
    references NAME,
  [REJECTEDSTAFFNAME] int
    constraint R_91497
    references NAME,
  [SEARCHCASETYPE1] nchar(1)
    constraint R_91498
    references CASETYPE,
  [SEARCHCASETYPE2] nchar(1)
    constraint R_91499
    references CASETYPE,
  [INSTRUCTORNAMETYPE] nvarchar(3)
    constraint R_91500
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1BATCHTYPERULES
  on BATCHTYPERULES (BATCHTYPE)
;

create index XIE2BATCHTYPERULES
  on BATCHTYPERULES (FROMNAMENO)
;

create table VALIDBASISEX
(
  [COUNTRYCODE] nvarchar(3) not null,
  [PROPERTYTYPE] nchar(1) not null,
  [CASECATEGORY] nvarchar(2) not null,
  [CASETYPE] nchar(1) not null,
  [BASIS] nvarchar(2) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDBASISEX
  primary key (COUNTRYCODE, PROPERTYTYPE, CASECATEGORY, CASETYPE, BASIS),
  constraint R_91502
  foreign key (COUNTRYCODE, PROPERTYTYPE, BASIS) references VALIDBASIS,
  constraint R_91503
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create table DOCUMENT_CRITERIA
(
  [CRITERIA_ID] int not null,
  [DOCUMENT_ID] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDocument_Criteria
  primary key (CRITERIA_ID, DOCUMENT_ID)
)
;

create table GROUPS
(
  [GROUP_CODE] int not null
    constraint XPKItem_Groups
    primary key,
  [GROUP_NAME] nvarchar(40) not null,
  [GROUP_NAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ITEM_GROUP
(
  [GROUP_CODE] int not null
    constraint R_26
    references GROUPS,
  [ITEM_ID] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKItem_Group
  primary key (GROUP_CODE, ITEM_ID)
)
;

create table SUBJECT
(
  [SUBJECTCODE] int not null
    constraint XPKSubject
    primary key,
  [SUBJECTNAME] nvarchar(100) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table QUERYFILTERITEM
(
  [FILTERITEMID] int not null
    constraint XPKQUERYFILTERITEM
    primary key,
  [RECORDTYPE] nvarchar(20) not null,
  [ITEMNAME] nvarchar(50) not null,
  [QUALIFIERTYPE] smallint,
  [DESCRIPTION] nvarchar(254) not null,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1QUERYFILTERITEM
  on QUERYFILTERITEM (RECORDTYPE, ITEMNAME)
;

create table QUERYFILTERFIELD
(
  [FILTERFIELDID] int identity
    constraint XPKQUERYFILTERFIELD
    primary key,
  [FILTERITEMID] int not null
    constraint R_91512
    references QUERYFILTERITEM,
  [QUALIFIER] nvarchar(20),
  [FIELDNAME] nvarchar(50) not null,
  [DESCRIPTION] nvarchar(254) not null,
  [DESCRIPTION_TID] int,
  [ISMANDATORY] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table SUBJECTAREA
(
  [SUBJECTAREANO] int not null
    constraint XPKSUBJECTAREA
    primary key,
  [PARENTTABLE] nvarchar(30),
  [SUBJECTAREADESC] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ACTIVITY
(
  [ACTIVITYNO] int not null
    constraint XPKACTIVITY
    primary key,
  [NAMENO] int
    constraint R_30001
    references NAME,
  [ACTIVITYDATE] datetime,
  [EMPLOYEENO] int
    constraint R_177
    references NAME,
  [CALLER] int
    constraint R_176
    references NAME,
  [RELATEDNAME] int,
  [CASEID] int
    constraint R_1367
    references CASES,
  [REFERREDTO] int
    constraint R_175
    references NAME,
  [INCOMPLETE] decimal(1) not null,
  [SUMMARY] nvarchar(254) not null,
  [CALLTYPE] decimal(1),
  [CALLSTATUS] smallint,
  [ACTIVITYCATEGORY] int not null
    constraint R_1369
    references TABLECODES,
  [ACTIVITYTYPE] int not null
    constraint R_1370
    references TABLECODES,
  [ACTIVITYSTART] datetime,
  [ACTIVITYFINISH] datetime,
  [ACTIVITYDURATION] datetime,
  [LONGFLAG] decimal(1),
  [REFERENCENO] nvarchar(20),
  [NOTES] nvarchar(254),
  [LONGNOTES] ntext,
  [NOTES_TID] int,
  [SUMMARY_TID] int,
  [USERIDENTITYID] int,
  [CLIENTREFERENCE] nvarchar(50),
  [PRIORARTID] int
    constraint R_91437
    references SEARCHRESULTS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1ACTIVITY
  on ACTIVITY (EMPLOYEENO, INCOMPLETE)
;

create index XIE2ACTIVITY
  on ACTIVITY (CASEID)
;

create index XIE3ACTIVITY
  on ACTIVITY (NAMENO)
;

create index XIE4ACTIVITY
  on ACTIVITY (RELATEDNAME)
;

create index XIE5ACTIVITY
  on ACTIVITY (CALLER)
;

create index XIE6ACTIVITY
  on ACTIVITY (REFERREDTO)
;

create index XIE7ACTIVITY
  on ACTIVITY (ACTIVITYCATEGORY)
;

create index XIE8ACTIVITY
  on ACTIVITY (ACTIVITYTYPE)
;

alter table ACTIVITYATTACHMENT
  add constraint R_1371
foreign key (ACTIVITYNO) references ACTIVITY
;

create table BILLLINE
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ITEMLINENO] smallint not null,
  [PRINTCHARGECURRNCY] nvarchar(3)
    constraint R_1613
    references CURRENCY,
  [WIPCODE] nvarchar(6)
    constraint R_1408
    references WIPTEMPLATE,
  [WIPTYPEID] nvarchar(6)
    constraint R_1407
    references WIPTYPE,
  [CATEGORYCODE] nvarchar(3)
    constraint R_1406
    references WIPCATEGORY,
  [IRN] nvarchar(30),
  [VALUE] decimal(11,2),
  [DISPLAYSEQUENCE] smallint,
  [PRINTDATE] datetime,
  [PRINTNAME] nvarchar(60),
  [PRINTCHARGEOUTRATE] decimal(11,2),
  [PRINTTOTALUNITS] smallint,
  [UNITSPERHOUR] smallint,
  [NARRATIVENO] smallint,
  [SHORTNARRATIVE] nvarchar(254),
  [LONGNARRATIVE] ntext,
  [FOREIGNVALUE] decimal(11,2),
  [NARRATIVE_TID] int,
  [PRINTTIME] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [LOCALTAX] decimal(11,2),
  [GENERATEDFROMTAXCODE] nvarchar(3)
    constraint R_81741
    references taxrates,
  [ISHIDDENFORDRAFT] bit default 0,
  constraint XPKDEBITNOTELINE
  primary key (ITEMENTITYNO, ITEMTRANSNO, ITEMLINENO)
)
;

alter table BILLEDITEM
  add constraint RI_1259
foreign key (ITEMENTITYNO, ITEMTRANSNO, ITEMLINENO) references BILLLINE
;

create table CASECHECKLIST
(
  [CASEID] int not null
    constraint R_20029
    references CASES,
  [QUESTIONNO] smallint not null
    constraint RI_1092
    references QUESTION,
  [CHECKLISTTYPE] smallint not null
    constraint RI_1094
    references CHECKLISTS,
  [CRITERIANO] int
    constraint R_1505
    references CRITERIA,
  [TABLECODE] int
    constraint R_937
    references TABLECODES,
  [YESNOANSWER] decimal(1),
  [COUNTANSWER] int,
  [VALUEANSWER] decimal(11,2),
  [CHECKLISTTEXT] ntext,
  [EMPLOYEENO] int
    constraint R_181
    references NAME,
  [PROCESSEDFLAG] decimal(1),
  [PRODUCTCODE] int
    constraint R_1269
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASECHECKLIST
  primary key (CASEID, QUESTIONNO)
)
;

create index XIE1CASECHECKLIST
  on CASECHECKLIST (PRODUCTCODE)
;

create index XIE2CASECHECKLIST
  on CASECHECKLIST (TABLECODE)
;

create table CASEEVENT
(
  [CASEID] int not null
    constraint R_20024
    references CASES,
  [EVENTNO] int not null
    constraint R_20090
    references EVENTS,
  [CYCLE] smallint not null,
  [EVENTDATE] datetime,
  [EVENTDUEDATE] datetime,
  [DATEREMIND] datetime,
  [DATEDUESAVED] decimal(1) default 0,
  [OCCURREDFLAG] decimal(1),
  [CREATEDBYACTION] nvarchar(2)
    constraint R_20006
    references ACTIONS,
  [CREATEDBYCRITERIA] int
    constraint R_1334
    references CRITERIA,
  [ENTEREDDEADLINE] int,
  [PERIODTYPE] nchar(1),
  [DOCUMENTNO] smallint
    constraint R_888
    references DOCUMENT,
  [DOCSREQUIRED] smallint,
  [DOCSRECEIVED] smallint,
  [USEMESSAGE2FLAG] decimal(1),
  [GOVERNINGEVENTNO] int,
  [EVENTTEXT] nvarchar(254),
  [LONGFLAG] decimal(1),
  [EVENTLONGTEXT] ntext,
  [JOURNALNO] nvarchar(20),
  [IMPORTBATCHNO] int,
  [EVENTTEXT_TID] int,
  [EMPLOYEENO] int
    constraint R_1276
    references NAME,
  [SENDMETHOD] int
    constraint RI_1277
    references TABLECODES,
  [SENTDATE] datetime,
  [RECEIPTDATE] datetime,
  [RECEIPTREFERENCE] nvarchar(50),
  [DISPLAYORDER] smallint,
  [FROMCASEID] int
    constraint R_91751
    references CASES,
  [DUEDATERESPNAMETYPE] nvarchar(3)
    constraint R_91433
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEEVENT
  primary key (CASEID, EVENTNO, CYCLE)
)
;

create index XIE1CASEEVENT
  on CASEEVENT (EVENTNO, EVENTDATE, EVENTDUEDATE, CREATEDBYCRITERIA)
;

create index XIE2CASEEVENT
  on CASEEVENT (DATEREMIND)
;

create index XIE3CASEEVENT
  on CASEEVENT (EVENTDUEDATE)
;

create index XIE4CASEEVENT
  on CASEEVENT (EVENTNO, OCCURREDFLAG, EVENTDUEDATE, CREATEDBYCRITERIA)
;

create index XIE5CASEEVENT
  on CASEEVENT (EMPLOYEENO)
;

create index XIE6CASEEVENT
  on CASEEVENT (FROMCASEID)
;

create index XIE7CASEEVENT
  on CASEEVENT (SENDMETHOD)
;

create index XIE8CASEEVENT
  on CASEEVENT (CREATEDBYCRITERIA)
;

alter table ALERT
  add constraint R_79
foreign key (FROMCASEID, EVENTNO, CYCLE) references CASEEVENT
;

create table CASESTATUS
(
  [CASEID] int not null
    constraint XPKCASESTATUS
    primary key
    constraint RI_952
    references CASES,
  [ATTORNEYMODIFIED] nvarchar(24),
  [CLIENTMODIFIED] nvarchar(24),
  [ATTORNEYMODDATE] datetime,
  [CLIENTMODDATE] datetime,
  [ATTORNEYSHORTCOM] nvarchar(254),
  [CLIENTSHORTCOM] nvarchar(254),
  [ATTORNEYLONGCOM] ntext,
  [CLIENTLONGCOM] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table CASETEXT
(
  [CASEID] int not null
    constraint R_20028
    references CASES,
  [TEXTTYPE] nvarchar(2) not null
    constraint R_707
    references TEXTTYPE,
  [TEXTNO] smallint not null,
  [CLASS] nvarchar(100),
  [LANGUAGE] int
    constraint RI_942
    references TABLECODES,
  [MODIFIEDDATE] datetime,
  [LONGFLAG] decimal(1),
  [SHORTTEXT] nvarchar(254),
  [TEXT] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [SHORTTEXT_TID] int,
  [TEXT_TID] int,
  constraint XPKCASETEXT
  primary key (CASEID, TEXTTYPE, TEXTNO)
)
;

create index XIE1CASETEXT
  on CASETEXT (CLASS)
;

create index XIE2CASETEXT
  on CASETEXT (LANGUAGE)
;

create table COSTTRACKLINE
(
  [COSTID] int not null
    constraint R_1494
    references COSTTRACK,
  [COSTLINENO] smallint not null,
  [CASEID] int not null
    constraint R_1495
    references CASES,
  [WIPCODE] nvarchar(6) not null
    constraint R_1497
    references WIPTEMPLATE,
  [LOCALAMT] decimal(11,2) not null,
  [CURRENCY] nvarchar(3),
  [FOREIGNAMT] decimal(11,2),
  [FOREIGNAGENTNO] int
    constraint R_1498
    references NAME,
  [FAMILY] nvarchar(20)
    constraint R_1496
    references CASEFAMILY,
  [DIVISIONNO] int
    constraint R_1499
    references NAME,
  [SHORTNARRATIVE] nvarchar(254),
  [LONGNARRATIVE] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCOSTTRACKLINE
  primary key (COSTID, COSTLINENO)
)
;

create index XIE1COSTTRACKLINE
  on COSTTRACKLINE (CASEID)
;

create table COUNTRYTEXT
(
  [COUNTRYCODE] nvarchar(3) not null
    constraint RI_954
    references COUNTRY,
  [TEXTID] int not null
    constraint RI_924
    references TABLECODES,
  [SEQUENCE] smallint not null,
  [PROPERTYTYPE] nchar(1)
    constraint RI_953
    references PROPERTYTYPE,
  [MODIFIEDDATE] datetime,
  [LANGUAGE] int
    constraint RI_1130
    references TABLECODES,
  [USEFLAG] smallint,
  [COUNTRYTEXT] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCOUNTRYTEXT
  primary key (COUNTRYCODE, TEXTID, SEQUENCE)
)
;

create index XIE1COUNTRYTEXT
  on COUNTRYTEXT (LANGUAGE)
;

create index XIE2COUNTRYTEXT
  on COUNTRYTEXT (TEXTID)
;

create table CRITERIA_ITEMS
(
  [CRITERIA_ID] int not null
    constraint XPKCriteria_Items
    primary key,
  [DESCRIPTION] nvarchar(50),
  [QUERY] ntext,
  [CELL1] nvarchar(50),
  [LITERAL1] nvarchar(50),
  [CELL2] nvarchar(50),
  [LITERAL2] nvarchar(50),
  [CELL3] nvarchar(50),
  [LITERAL3] nvarchar(50),
  [CELL4] nvarchar(50),
  [LITERAL4] nvarchar(50),
  [CELL5] nvarchar(50),
  [LITERAL5] nvarchar(50),
  [CELL6] nvarchar(50),
  [LITERAL6] nvarchar(50),
  [BACKLINK] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DOCUMENT_CRITERIA
  add constraint R_4A
foreign key (CRITERIA_ID) references CRITERIA_ITEMS
;

create table DEBTORHISTORY
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [HISTORYLINENO] smallint not null,
  [OPENITEMNO] nvarchar(12),
  [TRANSDATE] datetime,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [TRANSTYPE] smallint,
  [MOVEMENTCLASS] smallint,
  [COMMANDID] smallint,
  [ITEMPRETAXVALUE] decimal(11,2),
  [LOCALTAXAMT] decimal(11,2),
  [LOCALVALUE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [FOREIGNTAXAMT] decimal(11,2),
  [FOREIGNTRANVALUE] decimal(11,2),
  [REFERENCETEXT] nvarchar(254),
  [REASONCODE] nvarchar(2)
    constraint RI_1272
    references REASON,
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [REFSEQNO] int,
  [REFACCTENTITYNO] int,
  [REFACCTDEBTORNO] int,
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [TOTALEXCHVARIANCE] decimal(11,2),
  [FORCEDPAYOUT] decimal(1),
  [CURRENCY] nvarchar(3)
    constraint R_1249
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [STATUS] smallint,
  [ASSOCLINENO] smallint,
  [ITEMIMPACT] smallint,
  [LONGREFTEXT] ntext,
  [GLMOVEMENTNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDEBTORHISTORY
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, HISTORYLINENO),
  constraint R_1621
  foreign key (ITEMENTITYNO, ITEMTRANSNO) references TRANSACTIONHEADER,
  constraint R_30003
  foreign key (ACCTENTITYNO, ACCTDEBTORNO) references ACCOUNT,
  constraint R_1622
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create index XIE1DEBTORHISTORY
  on DEBTORHISTORY (ITEMENTITYNO, OPENITEMNO)
;

create index XIE2DEBTORHISTORY
  on DEBTORHISTORY (REFENTITYNO, REFTRANSNO, REFSEQNO)
;

create index XIE3DEBTORHISTORY
  on DEBTORHISTORY (ITEMENTITYNO, POSTPERIOD)
;

create index XIE4DEBTORHISTORY
  on DEBTORHISTORY (ACCTENTITYNO, ACCTDEBTORNO, POSTPERIOD)
;

create index XIE5DEBTORHISTORY
  on DEBTORHISTORY (MOVEMENTCLASS, POSTPERIOD, POSTDATE, LOCALVALUE)
;

create index XIE6DEBTORHISTORY
  on DEBTORHISTORY (ACCTDEBTORNO)
;

alter table TAXHISTORY
  add constraint R_1270
foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, HISTORYLINENO) references DEBTORHISTORY
;

alter table DEBTORHISTORYCASE
  add constraint R_53
foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, HISTORYLINENO) references DEBTORHISTORY
;

create table DIARY
(
  [EMPLOYEENO] int not null
    constraint R_183
    references NAME,
  [ENTRYNO] int not null,
  [ACTIVITY] nvarchar(6)
    constraint R_1289
    references WIPTEMPLATE,
  [CASEID] int
    constraint R_1288
    references CASES,
  [NAMENO] int
    constraint R_1287
    references NAME,
  [STARTTIME] datetime,
  [FINISHTIME] datetime,
  [TOTALTIME] datetime,
  [TOTALUNITS] smallint,
  [TIMECARRIEDFORWARD] datetime,
  [UNITSPERHOUR] smallint,
  [TIMEVALUE] decimal(10,2),
  [CHARGEOUTRATE] decimal(10,2),
  [WIPENTITYNO] int,
  [TRANSNO] int,
  [WIPSEQNO] smallint,
  [NOTES] nvarchar(254),
  [NARRATIVENO] smallint,
  [SHORTNARRATIVE] nvarchar(254),
  [LONGNARRATIVE] ntext,
  [DISCOUNTVALUE] decimal(10,2),
  [FOREIGNCURRENCY] nvarchar(3)
    constraint R_1614
    references CURRENCY,
  [FOREIGNVALUE] decimal(11,2),
  [EXCHRATE] decimal(8,4),
  [FOREIGNDISCOUNT] decimal(11,2),
  [QUOTATIONNO] int,
  [PARENTENTRYNO] int,
  [COSTCALCULATION1] decimal(11,2),
  [COSTCALCULATION2] decimal(11,2),
  [PRODUCTCODE] int
    constraint RI_1265
    references TABLECODES,
  [ISTIMER] decimal(1) default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [MARGINNO] int
    constraint R_81507
    references MARGIN,
  constraint XPKDIARY
  primary key (EMPLOYEENO, ENTRYNO)
)
;

create index XIE1DIARY
  on DIARY (EMPLOYEENO, STARTTIME)
;

create index XIE2DIARY
  on DIARY (WIPENTITYNO, TRANSNO, WIPSEQNO)
;

create index XIE3DIARY
  on DIARY (PARENTENTRYNO)
;

create index XIE4DIARY
  on DIARY (NAMENO)
;

create index XIE5DIARY
  on DIARY (CASEID)
;

create index XIE6DIARY
  on DIARY (PRODUCTCODE)
;

create index XIE7DIARY
  on DIARY (MARGINNO)
;

create table DOCUMENTSUMMARY
(
  [DOCUMENT_ID] int not null
    constraint XPKDocumentSummary
    primary key,
  [DOCUMENTPATHNAME] varchar(1) not null,
  [DOCUMENTFILENAME] varchar(1) not null,
  [DOCUMENTTYPE] smallint,
  [DOCUMENTTITLE] nvarchar(100),
  [DOCUMENTAUTHOR] nvarchar(100),
  [SUBJECTCODE] int
    constraint R_1
    references SUBJECT,
  [DOCUMENTKEYWORDS] nvarchar(100),
  [DOCUMENTCOMMENTS] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table DOCUMENT_CRITERIA
  add constraint R_3
foreign key (DOCUMENT_ID) references DOCUMENTSUMMARY
;

create table EMPLOYEEREMINDER
(
  [EMPLOYEENO] int not null
    constraint R_184
    references NAME,
  [MESSAGESEQ] datetime not null,
  [CASEID] int
    constraint R_1299
    references CASES,
  [REFERENCE] nvarchar(20),
  [EVENTNO] int
    constraint R_855
    references EVENTS,
  [CYCLENO] smallint,
  [DUEDATE] datetime,
  [REMINDERDATE] datetime,
  [READFLAG] decimal(1),
  [SOURCE] decimal(1),
  [HOLDUNTILDATE] datetime,
  [DATEUPDATED] datetime,
  [SHORTMESSAGE] nvarchar(254),
  [LONGMESSAGE] ntext,
  [COMMENTS] nvarchar(254),
  [SEQUENCENO] int not null,
  [COMMENTS_TID] int,
  [MESSAGE_TID] int,
  [REFERENCE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [NAMENO] int
    constraint R_81539
    references NAME,
  [ALERTNAMENO] int
    constraint R_81756
    references NAME,
  constraint XPKEMPLOYEEREMINDER
  primary key (EMPLOYEENO, MESSAGESEQ)
)
;

create unique index XAK1EMPLOYEEREMINDER
  on EMPLOYEEREMINDER (CASEID, EMPLOYEENO, REFERENCE, EVENTNO, CYCLENO, SEQUENCENO)
;

create index XIE1EMPLOYEEREMINDER
  on EMPLOYEEREMINDER (ALERTNAMENO, SEQUENCENO)
;

create table GLACCOUNTTYPE
(
  [ACCOUNTTYPE] smallint not null
    constraint XPKGLACCOUNTTYPE
    primary key,
  [TITLE] nvarchar(50) not null,
  [LEDGER] smallint not null,
  [NOTES] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [USEBILLEDWIPCRITERIA] decimal(1)
)
;

alter table GLACCOUNTING
  add constraint R_1570
foreign key (ACCOUNTTYPE) references GLACCOUNTTYPE
;

alter table GLACCOUNTMAPPING
  add constraint R_1572
foreign key (ACCOUNTTYPE) references GLACCOUNTTYPE
;

alter table GLFIELDRULE
  add constraint R_1591
foreign key (ACCOUNTTYPE) references GLACCOUNTTYPE
;

create table GLCONTENTOPTIONS
(
  [CONTENTID] smallint not null,
  [LEDGER] tinyint,
  [DESCRIPTION] nvarchar(50),
  [NAMEFLAG] decimal(1),
  [NOTES] ntext,
  [GLCONTENTOPTID] int identity
    constraint XPKGLCONTENTOPTIONS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1GLCONTENTOPTIONS
  on GLCONTENTOPTIONS (CONTENTID, LEDGER)
;

create table GLJOURNALLINEFIELD
(
  [FIELDNO] smallint not null
    constraint XPKGLJOURNALLINEFIELD
    primary key,
  [FIELDNAME] nvarchar(30) not null,
  [NOTES] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GLFIELDRULE
  add constraint R_1590
foreign key (FIELDNO) references GLJOURNALLINEFIELD
;

alter table GLJOURNALLINEEXT
  add constraint R_1589
foreign key (FIELDNO) references GLJOURNALLINEFIELD
;

create table IDENTITYSETTINGS
(
  [IDENTITYID] int not null
    constraint R_65
    references USERIDENTITY,
  [SETTINGID] int not null,
  [COLCHARACTER] nvarchar(254),
  [COLINTEGER] int,
  [COLDECIMAL] decimal(12,2),
  [COLDATE] datetime,
  [COLBOOLEAN] decimal(1),
  [NOTES] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIDENTITYSETTINGS
  primary key (IDENTITYID, SETTINGID)
)
;

create table IMPORTJOURNAL
(
  [IMPORTBATCHNO] int not null
    constraint R_1457
    references IMPORTBATCH,
  [TRANSACTIONNO] int not null,
  [CASEID] int
    constraint R_1357
    references CASES,
  [PROCESSEDFLAG] decimal(1),
  [VALIDATEONLYFLAG] decimal(1),
  [CRITERIANO] int,
  [JOURNALNO] nvarchar(20),
  [JOURNALPAGE] smallint,
  [COUNTRYCODE] nvarchar(3),
  [OFFICIALNO] nvarchar(36),
  [ACTION] nvarchar(2),
  [RELATIVECYCLE] smallint,
  [TRANSACTIONTYPE] nvarchar(20),
  [NUMBERKEY] int,
  [CHARACTERKEY] nvarchar(12),
  [DATEDATA] datetime,
  [INTEGERDATA] int,
  [CHARACTERDATA] nvarchar(254),
  [TEXTDATA] ntext,
  [REJECTREASON] nvarchar(254),
  [ERROREVENTNO] int
    constraint R_1452
    references EVENTS,
  [CYCLE] smallint,
  [DECIMALDATA] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKIMPORTJOURNAL
  primary key (IMPORTBATCHNO, TRANSACTIONNO)
)
;

create index XIE1IMPORTJOURNAL
  on IMPORTJOURNAL (JOURNALNO, CASEID)
;

create index XIE2IMPORTJOURNAL
  on IMPORTJOURNAL (PROCESSEDFLAG, IMPORTBATCHNO)
;

create index XIE3IMPORTJOURNAL
  on IMPORTJOURNAL (CASEID)
;

create table INSTALMENT
(
  [QUOTATIONNO] int not null,
  [INSTALMENTNO] smallint not null,
  [DESCRIPTIONNO] smallint,
  [DESCRIPTION] ntext,
  [FOREIGNAMT] decimal(11,2),
  [LOCALAMT] decimal(11,2),
  [TRIGGERDATE] datetime not null,
  [EVENTNO] int
    constraint R_14
    references EVENTS,
  [TRIGGERDESCNO] smallint,
  [TRIGGERDESC] ntext,
  [ENTITYNO] int,
  [TRANSNO] int,
  [BILLEDCASEID] int
    constraint R_17
    references CASES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINSTALMENT
  primary key (QUOTATIONNO, INSTALMENTNO),
  constraint R_16
  foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER
)
;

create index XIE1INSTALMENT
  on INSTALMENT (BILLEDCASEID)
;

create table ITEM
(
  [ITEM_ID] int not null
    constraint XPKItem
    primary key,
  [ITEM_NAME] nvarchar(40) not null,
  [SQL_QUERY] ntext not null,
  [ITEM_DESCRIPTION] nvarchar(254) not null,
  [CREATED_BY] nvarchar(18),
  [DATE_CREATED] datetime,
  [DATE_UPDATED] datetime,
  [ITEM_TYPE] smallint,
  [ENTRY_POINT_USAGE] smallint,
  [SQL_DESCRIBE] nchar(254),
  [SQL_INTO] nchar(254),
  [ITEM_DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ITEM
  on ITEM (ITEM_NAME)
;

alter table CRITERIA
  add constraint R_1182
foreign key (DOCITEMID) references ITEM
;

alter table FORMFIELDS
  add constraint R_1609
foreign key (ITEM_ID) references ITEM
;

alter table MERGEFIELD
  add constraint RI_976
foreign key (ITEM_ID) references ITEM
;

alter table QUERYCOLUMN
  add constraint R_1040
foreign key (DOCITEMID) references ITEM
;

alter table ITEM_GROUP
  add constraint R_27A
foreign key (ITEM_ID) references ITEM
;

create table ITEM_NOTE
(
  [ITEM_ID] int not null
    constraint XPKItem_Note
    primary key
    constraint R_28
    references ITEM,
  [ITEM_NOTES] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table NARRATIVE
(
  [NARRATIVENO] smallint not null
    constraint XPKNARRATIVE
    primary key,
  [NARRATIVECODE] nvarchar(6),
  [NARRATIVETITLE] nvarchar(50),
  [NARRATIVETEXT] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1NARRATIVE
  on NARRATIVE (NARRATIVECODE)
;

create index XIE2NARRATIVE
  on NARRATIVE (NARRATIVETITLE)
;

alter table FEESCALCULATION
  add constraint RI_1024
foreign key (DISBNARRATIVE) references NARRATIVE
;

alter table FEESCALCULATION
  add constraint R_1026
foreign key (SERVICENARRATIVE) references NARRATIVE
;

alter table NARRATIVESUBSTITUT
  add constraint RI_1126
foreign key (NARRATIVENO) references NARRATIVE
;

alter table WIPTEMPLATE
  add constraint RI_1173
foreign key (NARRATIVENO) references NARRATIVE
;

alter table NARRATIVERULE
  add constraint R_49
foreign key (NARRATIVENO) references NARRATIVE
;

alter table taxrates
  add constraint R_81739
foreign key (NARRATIVENO) references NARRATIVE
;

alter table BILLLINE
  add constraint RI_1222
foreign key (NARRATIVENO) references NARRATIVE
;

alter table DIARY
  add constraint R_1290
foreign key (NARRATIVENO) references NARRATIVE
;

alter table INSTALMENT
  add constraint R_13
foreign key (DESCRIPTIONNO) references NARRATIVE
;

alter table INSTALMENT
  add constraint R_15
foreign key (TRIGGERDESCNO) references NARRATIVE
;

create table NARRATIVETRANSLATE
(
  [NARRATIVENO] smallint not null
    constraint R_1510
    references NARRATIVE,
  [LANGUAGE] int not null
    constraint R_1511
    references TABLECODES,
  [TRANSLATEDTEXT] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNARRATIVETRANSLATE
  primary key (NARRATIVENO, LANGUAGE)
)
;

create index XIE1NARRATIVETRANSLATE
  on NARRATIVETRANSLATE (LANGUAGE)
;

create table OPENITEM
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [ACTION] nvarchar(2)
    constraint R_1384
    references ACTIONS,
  [OPENITEMNO] nvarchar(12) not null,
  [ITEMDATE] datetime,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [CLOSEPOSTDATE] datetime,
  [CLOSEPOSTPERIOD] int,
  [STATUS] smallint,
  [ITEMTYPE] int,
  [BILLPERCENTAGE] decimal(5,2),
  [EMPLOYEENO] int,
  [EMPPROFITCENTRE] nvarchar(6),
  [CURRENCY] nvarchar(3)
    constraint R_1244
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [ITEMPRETAXVALUE] decimal(11,2),
  [LOCALTAXAMT] decimal(11,2),
  [LOCALVALUE] decimal(11,2),
  [FOREIGNTAXAMT] decimal(11,2),
  [FOREIGNVALUE] decimal(11,2),
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [STATEMENTREF] nvarchar(254),
  [REFERENCETEXT] nvarchar(254),
  [NAMESNAPNO] int
    constraint R_1424
    references NAMEADDRESSSNAP,
  [BILLFORMATID] smallint
    constraint R_1425
    references BILLFORMAT,
  [BILLPRINTEDFLAG] decimal(1),
  [REGARDING] nvarchar(254),
  [SCOPE] nvarchar(254),
  [LANGUAGE] int
    constraint R_219
    references TABLECODES,
  [ASSOCOPENITEMNO] nvarchar(12),
  [LONGREGARDING] ntext,
  [LONGREFTEXT] ntext,
  [IMAGEID] int
    constraint R_1554
    references IMAGE,
  [FOREIGNEQUIVCURRCY] nvarchar(3)
    constraint R_1607
    references CURRENCY,
  [FOREIGNEQUIVEXRATE] decimal(8,4),
  [ITEMDUEDATE] datetime,
  [PENALTYINTEREST] decimal(5,2),
  [LOCALORIGTAKENUP] decimal(11,2),
  [FOREIGNORIGTAKENUP] decimal(11,2),
  [REFERENCETEXT_TID] int,
  [REGARDING_TID] int,
  [SCOPE_TID] int,
  [INCLUDEONLYWIP] nvarchar(1),
  [PAYFORWIP] nvarchar(1),
  [PAYPROPERTYTYPE] nchar(1)
    constraint RI_1299
    references PROPERTYTYPE,
  [RENEWALDEBTORFLAG] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CASEPROFITCENTRE] nvarchar(6)
    constraint R_81499
    references PROFITCENTRE,
  [LOCKIDENTITYID] int
    constraint R_81540
    references USERIDENTITY,
  [MAINCASEID] int
    constraint R_81609
    references CASES,
  constraint XPKOPENITEM
  primary key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO),
  constraint R_1623
  foreign key (ITEMENTITYNO, ITEMTRANSNO) references TRANSACTIONHEADER,
  constraint RI_1242
  foreign key (ACCTENTITYNO, ACCTDEBTORNO) references ACCOUNT
)
;

create unique index XAK1OPENITEM
  on OPENITEM (ITEMENTITYNO, OPENITEMNO)
;

create index XIE1OPENITEM
  on OPENITEM (ACCTENTITYNO, ACCTDEBTORNO, CLOSEPOSTPERIOD)
;

create index XIE2OPENITEM
  on OPENITEM (ITEMENTITYNO, CLOSEPOSTPERIOD)
;

create index XIE3OPENITEM
  on OPENITEM (ACCTDEBTORNO)
;

create index XIE4OPENITEM
  on OPENITEM (ITEMTRANSNO)
;

create index XIE5OPENITEM
  on OPENITEM (OPENITEMNO)
;

create index XIE6OPENITEM
  on OPENITEM (LANGUAGE)
;

alter table OPENITEMTAX
  add constraint R_1245
foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO) references OPENITEM
;

alter table OPENITEMCASE
  add constraint R_50
foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO) references OPENITEM
;

alter table BILLEDCREDIT
  add constraint R_204
foreign key (DRITEMENTITYNO, DRITEMTRANSNO, DRACCTENTITYNO, DRACCTDEBTORNO) references OPENITEM
;

alter table BILLEDCREDIT
  add constraint R_205
foreign key (CRITEMENTITYNO, CRITEMTRANSNO, CRACCTENTITYNO, CRACCTDEBTORNO) references OPENITEM
;

alter table OPENITEMBREAKDOWN
  add constraint R_91464
foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO) references OPENITEM
;

create table QUOTATION
(
  [QUOTATIONNO] int not null
    constraint XPKQUOTATION
    primary key,
  [QUOTATIONID] nvarchar(10),
  [QUOTATIONDATE] datetime,
  [ACCEPTEDDATE] datetime,
  [QUOTATIONTYPE] nvarchar(50),
  [LANGUAGECODE] int
    constraint R_3A
    references TABLECODES,
  [DESCRIPTIONNO] smallint
    constraint R_4
    references NARRATIVE,
  [DESCRIPTION] ntext,
  [CASEID] int
    constraint R_5
    references CASES,
  [QUOTATIONNAMENO] int
    constraint R_6
    references NAME,
  [REFTEXT] ntext,
  [RAISEDBYNO] int
    constraint R_195
    references NAME,
  [FOREIGNCURRENCY] nvarchar(3)
    constraint R_8
    references CURRENCY,
  [EXCHANGERATE] decimal(8,4),
  [HEADERNO] smallint
    constraint R_9
    references NARRATIVE,
  [HEADER] ntext,
  [FOOTERNO] smallint
    constraint R_10
    references NARRATIVE,
  [FOOTER] ntext,
  [STATUS] int
    constraint R_11
    references TABLECODES,
  [USEINFLATIONINDEX] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1QUOTATION
  on QUOTATION (STATUS)
;

create index XIE2QUOTATION
  on QUOTATION (LANGUAGECODE)
;

create index XIE3QUOTATION
  on QUOTATION (CASEID)
;

alter table QUOTATIONWIPCODE
  add constraint R_19
foreign key (QUOTATIONNO) references QUOTATION
;

alter table DIARY
  add constraint R_23
foreign key (QUOTATIONNO) references QUOTATION
;

alter table INSTALMENT
  add constraint R_12
foreign key (QUOTATIONNO) references QUOTATION
;

create table REMINDERS
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [REMINDERNO] smallint not null,
  [PERIODTYPE] nchar(1),
  [LEADTIME] smallint,
  [FREQUENCY] smallint,
  [STOPTIME] smallint,
  [UPDATEEVENT] decimal(1),
  [LETTERNO] smallint
    constraint R_681
    references LETTER,
  [CHECKOVERRIDE] decimal(1),
  [MAXLETTERS] smallint,
  [LETTERFEE] int,
  [PAYFEECODE] nchar(1),
  [EMPLOYEEFLAG] decimal(1),
  [SIGNATORYFLAG] decimal(1),
  [INSTRUCTORFLAG] decimal(1),
  [CRITICALFLAG] decimal(1),
  [REMINDEMPLOYEE] int
    constraint R_196
    references NAME,
  [USEMESSAGE1] decimal(1),
  [MESSAGE1] ntext,
  [MESSAGE2] ntext,
  [INHERITED] decimal(1),
  [NAMETYPE] nvarchar(3)
    constraint R_1634
    references NAMETYPE,
  [SENDELECTRONICALLY] decimal(1),
  [EMAILSUBJECT] nvarchar(100),
  [ESTIMATEFLAG] decimal(1),
  [FREQPERIODTYPE] nchar(1),
  [STOPTIMEPERIODTYPE] nchar(1),
  [DIRECTPAYFLAG] bit,
  [RELATIONSHIP] nvarchar(3)
    constraint R_91878
    references NAMERELATION,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREMINDERS
  primary key (CRITERIANO, EVENTNO, REMINDERNO),
  constraint R_20097
  foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
)
;

create index XIE1REMINDERS
  on REMINDERS (EVENTNO)
;

create table SCREENS
(
  [SCREENNAME] nvarchar(32) not null
    constraint XPKSCREENS
    primary key,
  [SCREENTITLE] nvarchar(50),
  [SCREENTYPE] nchar(1),
  [SCREENIMAGE] ntext,
  [SCREENTITLE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table SCREENCONTROL
  add constraint R_769
foreign key (SCREENNAME) references SCREENS
;

create table SETTING
(
  [SETTINGID] int identity
    constraint XPKSETTING
    primary key,
  [DESCRIPTION] nvarchar(254),
  [DATATYPE] nvarchar(1),
  [TYPE] nvarchar(5),
  [LAYER] nvarchar(10),
  [NOTES] ntext,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table IDENTITYSETTINGS
  add constraint R_66
foreign key (SETTINGID) references SETTING
;

create table USERQUERY
(
  [REFERENCENO] int not null
    constraint XPKUSERQUERY
    primary key,
  [APPLICATIONNAME] nvarchar(8) not null,
  [QUERYNAME] nvarchar(40) not null,
  [QUERYDESCRIPTION] nvarchar(254),
  [USERID] nvarchar(30),
  [QUERY] ntext not null,
  [REPORT] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAKUSERQUERY
  on USERQUERY (APPLICATIONNAME, QUERYNAME)
;

create table USERS
(
  [USERID] nvarchar(30) not null
    constraint XPKUSERS
    primary key,
  [NAMEOFUSER] nvarchar(50),
  [NAMETYPE] nvarchar(3)
    constraint R_1319
    references NAMETYPE,
  [FAMILYNO] smallint
    constraint R_1318
    references NAMEFAMILY,
  [LANGUAGE] int
    constraint R_1303
    references TABLECODES,
  [EXTERNALUSERFLAG] decimal(1),
  [CASEVIEW] ntext,
  [REMINDERVIEW] ntext,
  [IDENTITYID] int
    constraint R_1105
    references USERIDENTITY,
  [WRITEDOWNLIMIT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1USERS
  on USERS (LANGUAGE)
;

alter table ASSIGNEDUSERS
  add constraint RI_907
foreign key (USERID) references USERS
;

alter table IRALLOCATION
  add constraint R_1392
foreign key (USERID) references USERS
;

alter table REPORTS
  add constraint R_1359
foreign key (USERID) references USERS
;

alter table USERAPPLICATIONS
  add constraint R_1305
foreign key (USERID) references USERS
;

alter table USERCONTROL
  add constraint R_904
foreign key (USERID) references USERS
;

alter table USERPROFILES
  add constraint R_1309
foreign key (USERID) references USERS
;

alter table USERROWACCESS
  add constraint R_1540
foreign key (USERID) references USERS
;

alter table USERSTATUS
  add constraint R_981
foreign key (USERID) references USERS
;

create table WORKHISTORY
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [HISTORYLINENO] smallint not null,
  [TRANSDATE] datetime,
  [POSTDATE] datetime,
  [TRANSTYPE] smallint,
  [RATENO] int
    constraint R_1321
    references RATES,
  [WIPCODE] nvarchar(6)
    constraint R_88
    references WIPTEMPLATE,
  [CASEID] int
    constraint RI_1197
    references CASES,
  [ACCTENTITYNO] int,
  [ACCTCLIENTNO] int,
  [EMPLOYEENO] int
    constraint R_201
    references NAME,
  [TOTALTIME] datetime,
  [TOTALUNITS] smallint,
  [UNITSPERHOUR] smallint,
  [CHARGEOUTRATE] decimal(11,2),
  [ASSOCIATENO] int
    constraint R_1325
    references NAME,
  [INVOICENUMBER] nvarchar(20),
  [FOREIGNCURRENCY] nvarchar(3)
    constraint RI_1194
    references CURRENCY,
  [FOREIGNTRANVALUE] decimal(11,2),
  [EXCHRATE] decimal(8,4),
  [LOCALTRANSVALUE] decimal(11,2),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [REFSEQNO] int,
  [REFACCTENTITYNO] int,
  [REFACCTDEBTORNO] int,
  [REASONCODE] nvarchar(2)
    constraint RI_1228
    references REASON,
  [BILLLINENO] smallint,
  [EMPPROFITCENTRE] nvarchar(6)
    constraint RI_1238
    references PROFITCENTRE,
  [CASEPROFITCENTRE] nvarchar(6)
    constraint RI_1239
    references PROFITCENTRE,
  [NARRATIVENO] smallint
    constraint RI_1193
    references NARRATIVE,
  [SHORTNARRATIVE] nvarchar(254),
  [LONGNARRATIVE] ntext,
  [ASSOCLINENO] smallint,
  [TRANSFERDETAIL] int,
  [STATUS] smallint,
  [MOVEMENTCLASS] smallint,
  [COMMANDID] smallint,
  [ITEMIMPACT] smallint,
  [POSTPERIOD] int
    constraint R_1503
    references PERIOD,
  [VARIABLEFEEAMT] decimal(11,2),
  [VARIABLEFEETYPE] smallint,
  [VARIABLEFEECURR] nvarchar(3)
    constraint R_1559
    references CURRENCY,
  [FEECRITERIANO] int,
  [FEEUNIQUEID] smallint,
  [GLMOVEMENTNO] int,
  [QUOTATIONNO] int
    constraint R_22
    references QUOTATION,
  [EMPFAMILYNO] smallint
    constraint R_26A
    references NAMEFAMILY,
  [EMPOFFICECODE] int
    constraint R_950
    references OFFICE,
  [VERIFICATIONNUMBER] nvarchar(20),
  [LOCALCOST] decimal(11,2),
  [FOREIGNCOST] decimal(11,2),
  [ENTEREDQUANTITY] int,
  [DISCOUNTFLAG] decimal(1),
  [NARRATIVE_TID] int,
  [COSTCALCULATION1] decimal(11,2),
  [COSTCALCULATION2] decimal(11,2),
  [PRODUCTCODE] int
    constraint R_1267
    references TABLECODES,
  [GENERATEDINADVANCE] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [MATCHENTITYNO] int,
  [MATCHTRANSNO] int,
  [MATCHWIPSEQNO] int,
  [MATCHEDTOOPENITEM] bit,
  [MATCHEDFULLY] bit,
  [MARGINNO] int
    constraint R_81506
    references MARGIN,
  [MARGINFLAG] bit,
  [PROTOCOLNO] nvarchar(20),
  [PROTOCOLDATE] datetime,
  constraint XPKWIPHISTORY
  primary key (ENTITYNO, TRANSNO, WIPSEQNO, HISTORYLINENO),
  constraint R_1627
  foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER,
  constraint RI_1252
  foreign key (ACCTENTITYNO, ACCTCLIENTNO) references ACCOUNT,
  constraint R_1625
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER,
  constraint R_1626
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER,
  constraint R_1560
  foreign key (FEECRITERIANO, FEEUNIQUEID) references FEESCALCULATION
)
;

create index XIE1WIPHISTORY
  on WORKHISTORY (REFENTITYNO, REFTRANSNO, REFSEQNO)
;

create index XIE10WORKHISTORY
  on WORKHISTORY (HISTORYLINENO)
;

create index XIE11WORKHISTORY
  on WORKHISTORY (PRODUCTCODE)
;

create index XIE12WORKHISTORY
  on WORKHISTORY (MARGINNO)
;

create index XIE13WORKHISTORY
  on WORKHISTORY (TRANSDATE, INVOICENUMBER)
;

create index XIE14WORKHISTORY
  on WORKHISTORY (PROTOCOLNO, PROTOCOLDATE)
;

create index XIE3WORKHISTORY
  on WORKHISTORY (ACCTENTITYNO, ACCTCLIENTNO)
;

create index XIE4WORKHISTORY
  on WORKHISTORY (TRANSDATE)
;

create index XIE5WORKHISTORY
  on WORKHISTORY (POSTDATE, POSTPERIOD)
;

create index XIE6WORKHISTORY
  on WORKHISTORY (ASSOCIATENO)
;

create index XIE7WORKHISTORY
  on WORKHISTORY (EMPLOYEENO)
;

create index XIE8WORKHISTORY
  on WORKHISTORY (EMPOFFICECODE)
;

create index XIE9WORKHISTORY
  on WORKHISTORY (TRANSTYPE)
;

create index XIE100WORKHISTORY
  on WORKHISTORY (TRANSTYPE, TRANSDATE, WIPCODE, INVOICENUMBER)
;

create index XIE100WORKHISTORY_CUSTOM
  on WORKHISTORY (CASEID, REFTRANSNO, REFENTITYNO, STATUS, MOVEMENTCLASS, WIPCODE, LOCALTRANSVALUE, TOTALTIME)
;

create table WORKINPROGRESS
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [TRANSDATE] datetime,
  [POSTDATE] datetime,
  [RATENO] int
    constraint R_1320
    references RATES,
  [WIPCODE] nvarchar(6)
    constraint R_1208
    references WIPTEMPLATE,
  [CASEID] int
    constraint RI_1182
    references CASES,
  [ACCTENTITYNO] int,
  [ACCTCLIENTNO] int,
  [EMPLOYEENO] int
    constraint R_202
    references NAME,
  [TOTALTIME] datetime,
  [TOTALUNITS] smallint,
  [UNITSPERHOUR] smallint,
  [CHARGEOUTRATE] decimal(11,2),
  [ASSOCIATENO] int
    constraint R_1324
    references NAME,
  [INVOICENUMBER] nvarchar(20),
  [FOREIGNCURRENCY] nvarchar(3)
    constraint R_1181
    references CURRENCY,
  [FOREIGNVALUE] decimal(11,2),
  [EXCHRATE] decimal(8,4),
  [LOCALVALUE] decimal(11,2),
  [BALANCE] decimal(11,2),
  [EMPPROFITCENTRE] nvarchar(6)
    constraint R_1236
    references PROFITCENTRE,
  [CASEPROFITCENTRE] nvarchar(6)
    constraint R_1237
    references PROFITCENTRE,
  [NARRATIVENO] smallint
    constraint RI_1175
    references NARRATIVE,
  [SHORTNARRATIVE] nvarchar(254),
  [LONGNARRATIVE] ntext,
  [STATUS] smallint,
  [VARIABLEFEEAMT] decimal(11,2),
  [VARIABLEFEETYPE] smallint,
  [VARIABLEFEECURR] nvarchar(3)
    constraint R_1557
    references CURRENCY,
  [FEECRITERIANO] int,
  [FEEUNIQUEID] smallint,
  [QUOTATIONNO] int
    constraint R_21
    references QUOTATION,
  [EMPFAMILYNO] smallint
    constraint R_24
    references NAMEFAMILY,
  [EMPOFFICECODE] int
    constraint R_949
    references OFFICE,
  [VERIFICATIONNUMBER] nvarchar(20),
  [LOCALCOST] decimal(11,2),
  [FOREIGNCOST] decimal(11,2),
  [ENTEREDQUANTITY] int,
  [DISCOUNTFLAG] decimal(1),
  [NARRATIVE_TID] int,
  [FOREIGNBALANCE] decimal(11,2),
  [COSTCALCULATION1] decimal(11,2),
  [COSTCALCULATION2] decimal(11,2),
  [PRODUCTCODE] int
    constraint R_1266
    references TABLECODES,
  [GENERATEDINADVANCE] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [MARGINNO] int
    constraint R_81505
    references MARGIN,
  [MARGINFLAG] bit,
  [BILLINGDISCOUNTFLAG] bit,
  constraint XPKWORKINPROGRESS
  primary key (ENTITYNO, TRANSNO, WIPSEQNO),
  constraint R_1A
  foreign key (ENTITYNO, TRANSNO) references TRANSACTIONHEADER,
  constraint R_1558
  foreign key (FEECRITERIANO, FEEUNIQUEID) references FEESCALCULATION
)
;

create index XIE1WORKINPROGRESS
  on WORKINPROGRESS (CASEID)
;

create index XIE2WORKINPROGRESS
  on WORKINPROGRESS (ACCTENTITYNO, ACCTCLIENTNO)
;

create index XIE3WORKINPROGRESS
  on WORKINPROGRESS (VERIFICATIONNUMBER)
;

create index XIE4WORKINPROGRESS
  on WORKINPROGRESS (PRODUCTCODE)
;

create index XIE5WORKINPROGRESS
  on WORKINPROGRESS (MARGINNO)
;

alter table BILLEDITEM
  add constraint R_146
foreign key (WIPENTITYNO, WIPTRANSNO, WIPSEQNO) references WORKINPROGRESS
;

create table ALERTTEMPLATE
(
  [ALERTTEMPLATECODE] nvarchar(10) not null
    constraint XPKALERTTEMPLATE
    primary key,
  [ALERTMESSAGE] nvarchar(1000),
  [EMAILSUBJECT] nvarchar(100),
  [SENDELECTRONICALLY] bit,
  [IMPORTANCELEVEL] nvarchar(2)
    constraint R_91528
    references IMPORTANCE,
  [DAYSLEAD] smallint,
  [DAILYFREQUENCY] smallint,
  [MONTHSLEAD] smallint,
  [MONTHLYFREQUENCY] smallint,
  [STOPALERT] smallint,
  [DELETEALERT] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table SETTINGGROUP
(
  [GROUPID] smallint not null
    constraint XPKSETTINGGROUP
    primary key,
  [DESCRIPTION] nvarchar(254),
  [NOTES] nvarchar(1000),
  [DESCRIPTION_TID] int,
  [OBJECTTABLE] nvarchar(30),
  [OBJECTINTEGERKEY] int,
  [OBJECTSTRINGKEY] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GROUPEDSETTINGS
  add constraint R_75
foreign key (GROUPID) references SETTINGGROUP
;

create table SETTINGDEFINITION
(
  [SETTINGID] int not null
    constraint XPKSETTINGDEFINITION
    primary key,
  [SETTINGNAME] nvarchar(100) not null,
  [DATATYPE] nvarchar(1) not null,
  [COMMENT] nvarchar(1000),
  [ISINTERNAL] bit default 0 not null,
  [ISEXTERNAL] bit default 0 not null,
  [SETTINGNAME_TID] int,
  [COMMENT_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table GROUPEDSETTINGS
  add constraint R_76
foreign key (SETTINGID) references SETTINGDEFINITION
;

create table SETTINGVALUES
(
  [SETTINGVALUEID] int identity
    constraint XPKSETTINGVALUES
    primary key,
  [SETTINGID] int not null
    constraint R_91531
    references SETTINGDEFINITION,
  [IDENTITYID] int
    constraint R_91532
    references USERIDENTITY,
  [COLCHARACTER] nvarchar(254),
  [COLINTEGER] int,
  [COLDECIMAL] decimal(12,2),
  [COLBOOLEAN] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1SETTINGVALUES
  on SETTINGVALUES (SETTINGID, IDENTITYID)
;

create table DATASOURCE
(
  [DATASOURCEID] int identity
    constraint XPKDATASOURCE
    primary key,
  [SYSTEMID] smallint not null,
  [SOURCENAMENO] int
    constraint R_91534
    references NAME,
  [ISPROTECTED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ENCODEDVALUE
(
  [CODEID] int identity
    constraint XPKENCODEDVALUE
    primary key,
  [SCHEMEID] smallint not null,
  [STRUCTUREID] smallint not null,
  [CODE] nvarchar(50),
  [DESCRIPTION] nvarchar(254),
  [OUTBOUNDVALUE] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ENCODEDVALUE
  on ENCODEDVALUE (SCHEMEID, STRUCTUREID, CODE, DESCRIPTION)
;

create index XIE1ENCODEDVALUE
  on ENCODEDVALUE (SCHEMEID, STRUCTUREID, DESCRIPTION)
;

create table ENCODINGSCHEME
(
  [SCHEMEID] smallint not null
    constraint XPKENCODINGSCHEME
    primary key,
  [SCHEMECODE] nvarchar(20) not null,
  [SCHEMENAME] nvarchar(50) not null,
  [SCHEMEDESCRIPTION] nvarchar(254),
  [ISPROTECTED] bit default 0 not null,
  [SCHEMENAME_TID] int,
  [SCHEMEDESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1ENCODINGSCHEME
  on ENCODINGSCHEME (SCHEMECODE)
;

alter table ENCODEDVALUE
  add constraint R_91546
foreign key (SCHEMEID) references ENCODINGSCHEME
;

create table ENCODINGSTRUCTURE
(
  [SCHEMEID] smallint not null
    constraint R_91542
    references ENCODINGSCHEME,
  [STRUCTUREID] smallint not null,
  [NAME] nvarchar(100) not null,
  [DESCRIPTION] nvarchar(254),
  [NAME_TID] int,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKENCODINGSTRUCTURE
  primary key (SCHEMEID, STRUCTUREID)
)
;

create table EXTERNALSYSTEM
(
  [SYSTEMID] smallint not null
    constraint XPKEXTERNALSYSTEM
    primary key,
  [SYSTEMNAME] nvarchar(100) not null,
  [SYSTEMCODE] nvarchar(20) not null,
  [DATAEXTRACTID] tinyint,
  [SYSTEMNAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EXTERNALSYSTEM
  on EXTERNALSYSTEM (SYSTEMCODE)
;

alter table CRITERIA
  add constraint R_91552
foreign key (SYSTEMID) references EXTERNALSYSTEM
;

alter table DATASOURCE
  add constraint R_91533
foreign key (SYSTEMID) references EXTERNALSYSTEM
;

create table MAPPING
(
  [ENTRYID] int identity
    constraint XPKMAPPING
    primary key,
  [STRUCTUREID] smallint not null,
  [DATASOURCEID] int
    constraint R_91549
    references DATASOURCE,
  [INPUTCODE] nvarchar(50),
  [INPUTDESCRIPTION] nvarchar(254),
  [INPUTCODEID] int
    constraint R_91550
    references ENCODEDVALUE,
  [OUTPUTCODEID] int
    constraint R_91551
    references ENCODEDVALUE,
  [OUTPUTVALUE] nvarchar(50),
  [ISNOTAPPLICABLE] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1MAPPING
  on MAPPING (STRUCTUREID, DATASOURCEID, INPUTCODE, INPUTDESCRIPTION, INPUTCODEID)
;

create index XIE1MAPPING
  on MAPPING (STRUCTUREID, DATASOURCEID, INPUTDESCRIPTION)
;

create index XIE2MAPPING
  on MAPPING (STRUCTUREID, INPUTCODEID)
;

create table MAPSCENARIO
(
  [SCENARIOID] int identity
    constraint XPKMAPSCENARIO
    primary key,
  [SYSTEMID] smallint not null
    constraint R_91539
    references EXTERNALSYSTEM,
  [STRUCTUREID] smallint not null,
  [SCHEMEID] smallint
    constraint R_91541
    references ENCODINGSCHEME,
  [IGNOREUNMAPPED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1MAPSCENARIO
  on MAPSCENARIO (SYSTEMID, STRUCTUREID, SCHEMEID)
;

create table MAPSTRUCTURE
(
  [STRUCTUREID] smallint not null
    constraint XPKMAPSTRUCTURE
    primary key,
  [STRUCTURENAME] nvarchar(50) not null,
  [STRUCTURENAME_TID] int,
  [TABLENAME] nvarchar(30) not null,
  [KEYCOLUMNAME] nvarchar(30) not null,
  [CODECOLUMNNAME] nvarchar(30),
  [DESCCOLUMNNAME] nvarchar(30),
  [SEARCHCONTEXTID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ENCODEDVALUE
  add constraint R_91547
foreign key (STRUCTUREID) references MAPSTRUCTURE
;

alter table ENCODINGSTRUCTURE
  add constraint R_91543
foreign key (STRUCTUREID) references MAPSTRUCTURE
;

alter table MAPPING
  add constraint R_91548
foreign key (STRUCTUREID) references MAPSTRUCTURE
;

alter table MAPSCENARIO
  add constraint R_91540
foreign key (STRUCTUREID) references MAPSTRUCTURE
;

create table XMLINSTRUCTION
(
  [XMLINSTRUCTIONID] int not null
    constraint XPKXMLINSTRUCTION
    primary key,
  [INSTRUCTION] nvarchar(4000) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ACTIVITYREQUEST
  add constraint R_91553
foreign key (XMLINSTRUCTIONID) references XMLINSTRUCTION
;

create table EXPORTFILENAMEFMT
(
  [FILENAMEFMTNO] int identity
    constraint XPKEXPORTFILENAMEFMT
    primary key,
  [PREFIX] nvarchar(254),
  [SUFFIX] nvarchar(254),
  [MIDDLE] int,
  [FILEEXTENSION] nvarchar(5),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table EXPORTMETHOD
(
  [EXPORTMETHODNO] int identity
    constraint XPKEXPORTMETHOD
    primary key,
  [EXPORTCODE] nvarchar(20) not null,
  [DESCRIPTION] nvarchar(254) not null,
  [TEMPLATE] nvarchar(254) not null,
  [FORMATFILE] nvarchar(254),
  [EXPORTCONTEXT] int not null,
  [FILENAMEFMTNO] int
    constraint R_91555
    references EXPORTFILENAMEFMT,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EXPORTMETHOD
  on EXPORTMETHOD (EXPORTCODE)
;

create unique index XAK2EXPORTMETHOD
  on EXPORTMETHOD (DESCRIPTION)
;

create table MARGINTYPE
(
  [MARGINTYPENO] int identity
    constraint XPKMARGINTYPE
    primary key,
  [MARGINCODE] nvarchar(10) not null,
  [DESCRIPTION] nvarchar(50) not null,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1MARGINTYPE
  on MARGINTYPE (MARGINCODE)
;

create unique index XAK2MARGINTYPE
  on MARGINTYPE (DESCRIPTION)
;

alter table MARGIN
  add constraint R_91566
foreign key (MARGINTYPENO) references MARGINTYPE
;

create table MARGINPROFILE
(
  [MARGINPROFILENO] int identity
    constraint XPKMARGINPROFILE
    primary key,
  [PROFILENAME] nvarchar(80) not null,
  [CATEGORYCODE] nvarchar(3) not null
    constraint R_91569
    references WIPCATEGORY,
  [PROFILENAME_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1MARGINPROFILE
  on MARGINPROFILE (PROFILENAME)
;

create index XIE1MARGINPROFILE
  on MARGINPROFILE (CATEGORYCODE)
;

alter table DISCOUNT
  add constraint R_91894
foreign key (MARGINPROFILENO) references MARGINPROFILE
;

create table MARGINPROFILERULE
(
  [PROFILETYPENO] int identity
    constraint XPKMARGINPROFILERULE
    primary key,
  [MARGINPROFILENO] int not null
    constraint R_91570
    references MARGINPROFILE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91571
    references COUNTRY,
  [PROPERTYTYPE] nchar(1)
    constraint R_91572
    references PROPERTYTYPE,
  [MARGINTYPENO] int
    constraint R_91573
    references MARGINTYPE,
  [CASETYPE] nchar(1)
    constraint R_91889
    references CASETYPE,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_91891
    references SUBTYPE,
  [ACTION] nvarchar(2)
    constraint R_91892
    references ACTIONS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_91890
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create unique index XAK1MARGINPROFILERULE
  on MARGINPROFILERULE (MARGINPROFILENO, COUNTRYCODE, CASETYPE, PROPERTYTYPE, CASECATEGORY, SUBTYPE, ACTION)
;

create table NAMEMARGINPROFILE
(
  [NAMENO] int not null
    constraint R_91575
    references NAME,
  [NAMEMARGINSEQNO] tinyint not null,
  [CATEGORYCODE] nvarchar(3) not null
    constraint R_91576
    references WIPCATEGORY,
  [WIPTYPEID] nvarchar(6)
    constraint R_91577
    references WIPTYPE,
  [MARGINPROFILENO] int
    constraint R_91578
    references MARGINPROFILE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMEMARGINPROFILE
  primary key (NAMENO, NAMEMARGINSEQNO)
)
;

create unique index XAK1NAMEMARGINPROFILE
  on NAMEMARGINPROFILE (CATEGORYCODE, NAMENO, WIPTYPEID)
;

create index XIE1NAMEMARGINPROFILE
  on NAMEMARGINPROFILE (WIPTYPEID)
;

create index XIE2NAMEMARGINPROFILE
  on NAMEMARGINPROFILE (MARGINPROFILENO)
;

create table CHARGERATES
(
  [CHARGETYPENO] int not null,
  [RATENO] int not null
    constraint R_91584
    references RATES,
  [SEQUENCENO] int identity(0, 1),
  [CASETYPE] nchar(1),
  [PROPERTYTYPE] nchar(1)
    constraint R_91625
    references PROPERTYTYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91626
    references COUNTRY,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_91627
    references SUBTYPE,
  [INSTRUCTIONTYPE] nvarchar(3),
  [FLAGNUMBER] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCHARGERATES
  primary key (CHARGETYPENO, RATENO, SEQUENCENO),
  constraint R_91624
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY,
  constraint R_91796
  foreign key (INSTRUCTIONTYPE, FLAGNUMBER) references INSTRUCTIONLABEL
)
;

create unique index XAK1CHARGERATES
  on CHARGERATES (CHARGETYPENO, RATENO, CASETYPE, PROPERTYTYPE, COUNTRYCODE, CASECATEGORY, SUBTYPE, INSTRUCTIONTYPE, FLAGNUMBER)
;

create index XIE1CHARGERATES
  on CHARGERATES (RATENO)
;

create table CHARGETYPE
(
  [CHARGETYPENO] int identity
    constraint XPKCHARGETYPE
    primary key,
  [CHARGEDESC] nvarchar(50) not null,
  [USEDASFLAG] smallint,
  [CHARGEDESC_TID] int,
  [CHARGEDUEEVENT] int
    constraint R_91798
    references EVENTS,
  [CHARGEINCURREDEVENT] int
    constraint R_91799
    references EVENTS,
  [PUBLICFLAG] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1CHARGETYPE
  on CHARGETYPE (CHARGEDESC)
;

alter table CHECKLISTITEM
  add constraint R_734
foreign key (YESRATENO) references CHARGETYPE
;

alter table CHECKLISTITEM
  add constraint R_733
foreign key (NORATENO) references CHARGETYPE
;

alter table EVENTCONTROL
  add constraint R_235
foreign key (INITIALFEE) references CHARGETYPE
;

alter table EVENTCONTROL
  add constraint R_488
foreign key (INITIALFEE2) references CHARGETYPE
;

alter table REMINDERS
  add constraint R_680
foreign key (LETTERFEE) references CHARGETYPE
;

alter table CHARGERATES
  add constraint R_91583
foreign key (CHARGETYPENO) references CHARGETYPE
;

create table INTEGRATIONQUEUE
(
  [INTEGRATIONID] int identity
    constraint XPKINTEGRATIONQUEUE
    primary key,
  [INTGROUP] int not null
    constraint R_91591
    references TABLECODES,
  [INTTYPE] int not null
    constraint R_91592
    references TABLECODES,
  [INTKEY] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1INTEGRATIONQUEUE
  on INTEGRATIONQUEUE (INTGROUP)
;

create index XIE2INTEGRATIONQUEUE
  on INTEGRATIONQUEUE (INTTYPE)
;

create table INTEGRATIONHISTORY
(
  [INTEGRATIONID] int not null
    constraint XPKINTEGRATIONHISTORY
    primary key,
  [INTGROUP] int not null
    constraint R_91593
    references TABLECODES,
  [INTTYPE] int not null
    constraint R_91594
    references TABLECODES,
  [INTKEY] nvarchar(254) not null,
  [LASTUPDATED] datetime,
  [COMPLETEDATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1INTEGRATIONHISTORY
  on INTEGRATIONHISTORY (INTEGRATIONID, INTGROUP, INTTYPE)
;

create index XIE2INTEGRATIONHISTORY
  on INTEGRATIONHISTORY (INTGROUP)
;

create index XIE3INTEGRATIONHISTORY
  on INTEGRATIONHISTORY (INTTYPE)
;

create table INTEGRATIONSTATUS
(
  [INTEGRATIONID] int not null
    constraint R_91595
    references INTEGRATIONHISTORY,
  [STATUSDATE] datetime not null,
  [INTSYSTEM] int not null
    constraint R_91596
    references TABLECODES,
  [STATUSCODE] int not null
    constraint R_91597
    references TABLECODES,
  [STATUSDESCRIPTION] nvarchar(254),
  [XMLDATA] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINTEGRATIONSTATUS
  primary key (INTEGRATIONID, STATUSDATE)
)
;

create index XIE1INTEGRATIONSTATUS
  on INTEGRATIONSTATUS (INTEGRATIONID, INTSYSTEM, STATUSCODE)
;

create index XIE2INTEGRATIONSTATUS
  on INTEGRATIONSTATUS (INTSYSTEM)
;

create index XIE3INTEGRATIONSTATUS
  on INTEGRATIONSTATUS (STATUSCODE)
;

create table SUBJECTAREATABLES
(
  [SUBJECTAREANO] int not null
    constraint R_91602
    references SUBJECTAREA,
  [TABLENAME] nvarchar(30) not null,
  [DEPTH] tinyint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSUBJECTAREATABLES
  primary key (SUBJECTAREANO, TABLENAME)
)
;

create table RECORDALTYPE
(
  [RECORDALTYPENO] int identity
    constraint XPKRECORDALTYPE
    primary key,
  [RECORDALTYPE] nvarchar(50) not null,
  [REQUESTEVENTNO] int
    constraint R_91604
    references EVENTS,
  [REQUESTACTION] nvarchar(2)
    constraint R_91605
    references ACTIONS,
  [RECORDEVENTNO] int
    constraint R_91606
    references EVENTS,
  [RECORDACTION] nvarchar(2)
    constraint R_91607
    references ACTIONS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table ELEMENT
(
  [ELEMENTNO] int identity
    constraint XPKELEMENT
    primary key,
  [ELEMENT] nvarchar(50) not null,
  [ELEMENTCODE] nvarchar(50) not null,
  [EDITATTRIBUTE] nvarchar(3),
  [ELEMENT_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table RECORDALELEMENT
(
  [RECORDALELEMENTNO] int identity
    constraint XPKRECORDALELEMENT
    primary key,
  [RECORDALTYPENO] int not null
    constraint R_91608
    references RECORDALTYPE,
  [ELEMENTNO] int not null
    constraint R_91609
    references ELEMENT,
  [ELEMENTLABEL] nvarchar(50) not null,
  [NAMETYPE] nvarchar(3)
    constraint R_91610
    references NAMETYPE,
  [EDITATTRIBUTE] nvarchar(3) default 'DIS' not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1RECORDALELEMENT
  on RECORDALELEMENT (RECORDALTYPENO, ELEMENTNO, NAMETYPE)
;

create table RECORDALSTEP
(
  [CASEID] int not null
    constraint R_91611
    references CASES,
  [RECORDALSTEPSEQ] int not null,
  [RECORDALTYPENO] int not null
    constraint R_91612
    references RECORDALTYPE,
  [STEPNO] tinyint not null,
  [MODIFIEDDATE] datetime default getdate() not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKRECORDALSTEP
  primary key (CASEID, RECORDALSTEPSEQ)
)
;

create table RECORDALSTEPELEMENT
(
  [CASEID] int not null,
  [RECORDALSTEPSEQ] int not null,
  [ELEMENTNO] int not null
    constraint R_91614
    references ELEMENT,
  [ELEMENTLABEL] nvarchar(50) not null,
  [NAMETYPE] nvarchar(3)
    constraint R_91615
    references NAMETYPE,
  [EDITATTRIBUTE] nvarchar(3),
  [ELEMENTVALUE] nvarchar(50),
  [OTHERVALUE] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKRECORDALSTEPELEMENT
  primary key (CASEID, RECORDALSTEPSEQ, ELEMENTNO),
  constraint R_91613
  foreign key (CASEID, RECORDALSTEPSEQ) references RECORDALSTEP
)
;

create table RECORDALAFFECTEDCASE
(
  [CASEID] int not null
    constraint R_91616
    references CASES,
  [SEQUENCENO] int not null,
  [RELATEDCASEID] int
    constraint R_91618
    references CASES,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91619
    references COUNTRY,
  [OFFICIALNUMBER] nvarchar(36),
  [RECORDALTYPENO] int not null
    constraint R_91620
    references RECORDALTYPE,
  [AGENTNO] int
    constraint R_91621
    references NAME,
  [STATUS] nvarchar(20),
  [REQUESTDATE] datetime,
  [RECORDDATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKRECORDALAFFECTEDCASE
  primary key (CASEID, SEQUENCENO)
)
;

create index XIE1RECORDALAFFECTEDCASE
  on RECORDALAFFECTEDCASE (RELATEDCASEID)
;

create table QUANTITYSOURCE
(
  [QUANTITYSOURCEID] smallint not null
    constraint XPKQUANTITYSOURCE
    primary key,
  [SOURCE] nvarchar(100) not null,
  [FROMEVENTNO] int
    constraint R_91633
    references EVENTS,
  [UNTILEVENTNO] int
    constraint R_91634
    references EVENTS,
  [PERIODTYPE] nchar(1),
  [SOURCE_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table FEESCALCULATION
  add constraint R_91636
foreign key (PARAMETERSOURCE) references QUANTITYSOURCE
;

alter table FEESCALCULATION
  add constraint R_91637
foreign key (PARAMETERSOURCE2) references QUANTITYSOURCE
;

create table PERMISSIONS
(
  [PERMISSIONID] int identity
    constraint XPKPERMISSIONS
    primary key,
  [OBJECTTABLE] nvarchar(30) not null,
  [OBJECTINTEGERKEY] int,
  [OBJECTSTRINGKEY] nvarchar(30),
  [LEVELTABLE] nvarchar(30),
  [LEVELKEY] int,
  [GRANTPERMISSION] tinyint not null,
  [DENYPERMISSION] tinyint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1PERMISSIONS
  on PERMISSIONS (OBJECTTABLE, OBJECTINTEGERKEY, OBJECTSTRINGKEY, LEVELTABLE, LEVELKEY)
;

create table EXCHRATESCHEDULE
(
  [EXCHSCHEDULEID] int identity
    constraint XPKEXCHRATESCHEDULE
    primary key,
  [EXCHSCHEDULECODE] nvarchar(20) not null,
  [DESCRIPTION] nvarchar(80) not null,
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table IPNAME
  add constraint R_91653
foreign key (EXCHSCHEDULEID) references EXCHRATESCHEDULE
;

alter table CREDITOR
  add constraint R_91654
foreign key (EXCHSCHEDULEID) references EXCHRATESCHEDULE
;

create table EXCHRATEVARIATION
(
  [EXCHVARIATIONID] int identity
    constraint XPKEXCHRATEVARIATION
    primary key,
  [EXCHSCHEDULEID] int
    constraint R_91655
    references EXCHRATESCHEDULE,
  [CURRENCYCODE] nvarchar(3)
    constraint R_91656
    references CURRENCY,
  [CASETYPE] nchar(1),
  [CASECATEGORY] nvarchar(2),
  [PROPERTYTYPE] nchar(1)
    constraint R_91658
    references PROPERTYTYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_91659
    references COUNTRY,
  [CASESUBTYPE] nvarchar(2)
    constraint R_91660
    references SUBTYPE,
  [BUYRATE] decimal(8,4),
  [SELLRATE] decimal(8,4),
  [BUYFACTOR] decimal(8,4),
  [SELLFACTOR] decimal(8,4),
  [EFFECTIVEDATE] datetime not null,
  [NOTES] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_91657
  foreign key (CASETYPE, CASECATEGORY) references CASECATEGORY
)
;

create unique index XAK1EXCHRATEVARIATION
  on EXCHRATEVARIATION (EXCHSCHEDULEID, CURRENCYCODE, CASETYPE, PROPERTYTYPE, COUNTRYCODE, CASECATEGORY, CASESUBTYPE, EFFECTIVEDATE)
;

create table EXTERNALNAME
(
  [EXTERNALNAMEID] int identity
    constraint XPKEXTERNALNAME
    primary key,
  [DATASOURCENAMENO] int not null
    constraint R_91661
    references NAME,
  [NAMETYPE] nvarchar(3),
  [EXTERNALNAME] nvarchar(254),
  [EXTERNALNAMECODE] nvarchar(50),
  [EMAIL] nvarchar(254),
  [PHONE] nvarchar(100),
  [FAX] nvarchar(100),
  [ENTITYTYPEFLAG] int,
  [FIRSTNAME] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EXTERNALNAME
  on EXTERNALNAME (DATASOURCENAMENO, EXTERNALNAMECODE, EXTERNALNAMEID)
;

create table EXTERNALNAMEADDRESS
(
  [EXTERNALNAMEADDRESSID] int identity
    constraint XPKEXTERNALNAMEADDRESS
    primary key,
  [EXTERNALNAMEID] int not null
    constraint R_91662
    references EXTERNALNAME,
  [ADDRESS] nvarchar(2000),
  [CITY] nvarchar(254),
  [STATE] nvarchar(50),
  [POSTCODE] nvarchar(50),
  [COUNTRY] nvarchar(3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EXTERNALNAMEADDRESS
  on EXTERNALNAMEADDRESS (EXTERNALNAMEID)
;

create table EXTERNALNAMEMAPPING
(
  [NAMEMAPID] int identity
    constraint XPKEXTERNALNAMEMAPPING
    primary key,
  [EXTERNALNAMEID] int not null
    constraint R_91663
    references EXTERNALNAME,
  [INPRONAMENO] int not null
    constraint R_91664
    references NAME,
  [PROPERTYTYPE] nchar(1)
    constraint R_91665
    references PROPERTYTYPE,
  [INSTRUCTORNAMENO] int
    constraint R_91666
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EXTERNALNAMEMAPPING
  on EXTERNALNAMEMAPPING (EXTERNALNAMEID)
;

create table EDEACCOUNT
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [ACCOUNTIDENTIFIER] nvarchar(254) not null,
  [ACCOUNTKIND] nvarchar(254),
  [ACCOUNTHOLDERNAME] nvarchar(254),
  [ACCOUNTDEBITKIND] nvarchar(50),
  [ROWID] int identity
    constraint XPKEDEACCOUNT
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEACCOUNT
  on EDEACCOUNT (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEADDRESSBOOK
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [ADDRESSLANGUAGECODE] nvarchar(50),
  [NAMENO] int
    constraint R_91772
    references NAME,
  [UNRESOLVEDNAMENO] int,
  [MISSINGNAMEDETAILS] bit,
  [ADDRESSCODE] int
    constraint R_91773
    references ADDRESS,
  [NAMETYPECODE_T] nvarchar(3),
  [ROWID] int identity
    constraint XPKEDEADDRESSBOOK
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEADDRESSBOOK
  on EDEADDRESSBOOK (BATCHNO, TRANSACTIONIDENTIFIER)
;

create index XIE2EDEADDRESSBOOK
  on EDEADDRESSBOOK (NAMENO, UNRESOLVEDNAMENO)
;

create index XIE3EDEADDRESSBOOK
  on EDEADDRESSBOOK (BATCHNO, NAMETYPECODE_T)
;

create table EDEASSOCIATEDCASEDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [ASSOCCASESEQ] int identity
    constraint XPKEDEASSOCIATEDCASEDETAILS
    primary key,
  [ASSOCIATEDCASERELATIONSHIPCODE] nvarchar(50) not null,
  [ASSOCIATEDCASERELATIONSHIPCODE_T] nvarchar(3),
  [ASSOCIATEDCASECOUNTRYCODE] nvarchar(50),
  [ASSOCIATEDCASECOUNTRYCODE_T] nvarchar(3),
  [ASSOCIATEDCASECOMMENT] nvarchar(254),
  [ASSOCIATEDCASESTATUS] nvarchar(50),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEASSOCIATEDCASEDETAILS
  on EDEASSOCIATEDCASEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEBANKTRANSFER
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [BANKTRANSFERIDENTIFIER] nvarchar(254) not null,
  [BANKTRANSFERDATE] datetime not null,
  [ORIGINBANKNAME] nvarchar(254),
  [BANKDESTINATIONACCOUNT] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDEBANKTRANSFER
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEBANKTRANSFER
  on EDEBANKTRANSFER (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECARDACCOUNT
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [CARDPRIMARYACCOUNTNUMBER] nvarchar(254) not null,
  [CARDNETWORKIDENTIFIER] nvarchar(254) not null,
  [CARDTYPECODE] nvarchar(50),
  [CARDCUSTOMERIDENTIFIER] nvarchar(254),
  [CARDVALIDITYSTARTDATE] datetime,
  [CARDEXPIRYDATE] datetime,
  [CARDISSUERIDENTIFIER] nvarchar(254),
  [CARDISSUENUMBER] nvarchar(254),
  [CARDCV2IDENTIFIER] nvarchar(254),
  [CARDCHIPCODE] nvarchar(50),
  [CARDCHIPAPPLICATIONIDENTIFIER] nvarchar(254),
  [CARDHOLDERNAME] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDECARDACCOUNT
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECARDACCOUNT
  on EDECARDACCOUNT (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECASEDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [SENDERCASEIDENTIFIER] nvarchar(254),
  [SENDERCASEREFERENCE] nvarchar(254),
  [RECEIVERCASEIDENTIFIER] nvarchar(254),
  [RECEIVERCASEREFERENCE] nvarchar(254),
  [CASELANGUAGECODE] nvarchar(50),
  [CORRESPONDENCELANGUAGECODE] nvarchar(50),
  [CASETYPECODE] nvarchar(50),
  [CASETYPECODE_T] nchar(1),
  [CASEPROPERTYTYPECODE] nvarchar(50) not null,
  [CASEPROPERTYTYPECODE_T] nchar(1),
  [CASECATEGORYCODE] nvarchar(50),
  [CASECATEGORYCODE_T] nvarchar(2),
  [CASESUBTYPECODE] nvarchar(50),
  [CASESUBTYPECODE_T] nvarchar(2),
  [CASEBASISCODE] nvarchar(50),
  [CASEBASISCODE_T] nvarchar(2),
  [CASECOUNTRYCODE] nvarchar(50),
  [CASECOUNTRYCODE_T] nvarchar(3),
  [ENTITYSIZE] nvarchar(50),
  [ENTITYSIZE_T] int,
  [NUMBERCLAIMS] int,
  [NUMBERDESIGNS] int,
  [EXTENDEDNUMBERYEARS] int,
  [CASESTATUS] nvarchar(254),
  [CASERENEWALSTATUS] nvarchar(254),
  [CASESTATUSFLAG] nvarchar(50),
  [STOPREASONCODE] nvarchar(50),
  [STOPREASONCODE_T] nchar(1),
  [CASEID] int
    constraint R_91765
    references CASES,
  [ROWID] int identity
    constraint XPKEDECASEDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EDECASEDETAILS
  on EDECASEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create index XIE1EDECASEDETAILS
  on EDECASEDETAILS (CASEID)
;

create table EDECASENAMEDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50) not null,
  [NAMETYPECODE_T] nvarchar(3),
  [NAMESEQUENCENUMBER] int,
  [NAMEREFERENCE] nvarchar(254),
  [NAMECURRENCYCODE] nvarchar(50),
  [ROWID] int identity
    constraint XPKEDECASENAMEDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECASENAMEDETAILS
  on EDECASENAMEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECHARGEDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [EVENTROWID] int,
  [ASSOCIATEDCASERELATIONSHIPCODE] nvarchar(50),
  [ASSOCIATEDCASECOUNTRYCODE] nvarchar(50),
  [EVENTCODE] nvarchar(50) not null,
  [CHARGEDATE] datetime,
  [CHARGETYPECODE] nvarchar(50),
  [CHARGEDOCUMENTNUMBER] nvarchar(254),
  [CHARGEDOCUMENTITEMNUMBER] nvarchar(254),
  [CURRENCYCODE] nvarchar(50),
  [CHARGEAMOUNT] decimal(12,2) not null,
  [CHARGECOMMENT] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDECHARGEDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECHARGEDETAILS
  on EDECHARGEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECHEQUE
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [CHEQUEIDENTIFIER] nvarchar(254) not null,
  [CHEQUEKIND] nvarchar(254),
  [BANKNAME] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDECHEQUE
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECHEQUE
  on EDECHEQUE (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECLASSDESCRIPTION
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [CLASSIFICATIONTYPECODE] nvarchar(254),
  [CLASSIFICATIONVERSION] nvarchar(254),
  [CLASSNUMBER] nvarchar(50),
  [GOODSSERVICESDESCRIPTION] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDECLASSDESCRIPTION
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECLASSDESCRIPTION
  on EDECLASSDESCRIPTION (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDECONTACTINFORMATIONDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [PHONE] nvarchar(50),
  [PHONEKIND] nvarchar(50),
  [FAX] nvarchar(254),
  [EMAIL] nvarchar(254),
  [URL] nvarchar(254),
  [OTHERELECTRONICADDRESS] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDECONTACTINFORMATIONDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDECONTACTINFORMATIONDETAILS
  on EDECONTACTINFORMATIONDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEDESCRIPTIONDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [DESCRIPTIONCODE] nvarchar(50) not null,
  [DESCRIPTIONCODE_T] nvarchar(50),
  [DESCRIPTIONTEXT] ntext not null,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDEDESCRIPTIONDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEDESCRIPTIONDETAILS
  on EDEDESCRIPTIONDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEDESIGNATEDCOUNTRYDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [DESIGNATEDCOUNTRYCODE] nvarchar(254) not null,
  [DESIGNATEDCOUNTRYCODE_T] nvarchar(3),
  [ROWID] int identity
    constraint XPKEDEDESIGNATEDCOUNTRYDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEDESIGNATEDCOUNTRYDETAILS
  on EDEDESIGNATEDCOUNTRYDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEDOCUMENT
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [ASSOCCASESEQ] int
    constraint R_91909
    references EDEASSOCIATEDCASEDETAILS,
  [ASSOCIATEDCASERELATIONSHIPCODE] nvarchar(254),
  [ASSOCIATEDCASECOUNTRYCODE] nvarchar(50),
  [DOCUMENTNAME] nvarchar(254) not null,
  [DOCUMENTFILENAME] nvarchar(254),
  [DOCUMENTFILEFORMAT] nvarchar(50),
  [DOCUMENTDATE] datetime,
  [DOCUMENTTYPECODE] nvarchar(50),
  [DOCUMENTLANGUAGECODE] nvarchar(50),
  [DOCUMENTMEDIA] nvarchar(50),
  [DOCUMENTLOCATION] nvarchar(254),
  [DOCUMENTVERSION] nvarchar(254),
  [DOCUMENTSIZEINBYTE] int,
  [DOCUMENTCOMMENT] nvarchar(254),
  [DOCUMENTBINARY] varbinary(1),
  [ROWID] int identity
    constraint XPKEDEDOCUMENT
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEDOCUMENT
  on EDEDOCUMENT (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEEVENTDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [ASSOCCASESEQ] int
    constraint R_91908
    references EDEASSOCIATEDCASEDETAILS,
  [ASSOCIATEDCASERELATIONSHIPCODE] nvarchar(50),
  [ASSOCIATEDCASECOUNTRYCODE] nvarchar(50),
  [EVENTCODE] nvarchar(50) not null,
  [EVENTCODE_T] nvarchar(10),
  [EVENTDATE] datetime,
  [EVENTDUEDATE] datetime,
  [EVENTCYCLE] int,
  [ANNUITYTERM] nvarchar(254),
  [EVENTTEXT] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDEEVENTDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEEVENTDETAILS
  on EDEEVENTDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

alter table EDECHARGEDETAILS
  add constraint R_91912
foreign key (EVENTROWID) references EDEEVENTDETAILS
;

create table EDEFORMATTEDADDRESS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ADDRESSMAILCODE] nvarchar(254),
  [ADDRESSPOSTOFFICEBOX] nvarchar(254),
  [ADDRESSROOM] nvarchar(50),
  [ADDRESSFLOOR] nvarchar(50),
  [ADDRESSBUILDING] nvarchar(254),
  [ADDRESSSTREET] nvarchar(254),
  [ADDRESSCITY] nvarchar(254),
  [ADDRESSCOUNTY] nvarchar(254),
  [ADDRESSSTATE] nvarchar(254),
  [ADDRESSPOSTCODE] nvarchar(50),
  [ADDRESSCOUNTRYCODE] nvarchar(50),
  [ADDRESSLINE] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDEFORMATTEDADDRESS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEFORMATTEDADDRESS
  on EDEFORMATTEDADDRESS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEFORMATTEDNAME
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [NAMEPREFIX] nvarchar(254),
  [FIRSTNAME] nvarchar(254),
  [MIDDLENAME] nvarchar(254),
  [LASTNAME] nvarchar(254),
  [SECONDLASTNAME] nvarchar(254),
  [NAMESUFFIX] nvarchar(254),
  [GENDER] nvarchar(50),
  [INDIVIDUALIDENTIFIER] nvarchar(50),
  [PERSONROLE] nvarchar(254),
  [ORGANIZATIONNAME] nvarchar(254),
  [ORGANIZATIONDEPARTMENT] nvarchar(254),
  [NAMESYNONYM] nvarchar(254),
  [GENDER_T] nchar(1),
  [ROWID] int identity
    constraint XPKEDEFORMATTEDNAME
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEFORMATTEDNAME
  on EDEFORMATTEDNAME (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEGOODSSERVICESDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [CLASSIFICATIONTYPECODE] nvarchar(50),
  [CLASSIFICATIONVERSION] nvarchar(50),
  [GOODSSERVICESCOMMENT] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDEGOODSSERVICESDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEGOODSSERVICESDETAILS
  on EDEGOODSSERVICESDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEIDENTIFIERNUMBERDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [ASSOCCASESEQ] int
    constraint R_91907
    references EDEASSOCIATEDCASEDETAILS,
  [ASSOCIATEDCASERELATIONSHIPCODE] nvarchar(50),
  [ASSOCIATEDCASECOUNTRYCODE] nvarchar(50),
  [IDENTIFIERNUMBERCODE] nvarchar(50) not null,
  [IDENTIFIERNUMBERCODE_T] nchar(1),
  [IDENTIFIERNUMBERTEXT] nvarchar(254) not null,
  [IDENTIFIERSTRIPPEDTEXT] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDEIDENTIFIERNUMBERDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEIDENTIFIERNUMBERDETAILS
  on EDEIDENTIFIERNUMBERDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDENAME
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [SENDERNAMEIDENTIFIER] nvarchar(254),
  [RECEIVERNAMEIDENTIFIER] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDENAME
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDENAME
  on EDENAME (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDENAMEADDRESSDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMETYPECODE_T] nvarchar(3),
  [ROWID] int identity
    constraint XPKEDENAMEADDRESSDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDENAMEADDRESSDETAILS
  on EDENAMEADDRESSDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEPAYMENTDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [PAYMENTREFERENCE] nvarchar(254),
  [PAYMENTSTATUS] nvarchar(254),
  [PAYMENTCOMMENT] nvarchar(254),
  [PAYMENTDATE] datetime,
  [ROWID] int identity
    constraint XPKEDEPAYMENTDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEPAYMENTDETAILS
  on EDEPAYMENTDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEPAYMENTFEEDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [FEEIDENTIFIER] nvarchar(254),
  [FEEREFERENCE] nvarchar(254),
  [FEEUNITQUANTITY] decimal(12,2),
  [FEECOMMENT] nvarchar(254),
  [FEEAMOUNTCURRENCYCODE] nvarchar(50),
  [FEEAMOUNT] decimal(12,2) not null,
  [FEEUNITAMOUNTCURRENCYCODE] nvarchar(254),
  [FEEUNITAMOUNT] decimal(12,2),
  [ROWID] int identity
    constraint XPKEDEPAYMENTFEEDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEPAYMENTFEEDETAILS
  on EDEPAYMENTFEEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDEPAYMENTMETHOD
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [OTHERPAYMENTMETHOD] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDEPAYMENTMETHOD
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEPAYMENTMETHOD
  on EDEPAYMENTMETHOD (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDERECEIVERDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [RECEIVER] nvarchar(50) not null,
  [RECEIVERREQUESTTYPE] nvarchar(50),
  [RECEIVERREQUESTIDENTIFIER] nvarchar(50),
  [RECEIVERLANGUAGECODE] nvarchar(50),
  [RECEIVERXSDVERSION] nvarchar(50),
  [RECEIVERFILENAME] nvarchar(254),
  [RECEIVERPRODUCEDDATE] datetime,
  [RECEIVERPRODUCEDDATETIME] datetime,
  [OUTPUTFORMAT] nvarchar(254),
  [RECEIVEREMAIL] nvarchar(50),
  [ROWID] int identity
    constraint XPKEDERECEIVERDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDERECEIVERDETAILS
  on EDERECEIVERDETAILS (BATCHNO)
;

create table EDESENDERDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [SENDERREQUESTTYPE] nvarchar(50),
  [SENDERREQUESTIDENTIFIER] nvarchar(254) not null,
  [SENDER] nvarchar(50) not null,
  [SENDERLANGUAGECODE] nvarchar(50),
  [SENDERXSDVERSION] nvarchar(254),
  [SENDERFILENAME] nvarchar(254),
  [SENDERPRODUCEDDATE] datetime,
  [SENDERPRODUCEDDATETIME] datetime,
  [SENDERNAMENO] int
    constraint R_91768
    references NAME,
  [ROWID] int identity
    constraint XPKEDESENDERDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDESENDERDETAILS
  on EDESENDERDETAILS (SENDERREQUESTIDENTIFIER, SENDER)
;

create index XIE2EDESENDERDETAILS
  on EDESENDERDETAILS (BATCHNO)
;

create index XIE3EDESENDERDETAILS
  on EDESENDERDETAILS (SENDERNAMENO)
;

create table EDESENDERSOFTWARE
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [SENDER] nvarchar(50),
  [SENDERSOFTWARENAME] nvarchar(254),
  [SENDERSOFTWAREVERSION] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDESENDERSOFTWARE
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDESENDERSOFTWARE
  on EDESENDERSOFTWARE (BATCHNO)
;

create table EDETRANSACTIONBODY
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [TRANSACTIONRETURNCODE] nvarchar(50),
  [TRANSSTATUSCODE] int
    constraint R_91770
    references TABLECODES,
  [TRANSNARRATIVECODE] int
    constraint R_91771
    references TABLECODES,
  [ROWID] int identity
    constraint XPKEDETRANSACTIONBODY
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EDETRANSACTIONBODY
  on EDETRANSACTIONBODY (BATCHNO, TRANSACTIONIDENTIFIER)
;

create index XIE1EDETRANSACTIONBODY
  on EDETRANSACTIONBODY (TRANSSTATUSCODE)
;

create index XIE2EDETRANSACTIONBODY
  on EDETRANSACTIONBODY (TRANSNARRATIVECODE)
;

create table EDETRANSACTIONCONTENTDETAILS
(
  [BATCHNO] int,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [ALTERNATIVESENDER] nvarchar(254),
  [TRANSACTIONCODE] nvarchar(50) not null,
  [TRANSACTIONSUBCODE] nvarchar(50),
  [TRANSACTIONCOMMENT] ntext,
  [ALTSENDERNAMENO] int
    constraint R_91769
    references NAME,
  [ROWID] int identity
    constraint XPKEDETRANSACTIONCONTENTDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EDETRANSACTIONCONTENTDETAILS
  on EDETRANSACTIONCONTENTDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDETRANSACTIONHEADER
(
  [BATCHNO] int identity
    constraint XPKEDETRANSACTIONHEADER
    primary key,
  [USERID] nvarchar(50) default user_name(),
  [IMPORTQUEUENO] int,
  [BATCHSTATUS] int
    constraint R_91750
    references TABLECODES,
  [PROCESSED] tinyint default 0,
  [DATEPROCESSED] datetime,
  [DATEOUTPUTPRODUCED] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1EDETRANSACTIONHEADER
  on EDETRANSACTIONHEADER (BATCHNO)
;

create index XIE1EDETRANSACTIONHEADER
  on EDETRANSACTIONHEADER (BATCHSTATUS)
;

alter table ACTIVITYREQUEST
  add constraint R_91864
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEACCOUNT
  add constraint R_91699
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEADDRESSBOOK
  add constraint R_91691
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEASSOCIATEDCASEDETAILS
  add constraint R_91680
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEBANKTRANSFER
  add constraint R_91704
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECARDACCOUNT
  add constraint R_91702
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECASEDETAILS
  add constraint R_91677
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECASENAMEDETAILS
  add constraint R_91690
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECHARGEDETAILS
  add constraint R_91684
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECHEQUE
  add constraint R_91703
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECLASSDESCRIPTION
  add constraint R_91688
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDECONTACTINFORMATIONDETAILS
  add constraint R_91695
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEDESCRIPTIONDETAILS
  add constraint R_91678
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEDESIGNATEDCOUNTRYDETAILS
  add constraint R_91679
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEDOCUMENT
  add constraint R_91685
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEEVENTDETAILS
  add constraint R_91683
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEFORMATTEDADDRESS
  add constraint R_91694
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEFORMATTEDNAME
  add constraint R_91693
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEGOODSSERVICESDETAILS
  add constraint R_91686
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEIDENTIFIERNUMBERDETAILS
  add constraint R_91682
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDENAME
  add constraint R_91692
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDENAMEADDRESSDETAILS
  add constraint R_91696
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEPAYMENTDETAILS
  add constraint R_91697
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEPAYMENTFEEDETAILS
  add constraint R_91705
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDEPAYMENTMETHOD
  add constraint R_91698
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDERECEIVERDETAILS
  add constraint R_91672
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDESENDERDETAILS
  add constraint R_91670
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDESENDERSOFTWARE
  add constraint R_91671
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDETRANSACTIONBODY
  add constraint R_91674
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

alter table EDETRANSACTIONCONTENTDETAILS
  add constraint R_91676
foreign key (BATCHNO) references EDETRANSACTIONHEADER
;

create table EDETRANSACTIONMESSAGEDETAILS
(
  [BATCHNO] int
    constraint R_91675
    references EDETRANSACTIONHEADER,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [TRANSACTIONMESSAGECODE] nvarchar(254) not null,
  [SEQUENTIALNUMBER] int,
  [TRANSACTIONMESSAGETEXT] ntext,
  [LANGUAGECODE] nvarchar(50),
  [SEQUENCENUMBER] int,
  [ROWID] int identity
    constraint XPKEDETRANSACTIONMESSAGEDETAILS
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDETRANSACTIONMESSAGEDETAILS
  on EDETRANSACTIONMESSAGEDETAILS (BATCHNO, TRANSACTIONIDENTIFIER)
;

create table EDERECEIVERSOFTWARE
(
  [BATCHNO] int
    constraint R_91673
    references EDETRANSACTIONHEADER,
  [USERID] nvarchar(50) default user_name(),
  [RECEIVER] nvarchar(50),
  [RECEIVERSOFTWARENAME] nvarchar(254),
  [RECEIVERSOFTWAREVERSION] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDERECEIVERSOFTWARE
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDERECEIVERSOFTWARE
  on EDERECEIVERSOFTWARE (BATCHNO)
;

create table DATAEXTRACTMODULE
(
  [DATAEXTRACTID] smallint not null
    constraint XPKDATAEXTRACTMODULE
    primary key,
  [SYSTEMID] smallint not null
    constraint R_91742
    references EXTERNALSYSTEM,
  [EXTRACTNAME] nvarchar(100),
  [EXTRACTNAME_TID] int,
  [SITECONTROLID] nvarchar(30),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CRITERIA
  add constraint R_91747
foreign key (DATAEXTRACTID) references DATAEXTRACTMODULE
;

create table EVENTCONTROLNAMEMAP
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [SEQUENCENO] int not null,
  [APPLICABLENAMETYPE] nvarchar(3) not null
    constraint R_91759
    references NAMETYPE,
  [SUBSTITUTENAMETYPE] nvarchar(3) not null
    constraint R_91760
    references NAMETYPE,
  [MUSTEXIST] bit,
  [INHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEVENTCONTROLNAMEMAP
  primary key (CRITERIANO, EVENTNO, SEQUENCENO),
  constraint R_91758
  foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
)
;

create table EVENTCONTROLREQEVENT
(
  [CRITERIANO] int not null,
  [EVENTNO] int not null,
  [REQEVENTNO] int not null
    constraint R_91762
    references EVENTS,
  [INHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEVENTCONTROLREQEVENT
  primary key (CRITERIANO, EVENTNO, REQEVENTNO),
  constraint R_91761
  foreign key (CRITERIANO, EVENTNO) references EVENTCONTROL
)
;

create table EDEREQUESTTYPE
(
  [REQUESTTYPECODE] nvarchar(50) not null
    constraint XPKEDEREQUESTTYPE
    primary key,
  [REQUESTTYPENAME] nvarchar(254) not null,
  [REQUESTORNAMETYPE] nvarchar(3)
    constraint R_91766
    references NAMETYPE,
  [REQUESTTYPENAME_TID] int,
  [TRANSACTIONREASONNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CRITERIA
  add constraint R_91835
foreign key (REQUESTTYPE) references EDEREQUESTTYPE
;

create table EDEMAPPINGRULE
(
  [TABLENAME] nvarchar(254),
  [CODECOLUMNNAME] nvarchar(254),
  [DESCRIPTIONCOLUMNNAME] nvarchar(254),
  [MAPPEDCOLUMNNAME] nvarchar(254),
  [FROMSCHEMEKEY] int,
  [COMMONSCHEMEKEY] int,
  [MAPSTRUCTUREID] int,
  [ROWID] int identity
    constraint XPKEDEMAPPINGRULE
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table EDEUNRESOLVEDNAME
(
  [UNRESOLVEDNAMENO] int identity
    constraint XPKEDEUNRESOLVEDNAME
    primary key,
  [BATCHNO] int
    constraint R_81602
    references EDETRANSACTIONHEADER,
  [TRANSACTIONIDENTIFIER] nvarchar(254),
  [TRANSACTIONCODE] nvarchar(50),
  [TRANSACTIONSUBCODE] nvarchar(50),
  [NAMETYPE] nvarchar(3)
    constraint R_91774
    references NAMETYPE,
  [SENDERNAMEIDENTIFIER] nvarchar(50),
  [ENTITYTYPEFLAG] int,
  [TITLE] nvarchar(10),
  [FIRSTNAME] nvarchar(50),
  [NAME] nvarchar(254),
  [INITIALS] nvarchar(10),
  [GENDER] nchar(1),
  [ADDRESSLINE] nvarchar(1000),
  [CITY] nvarchar(254),
  [STATE] nvarchar(50),
  [POSTCODE] nvarchar(50),
  [COUNTRYCODE] nvarchar(3),
  [PHONE] nvarchar(100),
  [FAX] nvarchar(100),
  [EMAIL] nvarchar(254),
  [ATTNFIRSTNAME] nvarchar(254),
  [ATTNLASTNAME] nvarchar(254),
  [ATTNTITLE] nvarchar(10),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEUNRESOLVEDNAME
  on EDEUNRESOLVEDNAME (TRANSACTIONIDENTIFIER, BATCHNO)
;

alter table EDEADDRESSBOOK
  add constraint R_91775
foreign key (UNRESOLVEDNAMENO) references EDEUNRESOLVEDNAME
;

create table EDECASEMATCH
(
  [DRAFTCASEID] int not null,
  [BATCHNO] int not null,
  [TRANSACTIONIDENTIFIER] nvarchar(50),
  [LIVECASEID] int
    constraint R_91781
    references CASES,
  [SEQUENCENO] smallint,
  [MATCHLEVEL] int,
  [APPROVALREQUIRED] bit,
  [SESSIONNO] int,
  [SUPERVISORDATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDECASEMATCH
  primary key (DRAFTCASEID, BATCHNO),
  constraint R_91780
  foreign key (BATCHNO, TRANSACTIONIDENTIFIER) references EDETRANSACTIONBODY (BATCHNO, TRANSACTIONIDENTIFIER)
)
;

create index XIE1EDECASEMATCH
  on EDECASEMATCH (BATCHNO, TRANSACTIONIDENTIFIER)
;

create index XIE2EDECASEMATCH
  on EDECASEMATCH (LIVECASEID)
;

create table EDEOUTSTANDINGISSUES
(
  [OUTSTANDINGISSUEID] int identity
    constraint XPKEDEOUTSTANDINGISSUES
    primary key,
  [BATCHNO] int,
  [TRANSACTIONIDENTIFIER] nvarchar(50),
  [ISSUEID] int not null,
  [CASEID] int
    constraint R_91784
    references CASES,
  [NAMENO] int
    constraint R_91785
    references NAME,
  [ISSUETEXT] nvarchar(254),
  [ISSUETEXT_TID] int,
  [DATECREATED] datetime,
  [REPORTEDVALUE] nvarchar(254),
  [EXISTINGVALUE] nvarchar(254),
  [SESSIONNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_91783
  foreign key (BATCHNO, TRANSACTIONIDENTIFIER) references EDETRANSACTIONBODY (BATCHNO, TRANSACTIONIDENTIFIER)
)
;

create index XIE1EDEOUTSTANDINGISSUES
  on EDEOUTSTANDINGISSUES (BATCHNO, TRANSACTIONIDENTIFIER)
;

create index XIE2EDEOUTSTANDINGISSUES
  on EDEOUTSTANDINGISSUES (CASEID)
;

create index XIE3EDEOUTSTANDINGISSUES
  on EDEOUTSTANDINGISSUES (NAMENO)
;

create index XIE4EDEOUTSTANDINGISSUES
  on EDEOUTSTANDINGISSUES (SESSIONNO, CASEID)
;

create table EDESTANDARDISSUE
(
  [ISSUEID] int identity
    constraint XPKEDESTANDARDISSUE
    primary key,
  [ISSUECODE] nvarchar(10),
  [SHORTDESCRIPTION] nvarchar(254) not null,
  [SHORTDESC_TID] int,
  [LONGDESCRIPTION] nvarchar(3500),
  [LONGDESC_TID] int,
  [SEVERITYLEVEL] int not null
    constraint R_91787
    references TABLECODES,
  [DEFAULTNARRATIVE] int
    constraint R_91789
    references TABLECODES,
  [PROTECTED] bit,
  [MISCELLANEOUS] bit,
  [IMPORTANCELEVEL] int
    constraint R_91000
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [SPECIAL] bit
)
;

create index XIE1EDESTANDARDISSUE
  on EDESTANDARDISSUE (ISSUECODE)
;

create index XIE2EDESTANDARDISSUE
  on EDESTANDARDISSUE (SEVERITYLEVEL)
;

create index XIE3EDESTANDARDISSUE
  on EDESTANDARDISSUE (DEFAULTNARRATIVE)
;

create index XIE4EDESTANDARDISSUE
  on EDESTANDARDISSUE (IMPORTANCELEVEL)
;

alter table EDEOUTSTANDINGISSUES
  add constraint R_91791
foreign key (ISSUEID) references EDESTANDARDISSUE
;

create table EDEFORMATTEDATTNOF
(
  [BATCHNO] int
    constraint R_91793
    references EDETRANSACTIONHEADER,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [NAMETYPECODE] nvarchar(50),
  [NAMESEQUENCENUMBER] int,
  [PAYMENTIDENTIFIER] nvarchar(254),
  [NAMEPREFIX] nvarchar(50),
  [FIRSTNAME] nvarchar(254),
  [LASTNAME] nvarchar(254),
  [ROWID] int identity
    constraint XPKEDEFORMATTEDATTNOF
    primary key,
  [NAMENO] int
    constraint R_91863
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEFORMATTEDATTNOF
  on EDEFORMATTEDATTNOF (BATCHNO)
;

create index XIE2EDEFORMATTEDATTNOF
  on EDEFORMATTEDATTNOF (TRANSACTIONIDENTIFIER)
;

create table EDEPATENTTERMADJ
(
  [BATCHNO] int
    constraint R_91795
    references EDETRANSACTIONHEADER,
  [USERID] nvarchar(50) default user_name(),
  [TRANSACTIONIDENTIFIER] nvarchar(50) not null,
  [PREISSUEPETITIONS] int,
  [POSTISSUEPETITIONS] int,
  [USPTOADJUSTMENT] int,
  [USPTODELAY] int,
  [THREEYEARS] int,
  [APPLICANTDELAY] int,
  [TOTALPTA] int,
  [ROWID] int identity
    constraint XPKEDEPATENTTERMADJ
    primary key,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1EDEPATENTTERMADJ
  on EDEPATENTTERMADJ (BATCHNO)
;

create index XIE2EDEPATENTTERMADJ
  on EDEPATENTTERMADJ (TRANSACTIONIDENTIFIER)
;

create table INSTRUCTIONDEFINITION
(
  [DEFINITIONID] int identity
    constraint XPKINSTRUCTIONDEFINITION
    primary key,
  [INSTRUCTIONNAME] nvarchar(50) not null,
  [INSTRUCTIONNAME_TID] int,
  [AVAILABILITYFLAGS] int not null,
  [EXPLANATION] nvarchar(100),
  [EXPLANATION_TID] int,
  [ACTION] nvarchar(2)
    constraint R_91800
    references ACTIONS,
  [USEMAXCYCLE] bit default 0 not null,
  [DUEEVENTNO] int
    constraint R_91801
    references EVENTS,
  [PREREQUISITEEVENTNO] int
    constraint R_91802
    references EVENTS,
  [INSTRUCTNAMETYPE] nvarchar(3)
    constraint R_91803
    references NAMETYPE,
  [CHARGETYPENO] int
    constraint R_91804
    references CHARGETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table INSTRUCTIONRESPONSE
(
  [DEFINITIONID] int not null
    constraint R_91805
    references INSTRUCTIONDEFINITION,
  [SEQUENCENO] tinyint not null,
  [LABEL] nvarchar(30) not null,
  [LABEL_TID] int,
  [FIREEVENTNO] int
    constraint R_91806
    references EVENTS,
  [EXPLANATION] nvarchar(100),
  [EXPLANATION_TID] int,
  [DISPLAYEVENTNO] int
    constraint R_91807
    references EVENTS,
  [HIDEEVENTNO] int
    constraint R_91808
    references EVENTS,
  [NOTESPROMPT] nvarchar(254),
  [NOTESPROMPT_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKINSTRUCTIONRESPONSE
  primary key (DEFINITIONID, SEQUENCENO)
)
;

create table CPASENDCOMPARE
(
  [CASEID] int,
  [SYSTEMID] nvarchar(3),
  [BATCHNO] int not null,
  [BATCHDATE] datetime,
  [PROPERTYTYPE] nchar(1),
  [CASECODE] nvarchar(15),
  [TRANSACTIONCODE] smallint,
  [ALTOFFICECODE] nvarchar(3),
  [FILENUMBER] nvarchar(15),
  [CLIENTSREFERENCE] nvarchar(35),
  [CPACOUNTRYCODE] nvarchar(2),
  [RENEWALTYPECODE] nvarchar(2),
  [MARK] nvarchar(100),
  [ENTITYSIZE] nchar(1),
  [PRIORITYDATE] datetime,
  [PARENTDATE] datetime,
  [NEXTTAXDATE] datetime,
  [NEXTDECOFUSEDATE] datetime,
  [PCTFILINGDATE] datetime,
  [ASSOCDESIGNDATE] datetime,
  [NEXTAFFIDAVITDATE] datetime,
  [APPLICATIONDATE] datetime,
  [ACCEPTANCEDATE] datetime,
  [PUBLICATIONDATE] datetime,
  [REGISTRATIONDATE] datetime,
  [RENEWALDATE] datetime,
  [NOMINALWORKINGDATE] datetime,
  [EXPIRYDATE] datetime,
  [CPASTARTPAYDATE] datetime,
  [CPASTOPPAYDATE] datetime,
  [STOPPAYINGREASON] nchar(1),
  [PRIORITYNO] nvarchar(30),
  [PARENTNO] nvarchar(30),
  [PCTFILINGNO] nvarchar(30),
  [ASSOCDESIGNNO] nvarchar(30),
  [APPLICATIONNO] nvarchar(30),
  [ACCEPTANCENO] nvarchar(30),
  [PUBLICATIONNO] nvarchar(30),
  [REGISTRATIONNO] nvarchar(30),
  [INTLCLASSES] nvarchar(150),
  [LOCALCLASSES] nvarchar(150),
  [NUMBEROFYEARS] smallint,
  [NUMBEROFCLAIMS] smallint,
  [NUMBEROFDESIGNS] smallint,
  [NUMBEROFCLASSES] smallint,
  [NUMBEROFSTATES] smallint,
  [DESIGNATEDSTATES] nvarchar(200),
  [OWNERNAME] nvarchar(100),
  [OWNERNAMECODE] nvarchar(35),
  [OWNADDRESSLINE1] nvarchar(50),
  [OWNADDRESSLINE2] nvarchar(50),
  [OWNADDRESSLINE3] nvarchar(50),
  [OWNADDRESSLINE4] nvarchar(50),
  [OWNADDRESSCOUNTRY] nvarchar(50),
  [OWNADDRESSPOSTCODE] nvarchar(16),
  [CLIENTCODE] nvarchar(15),
  [CPACLIENTNO] int,
  [CLIENTNAME] nvarchar(100),
  [CLIENTATTENTION] nvarchar(50),
  [CLTADDRESSLINE1] nvarchar(50),
  [CLTADDRESSLINE2] nvarchar(50),
  [CLTADDRESSLINE3] nvarchar(50),
  [CLTADDRESSLINE4] nvarchar(50),
  [CLTADDRESSCOUNTRY] nvarchar(50),
  [CLTADDRESSPOSTCODE] nvarchar(16),
  [CLIENTTELEPHONE] nvarchar(20),
  [CLIENTFAX] nvarchar(20),
  [CLIENTEMAIL] nvarchar(100),
  [DIVISIONCODE] nvarchar(6),
  [DIVISIONNAME] nvarchar(100),
  [DIVISIONATTENTION] nvarchar(50),
  [DIVADDRESSLINE1] nvarchar(50),
  [DIVADDRESSLINE2] nvarchar(50),
  [DIVADDRESSLINE3] nvarchar(50),
  [DIVADDRESSLINE4] nvarchar(50),
  [DIVADDRESSCOUNTRY] nvarchar(50),
  [DIVADDRESSPOSTCODE] nvarchar(16),
  [FOREIGNAGENTCODE] nvarchar(8),
  [FOREIGNAGENTNAME] nvarchar(100),
  [ATTORNEYCODE] nvarchar(8),
  [ATTORNEYNAME] nvarchar(100),
  [INVOICEECODE] nvarchar(15),
  [CPAINVOICEENO] int,
  [INVOICEENAME] nvarchar(100),
  [INVOICEEATTENTION] nvarchar(50),
  [INVADDRESSLINE1] nvarchar(50),
  [INVADDRESSLINE2] nvarchar(50),
  [INVADDRESSLINE3] nvarchar(50),
  [INVADDRESSLINE4] nvarchar(50),
  [INVADDRESSCOUNTRY] nvarchar(50),
  [INVADDRESSPOSTCODE] nvarchar(16),
  [INVOICEETELEPHONE] nvarchar(20),
  [INVOICEEFAX] nvarchar(20),
  [INVOICEEEMAIL] nvarchar(100),
  [NARRATIVE] nvarchar(50),
  [IPRURN] nvarchar(7),
  [ACKNOWLEDGED] decimal(1),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CPASENDCOMPARE
  on CPASENDCOMPARE (BATCHNO)
;

create index XIE2CPASENDCOMPARE
  on CPASENDCOMPARE (CASECODE)
;

create index XIE3CPASENDCOMPARE
  on CPASENDCOMPARE (CASEID)
;

create index XIE4CPASENDCOMPARE
  on CPASENDCOMPARE (BATCHNO, CASECODE, CASEID)
;

create index XIE5CPASENDCOMPARE
  on CPASENDCOMPARE (SYSTEMID, BATCHNO, CASECODE, CLIENTCODE, DIVISIONCODE, INVOICEECODE)
;

create table DOCUMENTDEFINITION
(
  [DOCUMENTDEFID] int identity
    constraint XPKDOCUMENTDEFINITION
    primary key,
  [LETTERNO] smallint not null
    constraint R_91819
    references LETTER,
  [NAME] nvarchar(50) not null,
  [NAME_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [CANFILTERCASES] bit default 0 not null,
  [CANFILTEREVENTS] bit default 0 not null,
  [SENDERREQUESTTYPE] nvarchar(50)
    constraint R_91820
    references EDEREQUESTTYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table DOCUMENTDEFINITIONACTINGAS
(
  [DOCUMENTDEFID] int not null
    constraint R_91822
    references DOCUMENTDEFINITION,
  [NAMETYPE] nvarchar(3) not null
    constraint R_91821
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDOCUMENTDEFINITIONACTINGAS
  primary key (DOCUMENTDEFID, NAMETYPE)
)
;

create table DOCUMENTEVENTGROUP
(
  [REQUESTID] int not null,
  [EVENTGROUP] int not null
    constraint R_91834
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDOCUMENTEVENTGROUP
  primary key (REQUESTID, EVENTGROUP)
)
;

create index XIE1DOCUMENTEVENTGROUP
  on DOCUMENTEVENTGROUP (EVENTGROUP)
;

create table DOCUMENTREQUEST
(
  [REQUESTID] int identity
    constraint XPKDOCUMENTREQUEST
    primary key,
  [RECIPIENT] int not null
    constraint R_91825
    references NAME,
  [DESCRIPTION] nvarchar(100) not null,
  [DOCUMENTDEFID] int not null
    constraint R_91826
    references DOCUMENTDEFINITION,
  [FREQUENCY] tinyint,
  [PERIODTYPE] nchar(1),
  [OUTPUTFORMATID] int not null
    constraint R_91827
    references TABLECODES,
  [NEXTGENERATE] datetime not null,
  [STOPON] datetime,
  [LASTGENERATED] datetime,
  [BELONGINGTOCODE] nvarchar(2),
  [CASEFILTERID] int
    constraint R_91828
    references QUERYFILTER,
  [EVENTSTART] datetime,
  [SUPPRESSWHENEMPTY] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [DAYOFMONTH] tinyint
)
;

create index XIE1DOCUMENTREQUEST
  on DOCUMENTREQUEST (RECIPIENT)
;

create index XIE2DOCUMENTREQUEST
  on DOCUMENTREQUEST (DESCRIPTION)
;

create index XIE3DOCUMENTREQUEST
  on DOCUMENTREQUEST (NEXTGENERATE, STOPON)
;

create index XIE4DOCUMENTREQUEST
  on DOCUMENTREQUEST (OUTPUTFORMATID)
;

alter table ACTIVITYREQUEST
  add constraint R_91883
foreign key (REQUESTID) references DOCUMENTREQUEST
;

alter table DOCUMENTEVENTGROUP
  add constraint R_91833
foreign key (REQUESTID) references DOCUMENTREQUEST
;

create table DOCUMENTREQUESTACTINGAS
(
  [REQUESTID] int not null
    constraint R_91831
    references DOCUMENTREQUEST,
  [NAMETYPE] nvarchar(3) not null
    constraint R_91832
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDOCUMENTREQUESTACTINGAS
  primary key (REQUESTID, NAMETYPE)
)
;

create table DOCUMENTREQUESTEMAIL
(
  [DOCUMENTEMAILID] int identity
    constraint XPKDOCUMENTREQUESTEMAIL
    primary key,
  [REQUESTID] int not null
    constraint R_91830
    references DOCUMENTREQUEST,
  [ISMAIN] bit default 0 not null,
  [EMAIL] nvarchar(50) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DOCUMENTREQUESTEMAIL
  on DOCUMENTREQUESTEMAIL (REQUESTID, EMAIL)
;

create table VALIDEXPORTFORMAT
(
  [DOCUMENTDEFID] int not null
    constraint R_91823
    references DOCUMENTDEFINITION,
  [FORMATID] int not null
    constraint R_91824
    references TABLECODES,
  [ISDEFAULT] bit not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKVALIDEXPORTFORMAT
  primary key (DOCUMENTDEFID, FORMATID)
)
;

create index XIE1VALIDEXPORTFORMAT
  on VALIDEXPORTFORMAT (FORMATID)
;

create table EDERULECASE
(
  [CRITERIANO] int not null
    constraint XPKEDERULECASE
    primary key
    constraint R_91842
    references CRITERIA,
  [WHOLECASE] smallint,
  [CASETYPE] smallint,
  [PROPERTYTYPE] smallint,
  [COUNTRY] smallint,
  [CATEGORY] smallint,
  [SUBTYPE] smallint,
  [BASIS] smallint,
  [ENTITYSIZE] smallint,
  [NUMBEROFCLAIMS] smallint,
  [NUMBEROFDESIGNS] smallint,
  [NUMBEROFYEARSEXT] smallint,
  [STOPPAYREASON] smallint,
  [SHORTTITLE] smallint,
  [CLASSES] smallint,
  [DESIGNATEDCOUNTRIES] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table EDERULECASEEVENT
(
  [CRITERIANO] int not null
    constraint R_91849
    references CRITERIA,
  [EVENTNO] int not null
    constraint R_91850
    references EVENTS,
  [EVENTDATE] smallint,
  [EVENTDUEDATE] smallint,
  [EVENTTEXT] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULECASEEVENT
  primary key (CRITERIANO, EVENTNO)
)
;

create table EDERULECASENAME
(
  [CRITERIANO] int not null
    constraint R_91843
    references CRITERIA,
  [NAMETYPE] nvarchar(3) not null
    constraint R_91844
    references NAMETYPE,
  [NAMENO] smallint,
  [REFERENCENO] smallint,
  [CORRESPONDNAME] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULECASENAME
  primary key (CRITERIANO, NAMETYPE)
)
;

create table EDERULECASETEXT
(
  [CRITERIANO] int not null
    constraint R_91847
    references EDERULECASE,
  [TEXTTYPE] nvarchar(2) not null
    constraint R_91848
    references TEXTTYPE,
  [TEXT] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULECASETEXT
  primary key (CRITERIANO, TEXTTYPE)
)
;

create table EDERULEOFFICIALNUMBER
(
  [CRITERIANO] int not null
    constraint R_91845
    references CRITERIA,
  [NUMBERTYPE] nchar(1) not null
    constraint R_91846
    references NUMBERTYPES,
  [OFFICIALNUMBER] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULEOFFICIALNUMBER
  primary key (CRITERIANO, NUMBERTYPE)
)
;

create table EDERULERELATEDCASE
(
  [CRITERIANO] int not null
    constraint R_91851
    references CRITERIA,
  [RELATIONSHIP] nvarchar(3) not null
    constraint R_91852
    references CASERELATION,
  [OFFICIALNUMBER] smallint,
  [PRIORITYDATE] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULERELATEDCASE
  primary key (CRITERIANO, RELATIONSHIP)
)
;

create table EDERULETYPEACTION
(
  [RULETYPE] int not null
    constraint R_91853
    references TABLECODES,
  [ACTIONCODE] int not null,
  [DESCRIPTION] nvarchar(254) not null,
  [DESCRIPTION_TID] int,
  [NOTES] nvarchar(1000),
  [NOTES_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULETYPEACTION
  primary key (RULETYPE, ACTIONCODE)
)
;

create index XIE1EDERULETYPEACTION
  on EDERULETYPEACTION (RULETYPE)
;

create table SESSION
(
  [SESSIONNO] int identity
    constraint XPKSESSION
    primary key,
  [IDENTITYID] int not null
    constraint R_91854
    references USERIDENTITY,
  [STARTDATE] datetime,
  [PROGRAM] nvarchar(100),
  [SESSIONIDENTIFIER] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table EDECASEMATCH
  add constraint R_91860
foreign key (SESSIONNO) references SESSION
;

alter table EDEOUTSTANDINGISSUES
  add constraint R_91906
foreign key (SESSIONNO) references SESSION
;

create table TRANSACTIONINFO
(
  [LOGTRANSACTIONNO] int identity
    constraint XPKTRANSACTIONINFO
    primary key,
  [TRANSACTIONDATE] datetime not null,
  [SESSIONNO] int,
  [BATCHNO] int,
  [TRANSACTIONIDENTIFIER] nvarchar(50),
  [CASEID] int
    constraint R_91856
    references CASES,
  [NAMENO] int
    constraint R_91857
    references NAME,
  [TRANSACTIONREASONNO] int,
  [TRANSACTIONMESSAGENO] int
)
;

create index XIE1TRANSACTIONINFO
  on TRANSACTIONINFO (CASEID)
;

create index XIE2TRANSACTIONINFO
  on TRANSACTIONINFO (NAMENO)
;

create index XIE3TRANSACTIONINFO
  on TRANSACTIONINFO (TRANSACTIONMESSAGENO)
;

create index XIE4TRANSACTIONINFO
  on TRANSACTIONINFO (TRANSACTIONIDENTIFIER, BATCHNO)
;

create index XIE5TRANSACTIONINFO
  on TRANSACTIONINFO (SESSIONNO, CASEID)
;

create table TRANSACTIONMESSAGE
(
  [TRANSACTIONMESSAGENO] int identity
    constraint XPKTRANSACTIONMESSAGE
    primary key,
  [DESCRIPTION] nvarchar(254) not null,
  [DESCRIPTION_TID] int,
  [TRANSACTIONTYPE] nvarchar(1) not null,
  [MESSAGEPRIORITY] smallint,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table TRANSACTIONINFO
  add constraint R_91859
foreign key (TRANSACTIONMESSAGENO) references TRANSACTIONMESSAGE
;

create table TRANSACTIONREASON
(
  [TRANSACTIONREASONNO] int identity
    constraint XPKTRANSACTIONREASON
    primary key,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [INTERNALFLAG] bit default 0,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table EDEREQUESTTYPE
  add constraint R_91861
foreign key (TRANSACTIONREASONNO) references TRANSACTIONREASON
;

alter table TRANSACTIONINFO
  add constraint R_91858
foreign key (TRANSACTIONREASONNO) references TRANSACTIONREASON
;

create table CASEINSTRUCTALLOWED
(
  [CASEID] int not null,
  [EVENTNO] int not null,
  [CYCLE] smallint not null,
  [DEFINITIONID] int not null
    constraint R_91873
    references INSTRUCTIONDEFINITION,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEINSTRUCTALLOWED
  primary key (CASEID, EVENTNO, CYCLE, DEFINITIONID),
  constraint R_91872
  foreign key (CASEID, EVENTNO, CYCLE) references CASEEVENT
)
;

create index XIE1CASEINSTRUCTALLOWED
  on CASEINSTRUCTALLOWED (DEFINITIONID, CASEID)
;

create table PROCESSREQUEST
(
  [PROCESSID] int identity
    constraint XPKPROCESSREQUEST
    primary key nonclustered,
  [BATCHNO] int
    constraint R_91885
    references EDETRANSACTIONHEADER,
  [CASEID] int
    constraint R_91886
    references CASES,
  [REQUESTDATE] datetime,
  [PROCESSDATE] datetime,
  [CONTEXT] nvarchar(20) not null,
  [SQLUSER] nvarchar(40) not null,
  [REQUESTTYPE] nvarchar(30) not null,
  [REQUESTDESCRIPTION] nvarchar(254),
  [STATUSCODE] int
    constraint R_91887
    references TABLECODES,
  [STATUSMESSAGE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [SPID] smallint,
  [LOGINTIME] datetime
)
;

create index XIE1PROCESSREQUEST
  on PROCESSREQUEST (BATCHNO)
;

create index XIE2PROCESSREQUEST
  on PROCESSREQUEST (STATUSCODE)
;

create index XIE3PROCESSREQUEST
  on PROCESSREQUEST (CASEID)
;

create table DEFAULTVALUES
(
  [IDENTITYID] int not null
    constraint R_91904
    references USERIDENTITY,
  [APPLICATIONNAME] nvarchar(128) not null,
  [FORMNAME] nvarchar(32) not null,
  [CONTROLNAME] nvarchar(32) not null,
  [DEFAULTVALUE] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDEFAULTVALUES
  primary key nonclustered (IDENTITYID, APPLICATIONNAME, FORMNAME, CONTROLNAME)
)
;

create table DISPLAYTABLECOLUMNS
(
  [IDENTITYID] int not null
    constraint R_91905
    references USERIDENTITY,
  [APPLICATIONNAME] nvarchar(128) not null,
  [FORMNAME] nvarchar(32) not null,
  [DISPLAYTABLENAME] nvarchar(32) not null,
  [COLUMNNAME] nvarchar(32) not null,
  [POSITION] smallint not null,
  [WIDTH] decimal(9,4),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDISPLAYTABLECOLUMNS
  primary key nonclustered (IDENTITYID, APPLICATIONNAME, FORMNAME, DISPLAYTABLENAME, COLUMNNAME)
)
;

create table FORMSETTINGS
(
  [IDENTITYID] int not null
    constraint R_91914
    references USERIDENTITY,
  [APPLICATIONNAME] nvarchar(128) not null,
  [FORMNAME] nvarchar(32) not null,
  [POSITIONX] decimal(9,4) not null,
  [POSITIONY] decimal(9,4) not null,
  [HEIGHT] decimal(9,4) not null,
  [WIDTH] decimal(9,4) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [WINDOWSTATE] tinyint,
  constraint XPKFORMSETTINGS
  primary key nonclustered (IDENTITYID, APPLICATIONNAME, FORMNAME)
)
;

create table TEMP_EMPLOYEE
(
  [NAMECODE] nvarchar(100),
  [NAME] nvarchar(100),
  [PROFITCENTRE] nvarchar(20)
)
;

create table NGB_TEMP
(
  [MAINCONTACT] nvarchar(326),
  [DEBTORNAME] nvarchar(305),
  [DEBTORCODE] nvarchar(10),
  [OPENITEMNO] nvarchar(12),
  [itemdate] varchar(10),
  [FOREIGNVALUE] decimal(10,2),
  [LOCALVALUE] decimal(10,2),
  [CURRENCY] nvarchar(3),
  [DISPLAYSEQENCE] smallint,
  [WIPCODE] nvarchar(6),
  [WIPTYPEID] nvarchar(6),
  [DESCRIPTION] nvarchar(50),
  [CATEGORYCODE] nvarchar(3),
  [IRN] nvarchar(30),
  [Title] nvarchar(80),
  [YourRef] nvarchar(80),
  [Owner] nvarchar(305),
  [STREET1] nvarchar(254),
  [PRINTDATE] datetime,
  [PRINTNAME] nvarchar(60),
  [PRINTCHARGEOUTRATE] decimal(11,2),
  [PRINTCHARGECURRENCY] nvarchar(3),
  [PRINTTOTALUNITS] smallint,
  [PRINTTIME] nvarchar(30),
  [UNITSPERHOUR] smallint,
  [SHORTNARRATIVE] nvarchar(254),
  [Value] decimal(11,2),
  [LONGNARRATIVE] ntext,
  [RE_INFORMATION] nvarchar(953)
)
;

create table temp_dat_cc
(
  [name] varchar(255) not null,
  [accountcode] varchar(50)
)
;

create table OPPORTUNITY
(
  [CASEID] int not null
    constraint XPKOPPORTUNITY
    primary key nonclustered
    constraint R_91425
    references CASES,
  [POTENTIALVALUE] decimal(11,2),
  [SOURCE] int
    constraint R_91426
    references TABLECODES,
  [EXPCLOSEDATE] datetime,
  [REMARKS] nvarchar(2000),
  [POTENTIALWIN] decimal(5,2),
  [NEXTSTEP] nvarchar(1000),
  [STAGE] int
    constraint R_91427
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [POTENTIALVALCURRENCY] nvarchar(3)
    constraint R_81484
    references CURRENCY,
  [NUMBEROFSTAFF] int,
  [REMARKS_TID] int
    constraint R_81485
    references TRANSLATEDITEMS,
  [NEXTSTEP_TID] int
    constraint R_81487
    references TRANSLATEDITEMS,
  [POTENTIALVALUELOCAL] decimal(11,2)
)
;

create index XIE1OPPORTUNITY
  on OPPORTUNITY (SOURCE)
;

create index XIE2OPPORTUNITY
  on OPPORTUNITY (STAGE)
;

create table STATUSCASETYPE
(
  [CASETYPE] nchar(1) not null
    constraint R_91428
    references CASETYPE,
  [STATUSCODE] smallint not null
    constraint R_91429
    references STATUS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTATUSCASETYPE
  primary key nonclustered (CASETYPE, STATUSCODE)
)
;

create table CASESEARCHRESULT
(
  [CASEPRIORARTID] int identity
    constraint XPKCASESEARCHRESULT
    primary key,
  [FAMILYPRIORARTID] int,
  [CASEID] int not null
    constraint R_91441
    references CASES,
  [PRIORARTID] int not null
    constraint R_91442
    references SEARCHRESULTS,
  [STATUS] int
    constraint R_91443
    references TABLECODES,
  [UPDATEDDATE] datetime not null,
  [CASEFIRSTLINKEDTO] bit,
  [CASELISTPRIORARTID] int,
  [NAMEPRIORARTID] int,
  [ISCASERELATIONSHIP] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CASESEARCHRESULT
  on CASESEARCHRESULT (STATUS)
;

create index XIE2CASESEARCHRESULT
  on CASESEARCHRESULT (LOGIDENTITYID, LOGDATETIMESTAMP)
;

create table FAMILYSEARCHRESULT
(
  [FAMILYPRIORARTID] int identity
    constraint XPKFAMILYSEARCHRESULT
    primary key,
  [FAMILY] nvarchar(20) not null
    constraint R_91439
    references CASEFAMILY,
  [PRIORARTID] int not null
    constraint R_91440
    references SEARCHRESULTS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CASESEARCHRESULT
  add constraint R_91511
foreign key (FAMILYPRIORARTID) references FAMILYSEARCHRESULT
;

create table AUDITLOGTABLES
(
  [TABLENAME] nvarchar(50) not null
    constraint XPKAUDITLOGTABLES
    primary key nonclustered,
  [LOGFLAG] bit default 0 not null,
  [REPLICATEFLAG] bit default 0 not null
)
;

create table TRUSTITEM
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [TACCTENTITYNO] int not null,
  [TACCTNAMENO] int not null,
  [ITEMNO] nvarchar(20) not null,
  [ITEMDATE] datetime not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [CLOSEPOSTDATE] datetime,
  [CLOSEPOSTPERIOD] int,
  [ITEMTYPE] int
    constraint R_91453
    references TABLECODES,
  [EMPLOYEENO] int
    constraint R_91454
    references NAME,
  [CURRENCY] nvarchar(3)
    constraint R_91455
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [LOCALVALUE] decimal(11,2),
  [FOREIGNVALUE] decimal(11,2),
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [STATUS] smallint
    constraint R_91456
    references TRANSACTION_STATUS,
  [DESCRIPTION] nvarchar(254),
  [LONGDESCRIPTION] ntext,
  [LOGUSERID] nvarchar(100),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(256),
  [LOGOFFICEID] int,
  constraint XPKTRUSTITEM
  primary key nonclustered (ITEMENTITYNO, ITEMTRANSNO, TACCTENTITYNO, TACCTNAMENO),
  constraint R_91451
  foreign key (ITEMENTITYNO, ITEMTRANSNO) references TRANSACTIONHEADER,
  constraint R_91452
  foreign key (TACCTENTITYNO, TACCTNAMENO) references TRUSTACCOUNT
)
;

create index XIE1TRUSTITEM
  on TRUSTITEM (ITEMTYPE)
;

create table NAMETYPECLASSIFICATION
(
  [NAMENO] int not null
    constraint R_1462
    references NAME,
  [NAMETYPE] nvarchar(3) not null
    constraint R_1463
    references NAMETYPE,
  [ALLOW] int,
  [LOGUSERID] varchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMETYPECLASSIFICATION
  primary key (NAMENO, NAMETYPE)
)
;

create table GENERICTEXT
(
  [TEXTNUMBER] int identity
    constraint XPKGENERICTEXT
    primary key nonclustered,
  [GENERICTEXT] nvarchar(4000) not null,
  [GENERICTEXT_TID] int
    constraint R_1468
    references TRANSLATEDITEMS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table LEDGERJOURNALLINEBALANCE_20090107
(
  [ACCTENTITYNO] int not null,
  [PROFITCENTRECODE] nvarchar(6) not null,
  [ACCOUNTID] int not null,
  [TRANPOSTPERIOD] int not null,
  [LOCALAMOUNTBALANCE] decimal(13,2) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TRUSTHISTORY
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [TACCTENTITYNO] int not null,
  [TACCTNAMENO] int not null,
  [HISTORYLINENO] smallint not null,
  [ITEMNO] nvarchar(20) not null,
  [TRANSDATE] datetime not null,
  [POSTDATE] datetime,
  [POSTPERIOD] int,
  [TRANSTYPE] smallint not null,
  [MOVEMENTCLASS] smallint not null,
  [COMMANDID] smallint not null,
  [LOCALVALUE] decimal(11,2),
  [EXCHVARIANCE] decimal(11,2),
  [FOREIGNTRANVALUE] decimal(11,2),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [FORCEDPAYOUT] decimal(1),
  [CURRENCY] nvarchar(3)
    constraint R_1198
    references CURRENCY,
  [EXCHRATE] decimal(8,4),
  [STATUS] smallint
    constraint R_91458
    references TRANSACTION_STATUS,
  [ASSOCLINENO] smallint,
  [ITEMIMPACT] smallint,
  [DESCRIPTION] nvarchar(254),
  [LONGDESCRIPTION] ntext,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKTRUSTHISTORY
  primary key (ITEMENTITYNO, ITEMTRANSNO, TACCTENTITYNO, TACCTNAMENO, HISTORYLINENO),
  constraint R_91457
  foreign key (ITEMENTITYNO, ITEMTRANSNO, TACCTENTITYNO, TACCTNAMENO) references TRUSTITEM,
  constraint R_132
  foreign key (REFENTITYNO, REFTRANSNO) references TRANSACTIONHEADER
)
;

create table NAMEADDRESSCPACLIENT
(
  [NAMENO] int not null,
  [ADDRESSTYPE] int not null,
  [ADDRESSCODE] int not null,
  [ALIASTYPE] nvarchar(2) not null
    constraint R_81470
    references ALIASTYPE,
  [CPACLIENTNO] int not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMEADDRESSCPACLIENT
  primary key nonclustered (NAMENO, ADDRESSTYPE, ADDRESSCODE, ALIASTYPE),
  constraint R_81469
  foreign key (NAMENO, ADDRESSTYPE, ADDRESSCODE) references NAMEADDRESS
)
;

create index XIE1NAMEADDRESSCPACLIENT
  on NAMEADDRESSCPACLIENT (CPACLIENTNO)
;

create table CASENAMEREQUEST
(
  [REQUESTNO] int identity
    constraint XPKCASENAMEREQUEST
    primary key,
  [NAMETYPE] nvarchar(3)
    constraint R_801471
    references NAMETYPE,
  [CURRENTNAMENO] int
    constraint R_801472
    references NAME,
  [NEWNAMENO] int
    constraint R_801474
    references NAME,
  [NEWATTENTION] int
    constraint R_801475
    references NAME,
  [NEWREFERENCE] nvarchar(80),
  [COMMENCEDATE] datetime,
  [ADDRESSCODE] int
    constraint R_801479
    references ADDRESS,
  [UPDATEFLAG] bit default 1 not null,
  [INSERTFLAG] bit default 0 not null,
  [DELETEFLAG] bit default 0 not null,
  [KEEPATTENTIONFLAG] bit default 0 not null,
  [KEEPREFERENCEFLAG] tinyint default 2 not null,
  [INHERITANCEFLAG] bit default 1 not null,
  [PROGRAMID] nvarchar(20),
  [ONHOLDFLAG] bit default 0 not null,
  [EDEBATCHNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [CURRENTATTENTION] int
    constraint R_801473
    references NAME,
  [IDENTITYID] int,
  [NOUPDATEDROWS] int,
  [NOINSERTEDROWS] int,
  [NODELETEDROWS] int
)
;

create index XIE1CASENAMEREQUEST
  on CASENAMEREQUEST (EDEBATCHNO)
;

create index XIE2CASENAMEREQUEST
  on CASENAMEREQUEST (IDENTITYID)
;

create table CASENAMEREQUESTCASES
(
  [REQUESTNO] int not null
    constraint R_801477
    references CASENAMEREQUEST,
  [CASEID] int not null
    constraint R_801478
    references CASES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASENAMEREQUESTCASES
  primary key (REQUESTNO, CASEID)
)
;

create index XIE1CASENAMEREQUESTCASES
  on CASENAMEREQUESTCASES (CASEID)
;

create table WIP_RECAL4
(
  [CASEID] int,
  [USERCODE] varchar(10)
)
;

create table LEADDETAILS
(
  [NAMENO] int not null
    constraint XPKLEADDETAILS
    primary key nonclustered
    constraint R_81488
    references NAME,
  [LEADSOURCE] int
    constraint R_81489
    references TABLECODES,
  [ESTIMATEDREV] decimal(11,2),
  [ESTREVCURRENCY] nvarchar(3)
    constraint R_81490
    references CURRENCY,
  [COMMENTS] nvarchar(3000),
  [COMMENTS_TID] int
    constraint R_81491
    references TRANSLATEDITEMS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ESTIMATEDREVLOCAL] decimal(11,2)
)
;

create index XIE1LEADDETAILS
  on LEADDETAILS (LEADSOURCE)
;

create table LEADSTATUSHISTORY
(
  [NAMENO] int not null
    constraint R_81492
    references NAME,
  [LEADSTATUSID] int identity,
  [LEADSTATUS] int
    constraint R_81493
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKLEADSTATUSHISTORY
  primary key nonclustered (NAMENO, LEADSTATUSID)
)
;

create index XIE1LEADSTATUSHISTORY
  on LEADSTATUSHISTORY (LEADSTATUS)
;

create table CRMCASESTATUSHISTORY
(
  [CASEID] int not null
    constraint R_81480
    references CASES,
  [STATUSID] int identity,
  [CRMCASESTATUS] int
    constraint R_81481
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [POTENTIALVALUELOCAL] decimal(11,2),
  [ACTUALCOSTLOCAL] decimal(11,2),
  [BUDGETAMOUNT] decimal(11,2),
  constraint XPKCRMCASESTATUSHISTORY
  primary key nonclustered (CASEID, STATUSID)
)
;

create index XIE1CRMCASESTATUSHISTORY
  on CRMCASESTATUSHISTORY (CRMCASESTATUS)
;

create table MARKETING
(
  [CASEID] int not null
    constraint XPKMARKETING
    primary key nonclustered
    constraint R_81482
    references CASES,
  [ACTUALCOST] decimal(11,2),
  [ACTUALCOSTCURRENCY] nvarchar(3)
    constraint R_81483
    references CURRENCY,
  [NUMBERCONTACTED] int,
  [NUMBEROFRESPONSES] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [ACTUALCOSTLOCAL] decimal(11,2),
  [EXPECTEDRESPONSES] int,
  [STAFFATTENDED] int,
  [CONTACTSATTENDED] int
)
;

create table CONFIGURATIONITEM
(
  [CONFIGITEMID] int identity
    constraint XPKCONFIGURATIONITEM
    primary key nonclustered,
  [TASKID] smallint not null
    constraint R_81514
    references TASK,
  [CONTEXTID] int
    constraint R_81515
    references QUERYCONTEXT,
  [TITLE] nvarchar(508),
  [TITLE_TID] int,
  [DESCRIPTION] nvarchar(2000),
  [DESCRIPTION_TID] int,
  [GENERICPARAM] nvarchar(15),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1CONFIGURATIONITEM
  on CONFIGURATIONITEM (TASKID, CONTEXTID, GENERICPARAM)
;

create table TOPICS
(
  [TOPICNAME] nvarchar(50) not null,
  [TOPICTYPE] nvarchar(20) not null,
  constraint XPKTOPICS
  primary key nonclustered (TOPICNAME, TOPICTYPE)
)
;

create table NAMECRITERIA
(
  [PURPOSECODE] nchar(1) not null,
  [PROGRAMID] nvarchar(8)
    constraint R_81574
    references PROGRAM,
  [USEDASFLAG] smallint,
  [SUPPLIERFLAG] bit,
  [DATAUNKNOWN] bit default 0 not null,
  [COUNTRYCODE] nvarchar(3)
    constraint R_81516
    references COUNTRY,
  [LOCALCLIENTFLAG] bit,
  [CATEGORY] int,
  [NAMETYPE] nvarchar(3)
    constraint R_81517
    references NAMETYPE,
  [USERDEFINEDRULE] bit default 0 not null,
  [RULEINUSE] bit default 1 not null,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [RELATIONSHIP] nvarchar(3)
    constraint R_81573
    references NAMERELATION,
  [NAMECRITERIANO] int not null
    constraint XPKNAMECRITERIA
    primary key nonclustered,
  [PROFILEID] int
)
;

create table WINDOWCONTROL
(
  [WINDOWCONTROLNO] int identity
    constraint XPKWINDOWCONTROL
    primary key nonclustered,
  [CRITERIANO] int
    constraint R_81518
    references CRITERIA,
  [NAMECRITERIANO] int
    constraint R_81519
    references NAMECRITERIA,
  [WINDOWNAME] nvarchar(50) not null,
  [ISEXTERNAL] bit default 0 not null,
  [DISPLAYSEQUENCE] smallint,
  [WINDOWTITLE] nvarchar(254),
  [WINDOWTITLE_TID] int,
  [WINDOWSHORTTITLE] nvarchar(254),
  [WINDOWSHORTTITLE_TID] int,
  [ENTRYNUMBER] smallint,
  [THEME] nvarchar(50),
  [ISINHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table TABCONTROL
(
  [TABCONTROLNO] int identity
    constraint XPKTABCONTROL
    primary key nonclustered,
  [WINDOWCONTROLNO] int not null
    constraint R_81520
    references WINDOWCONTROL,
  [TABNAME] nvarchar(50) not null,
  [DISPLAYSEQUENCE] smallint default 0 not null,
  [TABTITLE] nvarchar(254),
  [TABTITLE_TID] int,
  [ISINHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1TABCONTROL
  on TABCONTROL (WINDOWCONTROLNO, TABNAME)
;

create table TOPICCONTROL
(
  [TOPICCONTROLNO] int identity
    constraint XPKTOPICCONTROL
    primary key nonclustered,
  [WINDOWCONTROLNO] int not null
    constraint R_81521
    references WINDOWCONTROL,
  [TOPICNAME] nvarchar(50) not null,
  [TOPICSUFFIX] nvarchar(50),
  [ROWPOSITION] smallint default 0 not null,
  [COLPOSITION] smallint default 0 not null,
  [TABCONTROLNO] int
    constraint R_81522
    references TABCONTROL,
  [TOPICTITLE] nvarchar(254),
  [TOPICTITLE_TID] int,
  [TOPICSHORTTITLE] nvarchar(254),
  [TOPICSHORTTITLE_TID] int,
  [TOPICDESCRIPTION] nvarchar(254),
  [TOPICDESCRIPTION_TID] int,
  [DISPLAYDESCRIPTION] bit default 0 not null,
  [SCREENTIP] nvarchar(254),
  [SCREENTIP_TID] int,
  [ISHIDDEN] bit default 0 not null,
  [ISMANDATORY] bit default 0 not null,
  [ISINHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FILTERNAME] nvarchar(50),
  [FILTERVALUE] nvarchar(254)
)
;

create unique index XAK1TOPICCONTROL
  on TOPICCONTROL (WINDOWCONTROLNO, TOPICNAME, TOPICSUFFIX)
;

create table ELEMENTCONTROL
(
  [ELEMENTCONTROLNO] int identity
    constraint XPKELEMENTCONTROL
    primary key nonclustered,
  [TOPICCONTROLNO] int not null
    constraint R_81523
    references TOPICCONTROL,
  [ELEMENTNAME] nvarchar(50) not null,
  [SHORTLABEL] nvarchar(254),
  [SHORTLABEL_TID] int,
  [FULLLABEL] nvarchar(254),
  [FULLLABEL_TID] int,
  [BUTTON] nvarchar(254),
  [BUTTON_TID] int,
  [TOOLTIP] nvarchar(254),
  [TOOLTIP_TID] int,
  [LINK] nvarchar(254),
  [LINK_TID] int,
  [LITERAL] nvarchar(254),
  [LITERAL_TID] int,
  [DEFAULTVALUE] nvarchar(254),
  [ISHIDDEN] bit default 0 not null,
  [ISMANDATORY] bit default 0 not null,
  [ISREADONLY] bit default 0 not null,
  [ISINHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [FILTERNAME] nvarchar(50),
  [FILTERVALUE] nvarchar(254)
)
;

create unique index XAK1ELEMENTCONTROL
  on ELEMENTCONTROL (TOPICCONTROLNO, ELEMENTNAME)
;

create table BUSINESSRULECONTROL
(
  [BUSINESSRULENO] int identity
    constraint XPKBUSINESSRULECONTROL
    primary key nonclustered,
  [TOPICCONTROLNO] int not null
    constraint R_81524
    references TOPICCONTROL,
  [RULETYPE] nvarchar(30) not null,
  [SEQUENCE] smallint default 0 not null,
  [VALUE] nvarchar(254),
  [ISINHERITED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1BUSINESSRULECONTROL
  on BUSINESSRULECONTROL (TOPICCONTROLNO, RULETYPE, SEQUENCE)
;

create table NAMECRITERIAINHERITS
(
  [NAMECRITERIANO] int not null
    constraint R_81531
    references NAMECRITERIA,
  [FROMNAMECRITERIANO] int not null
    constraint R_81532
    references NAMECRITERIA,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMECRITERIAINHERITS
  primary key nonclustered (NAMECRITERIANO, FROMNAMECRITERIANO)
)
;

create table POLICINGUPDATEQUEUE
(
  [QUEUEID] int identity
    constraint XPKPOLICINGUPDATEQUEUE
    primary key nonclustered,
  [SPID] int not null,
  [QUEUETIME] datetime default getdate() not null,
  [STARTTIME] datetime,
  [ENDTIME] datetime,
  [RESETFLAG] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1POLICINGUPDATEQUEUE
  on POLICINGUPDATEQUEUE (ENDTIME)
;

create table BACKGROUNDPROCESS
(
  [PROCESSID] int identity
    constraint XPKBACKGROUNDPROCESS
    primary key nonclustered,
  [IDENTITYID] int not null,
  [PROCESSTYPE] nvarchar(30),
  [STATUS] int,
  [STATUSDATE] datetime,
  [STATUSINFO] nvarchar(1000),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1BACKGROUNDPROCESS
  on BACKGROUNDPROCESS (IDENTITYID)
;

create table BILLMAPPROFILE
(
  [BILLMAPPROFILEID] int identity
    constraint XPKBILLMAPPROFILE
    primary key nonclustered,
  [BILLMAPDESC] nvarchar(100) not null,
  [SCHEMANAME] nvarchar(100),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table IPNAME
  add constraint R_81565
foreign key (BILLMAPPROFILEID) references BILLMAPPROFILE
;

create table FORMATPROFILE
(
  [FORMATID] int identity
    constraint XPKFORMATPROFILE
    primary key nonclustered,
  [PRESENTATIONID] int
    constraint R_81564
    references QUERYPRESENTATION,
  [CONSOLIDATIONFLAG] bit default 0,
  [SINGLEDISCOUNT] bit default 0,
  [FORMATDESC] nvarchar(100) not null,
  [WEBSERVICE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table ASSOCIATEDNAME
  add constraint R_81612
foreign key (FORMATPROFILEID) references FORMATPROFILE
;

alter table BILLFORMAT
  add constraint R_81606
foreign key (FORMATPROFILEID) references FORMATPROFILE
;

alter table IPNAME
  add constraint R_81566
foreign key (BILLFORMATID) references FORMATPROFILE
;

create table VALIDTABLECODES
(
  [VALIDTABLECODEID] int identity
    constraint XPKVALIDTABLECODES
    primary key nonclustered,
  [TABLECODE] int
    constraint R_81571
    references TABLECODES,
  [VALIDTABLECODE] int
    constraint R_81570
    references TABLECODES,
  [VALIDTABLETYPE] smallint
    constraint R_81572
    references TABLETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1VALIDTABLECODES
  on VALIDTABLECODES (TABLECODE, VALIDTABLECODE, VALIDTABLETYPE)
;

create index XIE1VALIDTABLECODES
  on VALIDTABLECODES (VALIDTABLECODE)
;

create index XIE2VALIDTABLECODES
  on VALIDTABLECODES (TABLECODE)
;

create table PROFILES
(
  [PROFILEID] int identity
    constraint XPKPROFILES
    primary key nonclustered,
  [PROFILENAME] nvarchar(50) not null,
  [PROFILENAME_TID] int,
  [DESCRIPTION] nvarchar(254),
  [DESCRIPTION_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

alter table CRITERIA
  add constraint R_81586
foreign key (PROFILEID) references PROFILES
;

alter table USERIDENTITY
  add constraint R_81584
foreign key (PROFILEID) references PROFILES
;

alter table NAMECRITERIA
  add constraint R_81585
foreign key (PROFILEID) references PROFILES
;

create table ATTRIBUTES
(
  [ATTRIBUTEID] int identity
    constraint XPKATTRIBUTES
    primary key nonclustered,
  [ATTRIBUTENAME] nvarchar(50) not null,
  [DATATYPE] nvarchar(30) not null,
  [TABLENAME] nvarchar(100),
  [FILTERVALUE] nvarchar(1000),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table PROFILEATTRIBUTES
(
  [PROFILEID] int not null
    constraint R_81581
    references PROFILES,
  [ATTRIBUTEID] int not null
    constraint R_81583
    references ATTRIBUTES,
  [ATTRIBUTEVALUE] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKPROFILEATTRIBUTES
  primary key nonclustered (PROFILEID, ATTRIBUTEID)
)
;

create table EDERULESPECIALISSUE
(
  [CRITERIANO] int not null
    constraint R_81588
    references CRITERIA,
  [ISSUEID] int not null
    constraint R_81589
    references EDESTANDARDISSUE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKEDERULESPECIALISSUE
  primary key nonclustered (CRITERIANO, ISSUEID)
)
;

create table CASECHARGESCACHE
(
  [CASEID] int not null
    constraint R_81590
    references CASES,
  [CHARGETYPENO] int not null
    constraint R_81591
    references CHARGETYPE,
  [WHENCALCULATED] datetime default getdate() not null,
  [YEARNO] smallint,
  [FROMDATE] datetime,
  [SPIDREQUEST] int,
  [BILLCURRENCY] nvarchar(3)
    constraint R_81592
    references CURRENCY,
  [TOTALYEARVALUE] decimal(11,2),
  [TOTALVALUE] decimal(11,2),
  [DEFINITIONID] int
    constraint R_81593
    references INSTRUCTIONDEFINITION,
  [INSTRUCTIONCYCLEANY] int,
  [FEEYEARNOANY] bit,
  [FEEDUEDATEANY] bit,
  constraint XPKCASECHARGESCACHE
  primary key nonclustered (CASEID, CHARGETYPENO, WHENCALCULATED)
)
;

create index XIE1CASECHARGESCACHE
  on CASECHARGESCACHE (CHARGETYPENO)
;

create index XIE2CASECHARGESCACHE
  on CASECHARGESCACHE (BILLCURRENCY)
;

create index XIE3CASECHARGESCACHE
  on CASECHARGESCACHE (WHENCALCULATED, SPIDREQUEST)
;

create table GNCCOUNTRESULT
(
  [PROCESSID] int not null
    constraint XPKGNCCOUNTRESULT
    primary key nonclustered
    constraint R_81596
    references BACKGROUNDPROCESS,
  [NOUPDATEDROWS] int,
  [NOINSERTEDROWS] int,
  [NODELETEDROWS] int
)
;

create table GNCCHANGEDCASES
(
  [PROCESSID] int not null
    constraint R_81597
    references BACKGROUNDPROCESS,
  [CASEID] int not null
    constraint R_81598
    references CASES,
  constraint XPKGNCCHANGEDCASES
  primary key nonclustered (PROCESSID, CASEID)
)
;

create table PROFILEPROGRAM
(
  [PROFILEID] int not null
    constraint R_81599
    references PROFILES,
  [PROGRAMID] nvarchar(8) not null
    constraint R_81600
    references PROGRAM,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKPROFILEPROGRAM
  primary key nonclustered (PROFILEID, PROGRAMID)
)
;

create table TOPICDEFAULTSETTINGS
(
  [DEFAULTSETTINGNO] int identity
    constraint XPKTOPICDEFAULTSETTINGS
    primary key nonclustered,
  [CRITERIANO] int
    constraint R_81604
    references CRITERIA,
  [NAMECRITERIANO] int
    constraint R_81605
    references NAMECRITERIA,
  [TOPICNAME] nvarchar(50) not null,
  [FILTERNAME] nvarchar(50) not null,
  [FILTERVALUE] nvarchar(254) not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table NAMEEXEMPTCHARGES
(
  [NAMENO] int not null
    constraint R_81607
    references NAME,
  [RATENO] int not null
    constraint R_81608
    references RATES,
  [NOTES] nvarchar(254),
  [NOTES_TID] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKNAMEEXEMPTCHARGES
  primary key nonclustered (NAMENO, RATENO)
)
;

create table Temp_NameCode_MatchUp
(
  [Old_NameCode] nvarchar(255),
  [New_NameCode] nvarchar(255),
  [NAME] nvarchar(255),
  [NAMENO] int
)
;

create table BILLMAPRULES
(
  [MAPRULEID] int identity
    constraint XPKBILLMAPRULES
    primary key nonclustered,
  [BILLMAPPROFILEID] int not null
    constraint R_81619
    references BILLMAPPROFILE,
  [FIELDCODE] int not null
    constraint R_81620
    references TABLECODES,
  [WIPCODE] nvarchar(10),
  [WIPTYPEID] nvarchar(10),
  [WIPCATEGORY] nvarchar(3)
    constraint R_81621
    references WIPCATEGORY,
  [NARRATIVECODE] nvarchar(10),
  [STAFFCLASS] int
    constraint R_81631
    references TABLECODES,
  [ENTITYNO] int
    constraint R_81623
    references SPECIALNAME,
  [OFFICEID] int
    constraint R_81624
    references OFFICE,
  [CASETYPE] nchar(1)
    constraint R_81625
    references CASETYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_81626
    references COUNTRY,
  [PROPERTYTYPE] nchar(1)
    constraint R_81627
    references PROPERTYTYPE,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_81628
    references SUBTYPE,
  [BASIS] nvarchar(2)
    constraint R_81629
    references APPLICATIONBASIS,
  [STATUS] smallint
    constraint R_81630
    references STATUS,
  [MAPPEDVALUE] nvarchar(254),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1BILLMAPRULES
  on BILLMAPRULES (BILLMAPPROFILEID)
;

create index XIE2BILLMAPRULES
  on BILLMAPRULES (FIELDCODE)
;

create table STANDINGTEMPLTPAY
(
  [TEMPLATENO] int not null
    constraint XPKSTANDINGTEMPLTPAY
    primary key nonclustered
    constraint R_81632
    references STANDINGTEMPLT,
  [ACCTNAMENO] int
    constraint R_81633
    references CREDITOR,
  [PAYMENTMETHOD] int
    constraint R_81634
    references PAYMENTMETHODS,
  [ACCOUNTOWNER] int,
  [BANKNAMENO] int,
  [BANKSEQUENCENO] int,
  [BANKCHARGES] decimal(9,2),
  [ACCTCREDITORNO] int
    constraint R_81636
    references CREDITOR,
  [PAYMENTTERMNO] int
    constraint R_81637
    references FREQUENCY,
  [RESTRICTIONID] int
    constraint R_81638
    references CRRESTRICTION,
  [RESTNREASONCODE] nvarchar(2)
    constraint R_81639
    references REASON,
  [BANKOPERATIONCODE] int
    constraint R_81640
    references TABLECODES,
  [DETAILSOFCHARGES] int
    constraint R_81641
    references TABLECODES,
  [EFTFILEFORMAT] int
    constraint R_81642
    references TABLECODES,
  [INSTRUCTIONCODE] int
    constraint R_81643
    references TABLECODES,
  [PAYMENTCURRENCY] nvarchar(3)
    constraint R_81644
    references CURRENCY,
  [PAYMENTAMOUNT] decimal(13,2),
  [TAXTREATMENT] int
    constraint R_81660
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint R_81635
  foreign key (ACCOUNTOWNER, BANKNAMENO, BANKSEQUENCENO) references BANKACCOUNT
)
;

create table STANDINGTEMPLTTAX
(
  [TEMPLATENO] int not null
    constraint R_81645
    references STANDINGTEMPLT,
  [TAXCODE] nvarchar(3) not null
    constraint R_81646
    references taxrates,
  [COUNTRYCODE] nvarchar(3)
    constraint R_81647
    references COUNTRY,
  [CURRENCY] nvarchar(3)
    constraint R_81648
    references CURRENCY,
  [TAXRATE] decimal(8,4),
  [TAXABLEAMOUNT] decimal(11,2),
  [TAXAMOUNT] decimal(11,2),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKSTANDINGTEMPLTTAX
  primary key nonclustered (TEMPLATENO, TAXCODE)
)
;

create table CASEINSTRUCTIONS
(
  [CASEID] int not null
    constraint R_81650
    references CASES,
  [INSTRUCTIONTYPE] nvarchar(3) not null
    constraint R_81651
    references INSTRUCTIONTYPE,
  [INSTRUCTIONCODE] smallint
    constraint R_81652
    references INSTRUCTIONS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKCASEINSTRUCTIONS
  primary key nonclustered (CASEID, INSTRUCTIONTYPE)
)
;

create index XIE1CASEINSTRUCTIONS
  on CASEINSTRUCTIONS (INSTRUCTIONTYPE)
;

create index XIE2CASEINSTRUCTIONS
  on CASEINSTRUCTIONS (INSTRUCTIONCODE)
;

create table CASEINSTRUCTIONSRECALC
(
  [REQUESTNO] int identity
    constraint XPKCASEINSTRUCTIONSRECALC
    primary key nonclustered,
  [CASEID] int
    constraint R_81653
    references CASES,
  [NAMENO] int
    constraint R_81654
    references NAME,
  [ONHOLDFLAG] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CASEINSTRUCTIONSRECALC
  on CASEINSTRUCTIONSRECALC (CASEID)
;

create index XIE2CASEINSTRUCTIONSRECALC
  on CASEINSTRUCTIONSRECALC (NAMENO)
;

create table OPENITEMCOPYTO
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [ACCTENTITYNO] int not null,
  [ACCTDEBTORNO] int not null,
  [NAMESNAPNO] int not null
    constraint R_81658
    references NAMEADDRESSSNAP,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOPENITEMCOPYTO
  primary key nonclustered (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO, NAMESNAPNO),
  constraint R_81694
  foreign key (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO) references OPENITEM
)
;

create index XIE1OPENITEMCOPYTO
  on OPENITEMCOPYTO (ITEMENTITYNO, ITEMTRANSNO, ACCTENTITYNO, ACCTDEBTORNO)
;

create table DISCOUNTBASEDONINVOICE
(
  [NAMENO] int not null
    constraint XPKDISCOUNTBASEDONINVOICE
    primary key nonclustered
    constraint R_81661
    references NAME,
  [STARTDATE] datetime,
  [PERIOD] int,
  PERIODTYPE nvarchar(1),
  [INVOICE] decimal(11,2),
  [DISCOUNTRATE] decimal(6,3),
  [RESETFLAG] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [OWNERNO] int
    constraint R_81710
    references NAME,
  [INSTRUCTORNO] int
    constraint R_81711
    references NAME,
  [PROPERTYTYPE] nchar(1)
    constraint R_81712
    references PROPERTYTYPE
)
;

create table DISCOUNTBASEDONNOOFCASES
(
  [NAMENO] int not null
    constraint R_81662
    references NAME,
  [PROPERTYTYPE] nchar(1) not null,
  [SEQUENCE] int not null,
  [FROMCASES] smallint,
  [TOCASES] smallint,
  [DISCOUNTRATE] decimal(6,3),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKDISCOUNTBASEDONNOOFCASES
  primary key nonclustered (NAMENO, PROPERTYTYPE, SEQUENCE)
)
;

create table OPENITEMXML
(
  [ITEMENTITYNO] int not null,
  [ITEMTRANSNO] int not null,
  [XMLTYPE] tinyint not null,
  [OPENITEMXML] xml not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKOPENITEMXML
  primary key nonclustered (ITEMENTITYNO, ITEMTRANSNO, XMLTYPE),
  constraint R_81665
  foreign key (ITEMENTITYNO, ITEMTRANSNO) references TRANSACTIONHEADER
)
;

create table DATAVALIDATION
(
  [VALIDATIONID] int identity
    constraint XPKDATAVALIDATION
    primary key nonclustered,
  [INUSEFLAG] bit default 1 not null,
  [DEFERREDFLAG] bit default 0 not null,
  [OFFICEID] int
    constraint R_81666
    references OFFICE,
  [FUNCTIONALAREA] nchar(1),
  [CASETYPE] nchar(1)
    constraint R_81667
    references CASETYPE,
  [COUNTRYCODE] nvarchar(3)
    constraint R_81668
    references COUNTRY,
  [PROPERTYTYPE] nchar(1)
    constraint R_81669
    references PROPERTYTYPE,
  [CASECATEGORY] nvarchar(2),
  [SUBTYPE] nvarchar(2)
    constraint R_81670
    references SUBTYPE,
  [BASIS] nvarchar(2)
    constraint R_81671
    references APPLICATIONBASIS,
  [EVENTNO] int
    constraint R_81672
    references EVENTS,
  [EVENTDATEFLAG] smallint,
  [STATUSFLAG] smallint,
  [FAMILYNO] smallint
    constraint R_81673
    references NAMEFAMILY,
  [LOCALCLIENTFLAG] bit,
  [USEDASFLAG] smallint,
  [SUPPLIERFLAG] bit,
  [CATEGORY] int
    constraint R_81674
    references TABLECODES,
  [NAMENO] int
    constraint R_81675
    references NAME,
  [NAMETYPE] nvarchar(3)
    constraint R_81676
    references NAMETYPE,
  [INSTRUCTIONTYPE] nvarchar(3),
  [FLAGNUMBER] smallint,
  [COLUMNNAME] int
    constraint R_81679
    references TABLECODES,
  [RULEDESCRIPTION] nvarchar(254),
  [ITEM_ID] int
    constraint R_81690
    references ITEM,
  [ROLEID] int
    constraint R_81688
    references ROLE,
  [PROGRAMCONTEXT] int
    constraint R_81684
    references TABLECODES,
  [WARNINGFLAG] bit,
  [DISPLAYMESSAGE] nvarchar(max),
  [NOTES] nvarchar(max),
  [DISPLAYMESSAGE_TID] int
    constraint R_81685
    references TRANSLATEDITEMS,
  [RULEDESCRIPTION_TID] int
    constraint R_81686
    references TRANSLATEDITEMS,
  [NOTES_TID] int
    constraint R_81687
    references TRANSLATEDITEMS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  [NOTCASETYPE] bit,
  [NOTCOUNTRYCODE] bit,
  [NOTPROPERTYTYPE] bit,
  [NOTCASECATEGORY] bit,
  [NOTSUBTYPE] bit,
  [NOTBASIS] bit,
  constraint R_81689
  foreign key (INSTRUCTIONTYPE, FLAGNUMBER) references INSTRUCTIONLABEL
)
;

create index XIE1DATAVALIDATION
  on DATAVALIDATION (CATEGORY)
;

create index XIE2DATAVALIDATION
  on DATAVALIDATION (COLUMNNAME)
;

create index XIE3DATAVALIDATION
  on DATAVALIDATION (NAMENO)
;

create index XIE4DATAVALIDATION
  on DATAVALIDATION (EVENTNO)
;

create table DATAVALIDATIONREQUEST
(
  [REQUESTNO] int identity
    constraint XPKDATAVALIDATIONREQUEST
    primary key nonclustered,
  [VALIDATIONID] int not null
    constraint R_81681
    references DATAVALIDATION,
  [CASEID] int
    constraint R_81682
    references CASES,
  [NAMENO] int
    constraint R_81683
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1DATAVALIDATIONREQUEST
  on DATAVALIDATIONREQUEST (VALIDATIONID, CASEID, NAMENO)
;

create index XIE1DATAVALIDATIONREQUEST
  on DATAVALIDATIONREQUEST (CASEID)
;

create index XIE2DATAVALIDATIONREQUEST
  on DATAVALIDATIONREQUEST (NAMENO)
;

create table WIPPAYMENT
(
  [ENTITYNO] int not null,
  [TRANSNO] int not null,
  [WIPSEQNO] smallint not null,
  [HISTORYLINENO] smallint not null,
  [ACCTDEBTORNO] int not null,
  [PAYMENTSEQNO] smallint not null,
  [WIPCODE] nvarchar(6) not null
    constraint R_81693
    references WIPTEMPLATE,
  [LOCALTRANSVALUE] decimal(11,2),
  [FOREIGNTRANSVALUE] decimal(11,2),
  [LOCALBALANCE] decimal(11,2),
  [FOREIGNBALANCE] decimal(11,2),
  [FOREIGNCURRENCY] nvarchar(3),
  [REFENTITYNO] int,
  [REFTRANSNO] int,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKWIPPAYMENT
  primary key nonclustered (ENTITYNO, TRANSNO, WIPSEQNO, HISTORYLINENO, ACCTDEBTORNO, PAYMENTSEQNO),
  constraint R_81692
  foreign key (ENTITYNO, TRANSNO, WIPSEQNO, HISTORYLINENO) references WORKHISTORY
)
;

create index XIE1WIPPAYMENT
  on WIPPAYMENT (ENTITYNO, TRANSNO, WIPSEQNO, HISTORYLINENO)
;

create table REPORTRECIPIENT
(
  [REPORTRECIPIENTID] int identity
    constraint XPKREPORTRECIPIENT
    primary key nonclustered,
  [REQUESTID] nvarchar(50),
  [REPORTID] int
    constraint R_81695
    references TABLECODES,
  [NAMENO] int
    constraint R_81696
    references NAME,
  [DELIVERYMETHOD] int
    constraint R_81697
    references TABLECODES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1REPORTRECIPIENT
  on REPORTRECIPIENT (REQUESTID, REPORTID, NAMENO)
;

create table SUBSCRIPTIONFILTER
(
  [SUBSCRIPTIONFILTERID] int identity
    constraint XPKSUBSCRIPTIONFILTER
    primary key nonclustered,
  [REQUESTID] nvarchar(50) not null,
  [REPORTID] int
    constraint R_81698
    references TABLECODES,
  [PARAMETERNAME] nvarchar(128),
  [DATATYPE] nvarchar(1),
  [COLINTEGER] int,
  [COLDECIMAL] decimal(12,2),
  [COLCHARACTER] nvarchar(256),
  [COLDATE] datetime,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create unique index XAK1SUBSCRIPTIONFILTER
  on SUBSCRIPTIONFILTER (REQUESTID, PARAMETERNAME)
;

create table GLOBALCASECHANGECASES
(
  [PROCESSID] int not null
    constraint R_81700
    references BACKGROUNDPROCESS,
  [CASEID] int not null
    constraint R_81701
    references CASES,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLOBALCASECHANGECASES
  primary key nonclustered (PROCESSID, CASEID)
)
;

create table GLOBALCASECHANGEREQUEST
(
  [PROCESSID] int not null
    constraint XPKGLOBALCASECHANGEREQUEST
    primary key nonclustered
    constraint R_81699
    references BACKGROUNDPROCESS,
  [OFFICEID] int,
  [FAMILY] nvarchar(20),
  [TITLE] nvarchar(254),
  [TEXTTYPE] nvarchar(2),
  [CLASS] nvarchar(100),
  [LANGUAGE] int,
  [TEXT] nvarchar(max),
  [ISTEXTAPPEND] bit,
  [STATUSCODE] smallint,
  [STATUSCONFIRM] nvarchar(254),
  [FILELOCATION] int,
  [FILEPARTID] smallint,
  [WHENMOVED] datetime,
  [ISSUEDBY] int,
  [BAYNO] nvarchar(20),
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table GLOBALCASECHANGERESULTS
(
  [PROCESSID] int not null
    constraint R_81702
    references BACKGROUNDPROCESS,
  [CASEID] int not null
    constraint R_81703
    references CASES,
  [CASETEXTUPDATED] bit default 0 not null,
  [STATUSUPDATED] bit default 0 not null,
  [FILELOCATIONUPDATED] bit default 0 not null,
  [TITLEUPDATED] bit default 0 not null,
  [OFFICEUPDATED] bit default 0 not null,
  [FAMILYUPDATED] bit default 0 not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKGLOBALCASECHANGERESULTS
  primary key nonclustered (PROCESSID, CASEID)
)
;

create table REPORTCITATIONS
(
  [SEARCHREPORTID] int not null
    constraint R_1714
    references SEARCHRESULTS,
  [CITEDPRIORARTID] int not null
    constraint R_1716
    references SEARCHRESULTS,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKREPORTCITATIONS
  primary key nonclustered (SEARCHREPORTID, CITEDPRIORARTID)
)
;

create index XIE1REPORTCITATIONS
  on REPORTCITATIONS (CITEDPRIORARTID)
;

create table CASELISTSEARCHRESULT
(
  [CASELISTPRIORARTID] int identity
    constraint XPKCASELISTSEARCHRESULT
    primary key nonclustered,
  [PRIORARTID] int
    constraint R_1720
    references SEARCHRESULTS,
  [CASELISTNO] int
    constraint R_1719
    references CASELIST,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1CASELISTSEARCHRESULT
  on CASELISTSEARCHRESULT (PRIORARTID)
;

alter table CASESEARCHRESULT
  add constraint R_1731
foreign key (CASELISTPRIORARTID) references CASELISTSEARCHRESULT
;

create table NAMESEARCHRESULT
(
  [NAMEPRIORARTID] int identity
    constraint XPKNAMESEARCHRESULT
    primary key nonclustered,
  [PRIORARTID] int
    constraint R_1723
    references SEARCHRESULTS,
  [NAMENO] int
    constraint R_1721
    references NAME,
  [NAMETYPE] nvarchar(3)
    constraint R_1722
    references NAMETYPE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1NAMESEARCHRESULT
  on NAMESEARCHRESULT (PRIORARTID)
;

alter table CASESEARCHRESULT
  add constraint R_1730
foreign key (NAMEPRIORARTID) references NAMESEARCHRESULT
;

create table DATAVALIDATIONFAILLOG
(
  [VALIDATIONLOGID] int identity
    constraint XPKDATAVALIDATIONFAILLOG
    primary key nonclustered,
  [IDENTITYID] int not null
    constraint R_1733
    references USERIDENTITY,
  [VALIDATIONID] int not null
    constraint R_1734
    references DATAVALIDATION,
  [CASEID] int
    constraint R_1735
    references CASES,
  [NAMENO] int
    constraint R_1736
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create index XIE1DATAVALIDATIONFAILLOG
  on DATAVALIDATIONFAILLOG (IDENTITYID)
;

create index XIE2DATAVALIDATIONFAILLOG
  on DATAVALIDATIONFAILLOG (VALIDATIONID)
;

create index XIE3DATAVALIDATIONFAILLOG
  on DATAVALIDATIONFAILLOG (CASEID)
;

create index XIE4DATAVALIDATIONFAILLOG
  on DATAVALIDATIONFAILLOG (NAMENO)
;

create table RFIDFILEREQUEST
(
  [REQUESTID] int identity
    constraint XPKRFIDFILEREQUEST
    primary key nonclustered,
  [CASEID] int not null
    constraint R_81744
    references CASES,
  [FILELOCATION] int not null
    constraint R_81745
    references TABLECODES,
  [EMPLOYEENO] int
    constraint R_81746
    references NAME,
  [DATEOFREQUEST] datetime,
  [DATEREQUIRED] datetime,
  [REMARKS] nvarchar(254),
  [PRIORITY] int
    constraint R_81747
    references TABLECODES,
  [STATUS] smallint,
  [ISSELFSEARCH] bit,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int
)
;

create table FILEPARTREQUEST
(
  [REQUESTID] int not null
    constraint R_81748
    references RFIDFILEREQUEST,
  [CASEID] int not null,
  [FILEPART] smallint not null,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFILEPARTREQUEST
  primary key nonclustered (REQUESTID, CASEID, FILEPART),
  constraint R_81749
  foreign key (CASEID, FILEPART) references FILEPART
)
;

create table FILEREQASSIGNEDEMP
(
  [REQUESTID] int not null
    constraint R_81750
    references RFIDFILEREQUEST,
  [NAMENO] int not null
    constraint R_81751
    references NAME,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFILEREQASSIGNEDEMP
  primary key nonclustered (REQUESTID, NAMENO)
)
;

create table FILEREQASSIGNEDDEVICE
(
  [REQUESTID] int not null
    constraint R_81752
    references RFIDFILEREQUEST,
  [RESOURCENO] int not null
    constraint R_81753
    references RESOURCE,
  [LOGUSERID] nvarchar(50),
  [LOGIDENTITYID] int,
  [LOGTRANSACTIONNO] int,
  [LOGDATETIMESTAMP] datetime,
  [LOGAPPLICATION] nvarchar(128),
  [LOGOFFICEID] int,
  constraint XPKFILEREQASSIGNEDDEVICE
  primary key nonclustered (REQUESTID, RESOURCENO)
)
;

create table CASE_WT
(
  [ID] int identity
    primary key,
  [SYNC_STATUS] varchar(255) default 'pending' not null,
  [CASEID] int
)
;


CREATE table DEBTORSPLITDIARY	(
  [EMPLOYEENO]		int		NOT NULL,
  [ENTRYNO] int NOT NULL,
  [NAMENO]			int		NOT NULL,
  [TIMEVALUE]		decimal(10,2)	NULL,
  [CHARGEOUTRATE]		decimal(10,2)	NULL,
  [NARRATIVENO]		int		NULL,
  [NARRATIVE]		nvarchar(max)	collate database_default NULL,
  [DISCOUNTVALUE]		decimal(10,2)	NULL,
  [FOREIGNCURRENCY]		nvarchar(3)	NULL,
  [FOREIGNVALUE]		decimal(11,2)	NULL,
  [EXCHRATE]		decimal(11,4)	NULL,
  [FOREIGNDISCOUNT]		decimal(11,2)	NULL,
  [COSTCALCULATION1]	decimal(11,2)	NULL,
  [COSTCALCULATION2]	decimal(11,2)	NULL,
  [MARGINNO]		int		NULL,
  [SPLITPERCENTAGE]		decimal(5,2)	NULL
)