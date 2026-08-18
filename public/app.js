const students = [
    {
        admissionNumber: "HCSS001",
        name: "Chinedu Okafor",
        className: "SS2 Science",
        session: "2025/2026",
        term: "Third Term",

        subjects: [
            { name: "English Language", score: 78 },
            { name: "Mathematics", score: 85 },
            { name: "Physics", score: 82 },
            { name: "Chemistry", score: 76 },
            { name: "Biology", score: 80 },
            { name: "Economics", score: 74 },
            { name: "Government", score: 72 },
            { name: "Computer Science", score: 88 },
            { name: "Technical Drawing", score: 81 }
        ]
    },

    {
        admissionNumber: "HCSS002",
        name: "Amaka Eze",
        className: "SS2 Science",
        session: "2025/2026",
        term: "Third Term",

        subjects: [
            { name: "English Language", score: 88 },
            { name: "Mathematics", score: 91 },
            { name: "Physics", score: 86 },
            { name: "Chemistry", score: 89 },
            { name: "Biology", score: 92 },
            { name: "Economics", score: 84 },
            { name: "Government", score: 80 },
            { name: "Computer Science", score: 94 },
            { name: "Technical Drawing", score: 87 }
        ]
    },

    {
        admissionNumber: "HCSS003",
        name: "Ifeanyi Nwosu",
        className: "SS2 Arts",
        session: "2025/2026",
        term: "Third Term",

        subjects: [
            { name: "English Language", score: 72 },
            { name: "Mathematics", score: 68 },
            { name: "Physics", score: 65 },
            { name: "Chemistry", score: 61 },
            { name: "Biology", score: 70 },
            { name: "Economics", score: 78 },
            { name: "Government", score: 84 },
            { name: "Computer Science", score: 75 },
            { name: "Technical Drawing", score: 60 }
        ]
    },

    {
        admissionNumber: "HCSS004",
        name: "Adaobi Okeke",
        className: "SS2 Commercial",
        session: "2025/2026",
        term: "Third Term",

        subjects: [
            { name: "English Language", score: 81 },
            { name: "Mathematics", score: 79 },
            { name: "Physics", score: 73 },
            { name: "Chemistry", score: 69 },
            { name: "Biology", score: 77 },
            { name: "Economics", score: 88 },
            { name: "Government", score: 82 },
            { name: "Computer Science", score: 90 },
            { name: "Technical Drawing", score: 71 }
        ]
    },

    {
        admissionNumber: "HCSS005",
        name: "Emeka Obi",
        className: "SS2 Science",
        session: "2025/2026",
        term: "Third Term",

        subjects: [
            { name: "English Language", score: 65 },
            { name: "Mathematics", score: 73 },
            { name: "Physics", score: 79 },
            { name: "Chemistry", score: 75 },
            { name: "Biology", score: 68 },
            { name: "Economics", score: 70 },
            { name: "Government", score: 67 },
            { name: "Computer Science", score: 82 },
            { name: "Technical Drawing", score: 76 }
        ]
    }
];


// Determine grade
function getGrade(score) {

    if (score >= 80) return "A1";
    if (score >= 75) return "B2";
    if (score >= 70) return "B3";
    if (score >= 65) return "C4";
    if (score >= 60) return "C5";
    if (score >= 55) return "C6";
    if (score >= 50) return "D7";
    if (score >= 45) return "E8";

    return "F9";
}


// Determine remark
function getRemark(score) {

    if (score >= 80) return "Excellent";
    if (score >= 70) return "Very Good";
    if (score >= 60) return "Good";
    if (score >= 50) return "Pass";

    return "Needs Improvement";
}


// Check result
function checkResult() {

    const admissionNumber =
        document
            .getElementById("admissionNumber")
            .value
            .trim()
            .toUpperCase();

    const errorMessage =
        document.getElementById("errorMessage");

    const resultSection =
        document.getElementById("resultSection");


    errorMessage.textContent = "";


    if (!admissionNumber) {

        errorMessage.textContent =
            "Please enter an admission number.";

        return;
    }


    const student = students.find(
        student =>
            student.admissionNumber === admissionNumber
    );


    if (!student) {

        resultSection.classList.add("hidden");

        errorMessage.textContent =
            "Student record not found. Please check the admission number.";

        return;
    }


    displayResult(student);
}


// Display result
function displayResult(student) {

    document.getElementById("studentName").textContent =
        student.name;

    document.getElementById("studentAdmissionNumber").textContent =
        student.admissionNumber;

    document.getElementById("studentClass").textContent =
        student.className;

    document.getElementById("academicSession").textContent =
        student.session;

    document.getElementById("term").textContent =
        student.term;


    const tableBody =
        document.getElementById("resultTableBody");

    tableBody.innerHTML = "";


    let total = 0;


    student.subjects.forEach((subject, index) => {

        total += subject.score;

        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${index + 1}</td>
            <td>${subject.name}</td>
            <td>${subject.score}</td>
            <td>${getGrade(subject.score)}</td>
            <td>${getRemark(subject.score)}</td>
        `;

        tableBody.appendChild(row);
    });


    const average =
        total / student.subjects.length;


    document.getElementById("totalScore").textContent =
        total;

    document.getElementById("averageScore").textContent =
        average.toFixed(2);

    document.getElementById("overallGrade").textContent =
        getGrade(average);


    document.getElementById("overallRemark").textContent =
        getOverallRemark(average);


    document
        .getElementById("resultSection")
        .classList.remove("hidden");


    document
        .getElementById("resultSection")
        .scrollIntoView({
            behavior: "smooth"
        });
}


// Overall remark
function getOverallRemark(average) {

    if (average >= 80) {
        return "Outstanding academic performance. Keep up the excellent work.";
    }

    if (average >= 70) {
        return "Very good academic performance. Continue working hard.";
    }

    if (average >= 60) {
        return "Good performance. There is room for further improvement.";
    }

    if (average >= 50) {
        return "Satisfactory performance. More effort is recommended.";
    }

    return "Performance needs significant improvement.";
}


// Reset
function resetResult() {

    document
        .getElementById("resultSection")
        .classList.add("hidden");

    document
        .getElementById("admissionNumber")
        .value = "";

    document
        .getElementById("errorMessage")
        .textContent = "";

    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });
}