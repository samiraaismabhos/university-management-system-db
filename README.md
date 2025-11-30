# 🎓 University Management System (MySQL Database)

Relational **MySQL database** designed to manage a university’s core entities:  
faculties, departments, students, courses, classrooms, semesters, enrollments and grades.

---

## 🎯 Project Goals
- Design a **normalized relational schema** for a university information system  
- Use **primary & foreign keys** with `ON UPDATE` / `ON DELETE` rules  
- Insert realistic sample data  
- Write example **SQL queries** for reporting and analytics

---

## 🧱 Main Tables (example)
- `faculties` – faculty info and dean  
- `departments` – department name, linked to faculty  
- `classrooms` – building, room number, capacity  
- `semesters` – semester name, start/end dates  
- `students` – student number, name, contact info  
- `courses` – course name, credits, level  
- `enrollments` – which student takes which course in which semester  
- `grades` / `attendance` – performance tracking (optional extension)

---

## 🛠 Technologies
- **MySQL 8**  
- MySQL Workbench / CLI  
- SQL: DDL (CREATE, ALTER), DML (INSERT, SELECT, UPDATE, DELETE)

---

## 📜 Features
- Proper **PK/FK constraints**  
- `ON UPDATE CASCADE`, `ON DELETE SET NULL` where appropriate  
- Sample data for faculties, departments, students and courses  
- Example queries, e.g.:
  - List all students in a given department  
  - Show courses taught in a selected semester  
  - Count students per faculty  
  - Get all courses taken by a student

---

## ▶️ How to Run
1. Open MySQL (Workbench or terminal).  
2. Run the SQL script from this repo:
   ```sql
   SOURCE university_management.sql;
