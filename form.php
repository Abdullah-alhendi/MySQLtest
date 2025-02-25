<?php
include 'conection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == "create") {
    // Validate fields
    if (isset($_POST["first_name"], $_POST["last_name"], $_POST["email"], $_POST["date_of_birth"], $_POST["gender"], $_POST["major"], $_POST["enrollment_year"])) {
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $email = $_POST["email"];
        $date_of_birth = $_POST["date_of_birth"];
        $gender = $_POST["gender"];
        $major = $_POST["major"];
        $enrollment_year = $_POST["enrollment_year"];
        
        // Check for image upload
        $image_path = null; // Default to null if no image is uploaded

        if (isset($_FILES["profile_image"]) && $_FILES["profile_image"]["error"] === 0) {
            $image_name = time() . "_" . $_FILES["profile_image"]["name"]; // Add timestamp to prevent duplication
            $image_tmp = $_FILES["profile_image"]["tmp_name"];
            $upload_dir = "uploads/";

            // Create directory if it doesn't exist
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0777, true);
            }

            $image_path = $upload_dir . basename($image_name);

            if (move_uploaded_file($image_tmp, $image_path)) {
                echo "Image uploaded successfully!";
            } else {
                echo "Image upload failed!";
                $image_path = null; // Do not save path if upload fails
            }
        } else {
            echo "No image uploaded.";
        }

        // Insert data into the database
        $stmt = $pdo->prepare("INSERT INTO Students (first_name, last_name, email, date_of_birth, gender, major, enrollment_year, profile_image) 
                               VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

        if ($stmt->execute([$first_name, $last_name, $email, $date_of_birth, $gender, $major, $enrollment_year, $image_path])) {
            echo "Student added successfully!";
        } else {
            echo "Error adding student.";
        }
    } else {
        echo "All fields are required!";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Students List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>All Students</h2>
    <table class="table table-bordered">
        <tr>
            <th>Student ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Major</th>
            <th>Profile Image</th>
            <th>Actions</th>
        </tr>
        <?php
        // Retrieve data from the database
        $stmt = $pdo->query("SELECT * FROM Students");
        foreach ($stmt as $row) {
            echo "<tr>
                <td>{$row['student_id']}</td>
                <td>{$row['first_name']} {$row['last_name']}</td>
                <td>{$row['email']}</td>
                <td>{$row['major']}</td>
                <td>";
                // Check if the field exists in the array
                if (isset($row['profile_image']) && !empty($row['profile_image'])) {
                    echo '<img src="uploads/' . htmlspecialchars($row['profile_image']) . '" width="50">';
                } else {
                    echo '<img src="uploads/default.png" width="50">';
                }
            echo "</td>
            <td>
                <form method='post' action='edit.php'>
                    <input type='hidden' name='student_id' value='{$row["student_id"]}'>
                    <button type='submit' class='btn btn-warning'>Edit</button>
                </form>
            </td>
            </tr>";
        }
        ?>
    </table>
</div>
</body>
</html>
