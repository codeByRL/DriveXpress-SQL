# 🏎️ DriveXpress - Enterprise Car Rental Management System

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-red?style=flat-square&logo=microsoft-sql-server)
![T-SQL](https://img.shields.io/badge/Logic-T--SQL%20Programmability-blue?style=flat-square)
![Status](https://img.shields.io/badge/Project-Finished-green?style=flat-square)

**DriveXpress** is a sophisticated Relational Database Management System (RDBMS) designed to automate the full lifecycle of a car rental business. It features complex business logic, automated financial calculations, and an intelligent maintenance scheduling engine.

---

## 🌟 Key Technical Features

### 🧠 Intelligent Rental Logic (Trigger-Based)
The system doesn't just store data; it "thinks" before every transaction:
*   **Maintenance Awareness:** New rentals are automatically blocked if a vehicle is in maintenance based on its previous return condition.
*   **Dynamic Fine Calculation:** Fines are calculated automatically based on quality checks during vehicle return.
*   **Automated Archiving:** Completed deals are automatically validated for price integrity and moved to a dedicated `arcivRentals` table to keep the operational database lean.

### 💰 Loyalty & Billing Engine
*   **Dynamic Coupon System:** A smart View tracks customer history and identifies eligibility for "One Free Day" every 5 rentals.
*   **Real-time Price Engine:** Scalar functions calculate dynamic prices based on car quality, size, and specific rental dates.

### 🔧 Fleet Maintenance Micro-service
*   A Stored Procedure utilizing **Cursors** iterates through the entire fleet, generating maintenance alerts based on the number of rentals and vehicle quality levels (Preventative Maintenance).

### 📧 Automated Communication
*   **Email Reminders:** Integration with `msdb.dbo.sp_send_dbmail` to automatically notify customers 24 hours before their rental expires.

---

## 🏗️ Schema Highlights
*   **3NF Normalization:** Zero data redundancy across Tables, Views, and Relationships.
*   **Pivot Reporting:** Built-in pivot functions for real-time inventory snapshots by car size.
*   **Audit Logic:** Automated feedback analysis (Complaints vs. Compliments) using string-parsing functions.

---

## 📂 Programmability Included
*   **Complex Triggers:** `trigger_OfNewDeal`, `to__arciv` (Data integrity & Lifecycle).
*   **Procedures:** `Newdeal`, `CompleteDeal`, `PremiumRentalHandler` (Operations).
*   **Functions:** `Car_search` (Availability & Price prediction), `getNotesByType` (Sentiment analysis).

---

## 🚀 Deployment
1. Run `CreateTables.sql` to generate the schema.
2. Run the `Programmability.sql` script to load all triggers, functions, and procedures.

---
**Developed by Rivky Lutzkin**  
*Full-Stack Developer | SQL Expert | Logic Enthusiast*
