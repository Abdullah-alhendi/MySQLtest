<?php
// Database connection
include 'conection.php';

// Ensure student_id is sent via POST
if (isset($_POST['student_id'])) {
    $student_id = $_POST['student_id'];

    // Query to fetch student data using student_id
    $stmt = $pdo->prepare("SELECT * FROM Students WHERE student_id = ?");
    $stmt->execute([$student_id]);

    // Check if data exists
    $student = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // If data exists, display it in the form
    if ($student) {
        // Display data in the form or perform any other action
        echo "Student: " . $student['first_name'] . " " . $student['last_name'];
    } else {
        echo "Student not found!";
    }
} else {
    echo "student_id was not sent!";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Student</h2>
    <form action="form.php" method="post" enctype="multipart/form-data">
        <input type="hidden" name="student_id" value="<?= $student['student_id'] ?>">
        <input type="text" name="first_name" value="<?= $student['first_name'] ?>" class="form-control mb-2" required>
        <input type="text" name="last_name" value="<?= $student['last_name'] ?>" class="form-control mb-2" required>
        <input type="email" name="email" value="<?= $student['email'] ?>" class="form-control mb-2" required>
        <input type="text" name="major" value="<?= $student['major'] ?>" class="form-control mb-2" required>
        <input type="file" name="profile_image" class="form-control mb-2">
        <button type="submit" name="action" value="update" class="btn btn-success">Update</button>
    </form>
</div>
</body>
</html>
