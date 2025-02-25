<?php include 'conection.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add New Student</h2>
    <form action="form.php" method="post" enctype="multipart/form-data">
        <input type="text" name="first_name" placeholder="First Name" class="form-control mb-2" required>
        <input type="text" name="last_name" placeholder="Last Name" class="form-control mb-2" required>
        <input type="email" name="email" placeholder="Email" class="form-control mb-2" required>
        <input type="date" name="date_of_birth" class="form-control mb-2" required>
        <select name="gender" class="form-control mb-2">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input type="text" name="major" placeholder="Major" class="form-control mb-2" required>
        <input type="number" name="enrollment_year" placeholder="Enrollment Year" class="form-control mb-2" required>
        <input type="file" name="profile_image" class="form-control mb-2" required>
        <button type="submit" name="action" value="create" class="btn btn-primary">Add Student</button>
    </form>
</div>
</body>
</html>
