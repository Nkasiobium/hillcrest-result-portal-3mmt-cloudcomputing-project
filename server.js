require("dotenv").config();

const express = require("express");
const path = require("path");

const app = express();

const PORT = process.env.PORT || 3000;
const SCHOOL_NAME =
    process.env.SCHOOL_NAME ||
    "Hill Crest Secondary School, Awada";


// Serve frontend files
app.use(express.static(path.join(__dirname, "public")));


// Health check
app.get("/health", (req, res) => {
    res.json({
        status: "healthy",
        application: "Hill Crest Secondary School Result Portal",
        school: SCHOOL_NAME
    });
});


// Start server
app.listen(PORT, "0.0.0.0", () => {
    console.log(
        `${SCHOOL_NAME} running on port ${PORT}`
    );
});