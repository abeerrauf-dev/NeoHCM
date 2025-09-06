# NeoHCM Database – GEN Module Documentation

**Module:** GEN (General / Reference Data)  
**Purpose:** Foundation tables for the Human Capital Management system.  
**Author:** Muhammad Abeer Rauf  
**Date:** 2025-09-06

---

## 1. Overview

GEN module contains all **master/reference data** required across the HCM system.  
This module is the base for all other modules (HR, ATT, PAY, RPT).  

**Key Points:**
- Provides company, location, department, and hierarchy references.
- Tables are designed with proper **Primary Keys, Foreign Keys, and Unique constraints**.
- Supports **audit columns** (`CreatedAt`, `CreatedBy`, `ModifiedAt`, `ModifiedBy`) and **soft delete** (`IsDeleted`).

---

## 2. Table List

| Table Name           | Description                                         |
|--------------------- |-----------------------------------------------------|
| GEN_Country          | Stores all countries                                |
| GEN_State            | Stores states/provinces linked to a country         |
| GEN_City             | Stores cities linked to a state                     |
| GEN_LocationType     | Defines types of locations (Head Office, Branch)    |
| GEN_Location         | Stores locations (branches/offices) linked to city and type |
| GEN_Company          | Stores company details, linked to a location        |
| GEN_Department       | Departments within a company                        |
| GEN_Section          | Sections within a department                        |

---

## 3. Table Structures & Relationships

### 3.1 GEN_Country

| Column      | Type          | Description                  |
|------------ |---------------|----------------------------  |
| CountryID   | INT (PK)      | Primary key, auto-increment  |
| CountryCode | NVARCHAR(50)  | Unique country code          |
| CountryName | NVARCHAR(100) | Country name                 |

**Constraints:**
- PK: `CountryID`
- Unique: `CountryCode`

---

### 3.2 GEN_State

| Column      | Type         | Description                       |
|------------ |--------------|---------------------------------- |
| StateID     | INT (PK)     | Primary key, auto-increment       |
| CountryIDFK | INT (FK)     | References `GEN_Country(CountryID)` |
| StateCode   | NVARCHAR(50) | Unique state code                 |
| StateName   | NVARCHAR(100)| State name                        |

**Constraints:**
- PK: `StateID`
- Unique: `StateCode`
- FK: `CountryIDFK → GEN_Country(CountryID)`

---

### 3.3 GEN_City

| Column      | Type         | Description                       |
|------------ |--------------|---------------------------------- |
| CityID      | INT (PK)     | Primary key, auto-increment       |
| StateIDFK   | INT (FK)     | References `GEN_State(StateID)`   |
| CityCode    | NVARCHAR(50) | Unique city code                  |
| CityName    | NVARCHAR(100)| City name                         |

**Constraints:**
- PK: `CityID`
- Unique: `CityCode`
- FK: `StateIDFK → GEN_State(StateID)`

---

### 3.4 GEN_LocationType

| Column           | Type          | Description                     |
|----------------- |---------------|-------------------------------- |
| LocationTypeID   | INT (PK)      | Primary key, auto-increment     |
| LocationTypeCode | NVARCHAR(50)  | Unique code for location type   |
| LocationTypeName | NVARCHAR(100) | Name of location type (`Head Office, Branch etc`) |
| Description      | NVARCHAR(255) | Optional description            |

**Constraints:**
- PK: `LocationTypeID`
- Unique: `LocationTypeCode`

---

### 3.5 GEN_Location

| Column          | Type          | Description                       |
|---------------- |---------------|---------------------------------- |
| LocationID      | INT (PK)      | Primary key, auto-increment       |
| CityIDFK        | INT (FK)      | References `GEN_City(CityID)`     |
| LocationTypeIDFK| INT (FK)      | References `GEN_LocationType(LocationTypeID)` |
| LocationCode    | NVARCHAR(50)  | Unique location code              |
| LocationName    | NVARCHAR(100) | Name of the branch/location       |

