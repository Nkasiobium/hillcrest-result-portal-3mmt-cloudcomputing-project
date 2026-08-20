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
```

---

| File | Description |
|---|---|
| `server.js` | Main Node.js/Express server file. Starts the application, serves the frontend, and provides the health-check endpoint. |
| `public/index.html` | Main structure of the result portal. |
| `public/style.css` | Styling and layout of the portal. |
| `public/app.js` | Frontend logic, including student search and result display. |
| `.env` | Environment-specific configuration used when running the application. |
| `.env.example` | Example of required environment variables without exposing local configuration. |
| `.gitignore` | Prevents files such as `.env` and `node_modules` from being uploaded to GitHub. |
| `package.json` | Project information, dependencies, and application start scripts. |

## Environment Configuration

The application uses environment variables instead of hard-coding configuration values.

Main variables:

```
NODE_ENV=production
SCHOOL_NAME=Hill Crest Secondary School, Awada
PORT=3000
```

The `.env` file is **not** committed to GitHub. This follows a basic security practice of keeping environment-specific configuration separate from the source code.

## Local Development

Before deploying to AWS, the application was tested locally on Windows.

**Step 1: Clone the project**
```bash
git clone https://github.com/Nkasiobium/hill-crest-result-portal.git
```

**Step 2: Enter the project directory**
```bash
cd hill-crest-result-portal
```

**Step 3: Install dependencies**
```bash
npm install
```

**Step 4: Create the `.env` file**
```
NODE_ENV=development
SCHOOL_NAME=Hill Crest Secondary School, Awada
PORT=3000
```

**Step 5: Start the application**
```bash
npm start
```

The application runs locally at:
```
http://localhost:3000
```

The health endpoint can also be tested at:
```
http://localhost:3000/health
```

## Health Check

A simple health endpoint confirms the application is running correctly.

**Endpoint:**
```
/health
```

**Example:**
```
http://localhost:3000/health
```

**Successful response:**
```json
{
  "status": "healthy",
  "application": "Hill Crest Secondary School Result Portal",
  "school": "Hill Crest Secondary School, Awada"
}
```

This provides a simple way of checking application availability after deployment.

## Git and GitHub

Git was used to track project files, and GitHub to store the source code remotely.

```bash
git init
git add .
git commit -m "Initial school result portal"
git branch -M main
git remote add origin https://github.com/Nkasiobium/hillcrest-result-portal-3mmt-cloudcomputing-project
git push -u origin main
```

The `.env` file was excluded from GitHub using `.gitignore`.

## AWS EC2 Deployment

After successfully testing the application locally, it was deployed to an AWS EC2 instance.

**EC2 configuration used:**
- Ubuntu LTS EC2 instance
- SSH key pair
- Security Group
- Public IPv4 address

Connection to the EC2 server from a Windows computer used SSH:

```bash
ssh -i "hill-crest-key.pem" ubuntu@MY_PUBLIC_IP
```

After connecting, the server environment was confirmed:

```bash
whoami
hostname
pwd
```

Git and Node.js versions were also checked:

```bash
git --version
node --version
```

## Preparing the EC2 Server

Update package lists and upgrade packages:

```bash
sudo apt update
sudo apt upgrade -y
```

Install Git:

```bash
sudo apt install git -y
```

Clone the GitHub repository onto the EC2 server:

```bash
git clone https://github.com/Nkasiobium/hillcrest-result-portal-3mmt-cloudcomputing-project
cd hill-crest-result-portal
npm install
```

## Production Environment Configuration

Because the local `.env` file was not uploaded to GitHub, a new `.env` file was created directly on the EC2 server:

```
NODE_ENV=production
SCHOOL_NAME=Hill Crest Secondary School, Awada
PORT=3000
```

This allows the application to run on port 3000 internally.

## PM2 Process Management

PM2 was used to run the Node.js application as a background process.

Install PM2:

```bash
sudo npm install -g pm2
```

Start the application:

```bash
pm2 start server.js --name hill-crest-result-portal
```

Check application status:

```bash
pm2 status
```

Expected status: `online`

Configure PM2 to restart the application automatically after a server reboot:

```bash
pm2 startup
pm2 save
```

## Nginx Reverse Proxy

Nginx is used as a reverse proxy in front of the Node.js application, allowing users to access the site through the standard HTTP port 80 while Node.js continues running internally on port 3000.

**Architecture:**

```
User Browser
     |
     | HTTP :80
     v
   Nginx
     |
     | localhost:3000
     v
 Node.js / Express
     |
     v
Result Portal
```

The Nginx configuration forwards requests from port 80 to `http://127.0.0.1:3000`.

Test the Nginx configuration:

```bash
sudo nginx -t
```

Restart Nginx:

```bash
sudo systemctl restart nginx
```

## AWS Security Group

The EC2 Security Group controls which network traffic is allowed to reach the server.

| Type | Port | Source | Purpose |
|---|---|---|---|
| SSH | 22 | My IP | Server administration |
| HTTP | 80 | Anywhere IPv4 | Public web access |

