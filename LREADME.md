# 🎓 University Management System (MySQL Database)

A fully structured **MySQL relational database** designed to manage core university operations such as faculties, departments, students, courses, semesters, classrooms, enrollments and grades.

---

## 🎯 Project Goals
- Build a **normalized database schema (1NF → 3NF)**  
- Implement **primary & foreign key constraints** with `ON UPDATE` / `ON DELETE` rules  
- Insert realistic sample data for testing  
- Provide analytical **SQL queries** for reporting and insights  
- Include documentation (ER Diagram + requirements)

---

## 🧱 Main Tables
- **faculties** – faculty info and dean  
- **departments** – linked to faculties  
- **students** – student personal & academic data  
- **courses** – course name, credits, level  
- **classrooms** – building, room, capacity  
- **semesters** – term details & dates  
- **enrollments** – student–course–semester relationships  
- **grades / attendance** – optional performance extension  

---

## 🛠 Technologies Used
- **MySQL 8**  
- MySQL Workbench / CLI  
- SQL (DDL, DML, DQL)

---

## 📂 Repository Structure
```
sql/
   UniversityManagementSystemTables.sql
   UniversityManagementSystemInserts.sql

docs/
   Project_Requirements.pdf
   ER_Diagram.png

queries/
   example_queries.sql

README.md
```

---

## 📸 Documentation
- ER Diagram included in **docs/** visualizes all table relationships  
- Requirements PDF provides system rules & constraints  
- Schema shows full PK–FK structure with normalization

---

## 📜 Key Features
- Clean, normalized relational schema  
- Strong PK–FK constraints  
- `ON UPDATE CASCADE` and `ON DELETE SET NULL` rules  
- Realistic test data for faculties, departments, students and courses  
- Analytical SQL queries including:
  - Students per department  
  - Student course history  
  - Courses offered per semester  
  - Student counts per faculty  

---

## ▶️ How to Run
1. Open **MySQL Workbench** or any MySQL client.

2. Create database:
   ```sql
   CREATE DATABASE university_management;
   USE university_management;
   ```

3. Run table creation script:
   ```sql
   SOURCE sql/UniversityManagementSystemTables.sql;
   ```

4. Insert sample data:
   ```sql
   SOURCE sql/UniversityManagementSystemInserts.sql;
   ```

5. Run analytical queries:
   ```sql
   SOURCE queries/example_queries.sql;
   ```

---

## 📌 Future Improvements
- Add triggers (automatic GPA calculation)  
- Add stored procedures (enrollment validation)  
- Add reporting views (dashboard-friendly)  
- Integrate with Python/React for full MIS system  

---

## 👩‍💻 Author & Contact  
**Samira Ismayilova**  
Computer Engineer | Data Analyst | AI/ML Enthusiast  

📧 **Email:** samiraaismabhos@gmail.com  
🔗 **GitHub:** github.com/samiraaismabhos  
🔗 **LinkedIn:** linkedin.com/in/samira-ismayilova-427810271  
