# NeoHCM - Human Capital Management (HCM) Database

NeoHCM is a **SQL Server–based Human Capital Management (HCM) database project**.  
It is designed to handle core HR operations such as employee management, departments, payroll, leave tracking, and reporting.

---

## 📌 Features (Planned & Implemented)
- 👨‍💼 Employee Management (personal details, contact, job info)
- 🏢 Company, Department & Section structure
- 💰 Payroll & Salary Records
- 📅 Attendance & Leave Tracking
- 📊 Reporting & Analytics (future scope)
- 🔐 Security & Access Control (future scope)

---

## 🗂️ Database Modules
1. **GEN (General)** – Company, Location, Department, Section...
2. **HR (Human Resource)** – Employee master data, job info, Employee Types...  
3. **PAY (Payroll)** – Salaries, allowances, deductions...
4. **ATT (Attendance)** – Daily attendance, leave, shifts...
5. **RPT (Reporting)** – Views, stored procedures for analysis...  

---

## 📌 Current Progress

✅ **GEN Module Completed**  
- Tables created: `GEN_Country`, `GEN_State`, `GEN_City`, `GEN_LocationType`, `GEN_Location`, `GEN_Company`, `GEN_Department`, `GEN_Section`  
- All **primary keys, foreign keys, unique constraints, default values, and soft delete columns** implemented.  
- **Documentation:** `docs/GEN_Module.md`  
- **SQL Scripts:** 
  - `scripts/01_Initial_DB.sql` – Initial DB creation script  
  - `scripts/02- NeoHCM_DB.sql` – GEN module creation script  

---

## 🛠️ Tech Stack
- **Database:** Microsoft SQL Server  
- **Language:** T-SQL (DDL, DML, Stored Procedures, Views, Functions) 
- **Version Control:** Git + GitHub

---

## 🚀 How to Use
1. Clone this repository:  
   ```bash
   git clone https://github.com/abeerrauf-dev/NeoHCM.git
   ```
2. Navigate to the **scripts** folder and choose the SQL script you want to run:
   - 01_Initial_DB.sql → `Initial database creation`
   - 02- NeoHCM_DB.sql → `GEN module creation`
   - Future scripts (`HR, PAY, ATT, RPT, etc.`) will follow this naming and order
   - Final consolidated version will be available as `NeoHCM-V1.sql`
3. Open the chosen script in SQL Server Management Studio (SSMS) and execute it to create schema tables, stored procedures, functions, or views.
4. Navigate to the **docs** folder to view module-wise documentation:
   - `GEN_Module.md` → GEN tables and relationships
   - `HR_Module.md`, `PAY_Module.md`, etc. → future modules
   ## NOTE: 
      Each doc explains table structures, constraints, and relationships.
5. Insert demo data and test queries as needed.