Port 3000 is used internally by the Node.js application and does not need to be publicly exposed after Nginx is configured. Restricting SSH access to a specific IP also reduces unnecessary exposure of the server.

## Application Testing

After deployment, the application was tested through the EC2 public IP:

```
http://34.234.215.184
```

**Student result search tested with:**
- HCSS001
- HCSS002
- HCSS003
- HCSS004
- HCSS005
- An invalid student ID (to confirm proper handling of records not found)

**Health endpoint tested at:**

```
http://34.234.215.184/health
```

A successful health response confirmed the application was running correctly on the EC2 server.

## Final Architecture

```
                       INTERNET
                           |
                           | HTTP :80
                           v
                  +------------------+
                  |     AWS EC2      |
                  |   Ubuntu LTS     |
                  |                  |
                  |  Security Group  |
                  |        |         |
                  |      Nginx       |
                  |        |         |
                  |        v         |
                  |   Node.js :3000  |
                  |        |         |
                  |        v         |
                  |   Express App    |
                  |        |         |
                  |        v         |
                  |   Result Portal  |
                  +------------------+
```

This architecture is intentionally simple because this is a capstone project.

## Scaling Considerations

The current deployment uses one EC2 instance, which is sufficient for demonstrating the MVP. If the number of students and users increases significantly, the architecture could be improved by introducing multiple application servers behind an Application Load Balancer.

**Possible future architecture:**

```
                  INTERNET
                      |
                      v
            +-------------------+
            | Application Load  |
            |     Balancer      |
            +---------+---------+
                      |
              +-------+-------+
              |               |
              v               v
        +-----------+   +-----------+
        |  EC2 #1   |   |  EC2 #2   |
        |  Node.js  |   |  Node.js  |
        +-----+-----+   +-----+-----+
              |               |
              +-------+-------+
                      |
                      v
                +-----------+
                | Database  |
                |           |
                | Students  |
                | Results   |
                +-----------+
```

The application could also be containerized using Docker and deployed using a more scalable AWS architecture as the system grows.

## Database Consideration

For this MVP, sample student data was used instead of a production database. This was intentional, as the main objective of the project was to demonstrate cloud deployment rather than build a complete school management system.

For a real school deployment, student records would be moved into a proper database such as Amazon RDS or another managed database service. The database would contain:

- Student ID
- Student name
- Class
- Academic session
- Term
- Subjects
- Scores
- Grades
- Average
- Remarks

The backend would then retrieve results securely instead of keeping student information in frontend JavaScript.

## Security Considerations

Some basic security practices were implemented during the project:

- **Environment variables** — The `.env` file is excluded from GitHub.
- **SSH** — SSH access is restricted to a specific IP address through the EC2 Security Group.
- **Nginx** — Used as the public-facing web server while Node.js runs internally.
- **Port exposure** — The final configuration exposes HTTP port 80 publicly while keeping Node.js port 3000 internal.
- **Sample data** — The application only contains fictional sample student data. No real student information was used.

## Limitations of the MVP

There are some limitations to the current implementation. The application currently does not have:

- A production database
- Student login authentication
- Admin login
- Role-based access control
- HTTPS/domain configuration
- Result upload functionality
- Result editing functionality
- Teacher/admin dashboard
- Automated backups
- Advanced monitoring
- Multiple EC2 instances

These features can be added in a future version.

## Future Improvements

If development continues, planned additions include:

- Student authentication
- Admin dashboard
- Secure database integration
- Teacher result upload
- Result editing and approval workflow
- PDF result generation
- Student result history
- Parent access
- HTTPS with a custom domain
- Automated database backups
- Application monitoring
- Rate limiting and stronger security controls
- Docker containerization
- Load balancing and auto scaling
- Automated CI/CD deployment using GitHub Actions

## Cost Considerations

The project was designed as an MVP and deployed using AWS resources that fit within the applicable Free Tier/Free Plan allowances for the account where available.

The main cloud resource used is an EC2 instance.

Unnecessary services were avoided, such as:

- Load Balancer
- NAT Gateway
- RDS database
- Multiple EC2 instances

because they are not required for the MVP. AWS usage and billing were also monitored to avoid unexpected charges.

## Conclusion

Building this project provided an opportunity to apply cloud computing knowledge to a practical Nigerian use case.

Although the current application is an MVP, it demonstrates the basic process of developing an application, testing it locally, storing the source code using GitHub, deploying it to AWS EC2, and configuring the server to make the application accessible through the internet.

The next step is to develop the application into a more complete school result management platform with a secure database, authentication, HTTPS, administrative functionality, and a scalable cloud architecture.

## Author

**Emmanuel Nwankwo**
Cloud Computing Learner | 3MTT Nigeria

- **Project:** Hill Crest Secondary School Result checking web Portal
- **Cloud Platform:** Amazon Web Services (AWS)
- **Primary Service:** Amazon EC2
- **Application:** Node.js + Express
