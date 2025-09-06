-- =====================================================
-- Project : NeoHCM (Human Capital Management Database)
-- Author  : Muhammad Abeer Rauf
-- Date    : 2025-09-06
-- Purpose : Initial database creation script
-- =====================================================

-- Create Database
CREATE DATABASE NeoHCM;
GO

-- Switch to NeoHCM
USE NeoHCM;
GO

-- Module: GEN | Table: Country
CREATE TABLE dbo.GEN_Country
(
	CountryID INT NOT NULL IDENTITY(1,1),
	CountryCode NVARCHAR(50) NOT NULL,
	CountryName NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_GEN_Country_ID PRIMARY KEY (CountryID),
	CONSTRAINT UQ_Country_Code UNIQUE (CountryCode)
)
GO

-- Module: GEN | Table: State
CREATE TABLE dbo.GEN_State
(
	StateID INT NOT NULL IDENTITY(1,1),
	CountryIDFK INT NOT NULL,
	StateCode NVARCHAR(50) NOT NULL,
	StateName NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_GEN_State_ID PRIMARY KEY (StateID),
	CONSTRAINT UQ_State_Code UNIQUE (StateCode),
	CONSTRAINT FK_GEN_State_Country_ID FOREIGN KEY (CountryIDFK) REFERENCES GEN_Country(CountryID)
)
GO

-- Module: GEN | Table: City
CREATE TABLE dbo.GEN_City
(
	CityID INT NOT NULL IDENTITY(1,1),
	StateIDFK INT NOT NULL,
	CityCode NVARCHAR(50) NOT NULL,
	CityName NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_GEN_City_ID PRIMARY KEY (CityID),
	CONSTRAINT UQ_City_Code UNIQUE (CityCode),
	CONSTRAINT FK_GEN_City_State_ID FOREIGN KEY (StateIDFK) REFERENCES GEN_State(StateID)
)
GO
-- Module: GEN | Table: Location Type
CREATE TABLE dbo.GEN_LocationType
(
	LocationTypeID INT NOT NULL IDENTITY(1,1),
	LocationTypeCode NVARCHAR(50) NOT NULL,
	LocationTypeName NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(255),
	CONSTRAINT PK_GEN_LocationType_ID PRIMARY KEY (LocationTypeID),
	CONSTRAINT UQ_LocationType_Code UNIQUE (LocationTypeCode)
)
GO

-- Module: GEN | Table: Location
CREATE TABLE dbo.GEN_Location
(
	LocationID INT NOT NULL IDENTITY(1,1),
	CityIDFK INT NOT NULL,
	LocationTypeIDFK INT NOT NULL,
	LocationCode NVARCHAR(50) NOT NULL,
	LocationName NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_GEN_Location_ID PRIMARY KEY (LocationID),
	CONSTRAINT UQ_Location_Code UNIQUE (LocationCode),
	CONSTRAINT FK_GEN_City_ID FOREIGN KEY (CityIDFK) REFERENCES GEN_City(CityID),
	CONSTRAINT FK_GEN_Loc_LocType_ID FOREIGN KEY (LocationTypeIDFK) REFERENCES GEN_LocationType(LocationTypeID)
)
GO

-- Module: GEN | Table: Company
CREATE TABLE dbo.GEN_Company
(
	CompanyID INT NOT NULL IDENTITY(1,1),
	CompanyCode NVARCHAR(50) NOT NULL,
	CompanyName NVARCHAR(100) NOT NULL,
	OwnerName NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(255),
	PhoneNo NVARCHAR(20),
	BankAccount NVARCHAR(100),
	Email NVARCHAR(100),
	Web NVARCHAR(100),
	LocationIDFK INT NOT NULL,
	IsActive BIT NOT NULL CONSTRAINT DF_Company_IsActive DEFAULT 1,
	CreatedAt DATETIME,
	CreatedBy NVARCHAR(100),
	ModifiedAt DATETIME,
	ModifiedBy NVARCHAR(100),
	IsDeleted BIT NOT NULL CONSTRAINT DF_Company_IsDeleted DEFAULT 0,
	DeletedAt DATETIME,
	DeletedBy NVARCHAR(100),
	CONSTRAINT PK_Gen_CompanyID PRIMARY KEY (CompanyID),
	CONSTRAINT UQ_Company_Code UNIQUE (CompanyCode),
	CONSTRAINT FK_GEN_Location_Company_ID FOREIGN KEY (LocationIDFK) REFERENCES GEN_Location(LocationID)
)
GO

-- Module: GEN | Table: Department
CREATE TABLE dbo.GEN_Department
(
	DepartmentID INT NOT NULL IDENTITY(1,1),
	DepartmentCode NVARCHAR(50) NOT NULL,
	DepartmentName NVARCHAR(100) NOT NULL,
	CompanyIDFK INT NOT NULL,
	[Description] NVARCHAR(255),
	CONSTRAINT PK_Gen_Department_ID PRIMARY KEY (DepartmentID),
	CONSTRAINT UQ_Department_Code UNIQUE (DepartmentCode),
	CONSTRAINT FK_GEN_Department_Company_ID FOREIGN KEY (CompanyIDFK) REFERENCES GEN_Company(CompanyID)
)
GO

-- Module: GEN | Table: Section
CREATE TABLE dbo.GEN_Section
(
	SectionID INT NOT NULL IDENTITY(1,1),
	SectionCode NVARCHAR(50) NOT NULL,
	SectionName NVARCHAR(100) NOT NULL,
	DepartmentIDFK INT NOT NULL,
	[Description] NVARCHAR(255),
	CONSTRAINT PK_Gen_Section_ID PRIMARY KEY (SectionID),
	CONSTRAINT UQ_Section_Code UNIQUE (SectionCode),
	CONSTRAINT FK_GEN_Section_Department_ID FOREIGN KEY (DepartmentIDFK) REFERENCES GEN_Department(DepartmentID)
)
GO