**Constraints:**
- PK: `LocationID`
- Unique: `LocationCode`
- FK: `CityIDFK → GEN_City(CityID)`
- FK: `LocationTypeIDFK → GEN_LocationType(LocationTypeID)`

---

### 3.6 GEN_Company

| Column       | Type           | Description                       |
|------------- |----------------|---------------------------------- |
| CompanyID    | INT (PK)       | Primary key, auto-increment       |
| CompanyCode  | NVARCHAR(50)   | Unique code for company           |
| CompanyName  | NVARCHAR(100)  | Name of the company               |
| OwnerName    | NVARCHAR(100)  | Owner/CEO name                    |
| Address      | NVARCHAR(255)  | Company address                   |
| PhoneNo      | NVARCHAR(20)   | Contact number                    |
| BankAccount  | NVARCHAR(100)  | Bank account info                 |
| Email        | NVARCHAR(100)  | Email                             |
| Web          | NVARCHAR(100)  | Website                           |
| LocationIDFK | INT (FK)       | References `GEN_Location(LocationID)` |
| IsActive     | BIT            | 1 = Active, 0 = Inactive          |
| CreatedAt    | DATETIME       | Record creation timestamp         |
| CreatedBy    | NVARCHAR(100)  | User who created                  |
| ModifiedAt   | DATETIME       | Last modification timestamp       |
| ModifiedBy   | NVARCHAR(100)  | User who modified                 |
| IsDeleted    | BIT            | Soft delete flag                  |
| DeletedAt    | DATETIME       | Deletion timestamp                |
| DeletedBy    | NVARCHAR(100)  | Deleted by                        |

**Constraints:**
- PK: `CompanyID`
- Unique: `CompanyCode`
- FK: `LocationIDFK → GEN_Location(LocationID)`

---

### 3.7 GEN_Department

| Column        | Type           | Description                    |
|-------------  |----------------|------------------------------  |
| DepartmentID  | INT (PK)       | Primary key, auto-increment    |
| DepartmentCode| NVARCHAR(50)   | Unique department code         |
| DepartmentName| NVARCHAR(100)  | Name of department             |
| CompanyIDFK   | INT (FK)       | References `GEN_Company(CompanyID)` |
| Description   | NVARCHAR(255)  | Optional description           |

**Constraints:**
- PK: `DepartmentID`
- Unique: `DepartmentCode`
- FK: `CompanyIDFK → GEN_Company(CompanyID)`

---

### 3.8 GEN_Section

| Column         | Type           | Description                   |
|-------------   |----------------|------------------------------ |
| SectionID      | INT (PK)       | Primary key, auto-increment   |
| SectionCode    | NVARCHAR(50)   | Unique section code           |
| SectionName    | NVARCHAR(100)  | Section name                  |
| DepartmentIDFK | INT (FK)       | References `GEN_Department(DepartmentID)` |
| Description    | NVARCHAR(255)  | Optional description          |

**Constraints:**
- PK: `SectionID`
- Unique: `SectionCode`
- FK: `DepartmentIDFK → GEN_Department(DepartmentID)`

---

## 4. ER Relationships (Summary)

- Country → State (1:M)  
- State → City (1:M)  
- City → Location (1:M)  
- LocationType → Location (1:M)  
- Location → Company (1:M)  
- Company → Department (1:M)  
- Department → Section (1:M)  

---

## 5. Notes / Guidelines

- `IsActive` indicates whether a record is active.  
- `IsDeleted` used for **soft delete**; records are never physically deleted.  
- `CreatedAt`, `ModifiedAt` timestamps to track changes.  
- `Company`, `Department`, `Section` hierarchy ensures **multi-company support**.  
- Codes (`CompanyCode`, `DepartmentCode`) are unique across system.  

---

**End of GEN Module Documentation**

