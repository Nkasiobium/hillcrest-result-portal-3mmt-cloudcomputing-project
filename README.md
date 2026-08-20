# Hill Crest Secondary School Result Portal

## 1. Project Overview

This project is a simple cloud-hosted school result portal developed as part of my 3MTT Cloud Computing learning journey.

The project was created to address a common challenge faced by schools in Nigeria, where students and parents may have difficulty accessing academic results conveniently. The aim was to build a simple web application where students can check their results online instead of depending completely on physical result sheets.

For this MVP, I used sample records for five students and nine subjects. The application was developed with Node.js and Express and deployed on an AWS EC2 instance.

The school used in the project is:

**Hill Crest Secondary School, Awada**

---

## 2. Project Objective

The main objective of this project was to demonstrate my practical understanding of cloud computing by taking a simple web application from local development to a working cloud deployment.

Through this project, I wanted to demonstrate my ability to:

- Develop and test a basic web application.
- Use Node.js and Express for the backend.
- Manage environment variables.
- Use Git and GitHub for version control.
- Deploy an application to AWS EC2.
- Configure an Ubuntu cloud server.
- Install and manage Node.js applications on Linux.
- Use PM2 to keep the application running.
- Use Nginx as a reverse proxy.
- Configure AWS Security Groups.
- Test the application after deployment.
- Understand basic cloud scaling and cost considerations.

---

## 3. Nigerian Problem Context

Many schools still depend heavily on printed result sheets or manual processes for students to access their academic results.

This can make result checking slower and less convenient, especially when students or parents need to access results outside the school environment.

This project provides a simple example of how cloud computing can be used to make school results accessible through the internet.

Although this is only an MVP, the same concept can be expanded into a complete school management and result-processing system.

---

# 4. Features

The current MVP provides the following features:

- School-branded result portal.
- Student result search.
- Five sample student records.
- Nine subjects per student.
- Subject scores and grades.
- Total score calculation.
- Average score calculation.
- Student performance remark.
- Invalid student search handling.
- Responsive and simple user interface.
- Health check endpoint.
- Cloud deployment on AWS EC2.

---

# 5. Sample Student Data

The application currently contains five sample students.

| Student ID | Student |
|------------|---------|
| HCSS001 | Student 1 |
| HCSS002 | Student 2 |
| HCSS003 | Student 3 |
| HCSS004 | Student 4 |
| HCSS005 | Student 5 |

The sample students have results for nine subjects.

The student records are only for demonstration purposes and do not represent real student information.

---

# 6. Technology Stack

I used the following technologies to build and deploy the application:

### Frontend
- HTML
- CSS
- JavaScript

### Backend
- Node.js
- Express.js

### Cloud
- Amazon Web Services (AWS)
- Amazon EC2
- Ubuntu Linux

### Server Management
- PM2
- Nginx

### Development and Version Control
- Visual Studio Code
- Git
- GitHub

### Configuration
- Environment variables using `.env`
- `.env.example` for configuration documentation

---

# 7. Project Structure

The main project structure is:

```text
hill-crest-result-portal/
│
├── public/
│   ├── index.html
│   ├── style.css
│   └── app.js
│
├── .env
├── .env.example
├── .gitignore
├── package.json
├── package-lock.json
├── server.js
└── README.md

## Description of Important Files

### `server.js`

This is the main Node.js and Express server file. It starts the application, serves the frontend files and provides the health-check endpoint.

### `public/index.html`

This contains the main structure and content of the Hill Crest Secondary School Result Portal.

### `public/style.css`

This contains the styling, layout and responsive design of the result portal.

### `public/app.js`

This contains the frontend functionality of the application, including student result searching and displaying the student's academic result.

### `.env`

This file contains environment-specific configuration used by the application.

The `.env` file is not uploaded to GitHub because it is included in `.gitignore`.

### `.env.example`

This provides an example of the environment variables required by the application without exposing the actual environment configuration.

### `.gitignore`

This prevents files such as `.env`, `node_modules` and other unnecessary or sensitive files from being uploaded to GitHub.

### `package.json`

This contains the project information, dependencies and scripts required to run the Node.js application.

### `package-lock.json`

This records the exact versions of the Node.js dependencies installed for the project.

### `README.md`

This document explains the project, development process, cloud deployment, architecture, testing, security considerations, scaling approach and lessons learned.

---

# Local Development

Before deploying the application to AWS, I developed and tested it locally on my Windows computer.

## Step 1: Clone the Repository

```bash
git clone https://github.com/YOUR-GITHUB-USERNAME/hill-crest-result-portal.git
