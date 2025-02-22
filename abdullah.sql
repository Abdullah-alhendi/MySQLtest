-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 07:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `abdullah`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `enroll_student` (IN `p_student_id` INT, IN `p_course_id` INT, IN `p_grade` VARCHAR(2))   BEGIN
    INSERT INTO enrollments (student_id, course_id, grade)
    VALUES (p_student_id, p_course_id, p_grade);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `enroll_student_if_capacity` (IN `p_student_id` INT, IN `p_course_id` INT, IN `p_grade` VARCHAR(2))   BEGIN
    DECLARE current_enrollment INT;
    DECLARE max_capacity INT;

    START TRANSACTION;
    
    -- Get the current number of students enrolled in the course
    SELECT COUNT(*) INTO current_enrollment
    FROM enrollments
    WHERE course_id = p_course_id;

    -- Get the maximum capacity of the course
    SELECT course_capacity INTO max_capacity
    FROM courses
    WHERE course_id = p_course_id;
    
    -- Check if the course capacity is exceeded
    IF current_enrollment < max_capacity THEN
        -- Enroll the student
        INSERT INTO enrollments (student_id, course_id, grade)
        VALUES (p_student_id, p_course_id, p_grade);
        
        COMMIT;
    ELSE
        -- Rollback if capacity is exceeded
        ROLLBACK;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_age` (`date_of_birth` DATE) RETURNS INT(11)  BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());
    RETURN age;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` text NOT NULL,
  `course_code` text NOT NULL,
  `credits` text NOT NULL,
  `department` text NOT NULL,
  `course_capacity` int(11) NOT NULL DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `course_code`, `credits`, `department`, `course_capacity`) VALUES
(1, 'Introduction to Programming', 'CS101', '3', 'Computer Science', 30),
(2, 'Intro to Programming', 'CS101', '3', 'Computer Science', 30),
(3, 'Advanced Mathematics', 'MATH301', '4', 'Mathematics', 30),
(4, 'General Physics', 'PHY201', '3', 'Physics', 30),
(5, 'Organic Chemistry', 'CHEM202', '3', 'Chemistry', 30),
(6, 'Molecular Biology', 'BIO304', '4', 'Biology', 30);

-- --------------------------------------------------------

--
-- Table structure for table `course_assignments`
--

CREATE TABLE `course_assignments` (
  `assignment_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `semester` text NOT NULL,
  `year` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_assignments`
--

INSERT INTO `course_assignments` (`assignment_id`, `instructor_id`, `course_id`, `semester`, `year`) VALUES
(1, 1, 101, 'Fall', '2025'),
(2, 1, 1, 'Fall', '2025'),
(3, 2, 2, 'Fall', '2025'),
(4, 3, 3, 'Fall', '2025'),
(5, 4, 4, 'Fall', '2025'),
(6, 5, 5, 'Fall', '2025');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `grade` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `course_id`, `grade`) VALUES
(1, 1, 101, 'A'),
(2, 1, 1, 'A'),
(3, 1, 2, 'B'),
(4, 2, 3, 'A'),
(5, 2, 4, 'B'),
(6, 3, 5, 'A'),
(7, 3, 1, 'B'),
(8, 4, 2, 'A'),
(9, 4, 3, 'B'),
(10, 5, 4, 'A'),
(11, 5, 5, 'B'),
(12, 6, 1, 'A'),
(13, 6, 2, 'B'),
(14, 7, 3, 'A'),
(15, 7, 4, 'B'),
(16, 8, 5, 'A'),
(17, 8, 1, 'B'),
(18, 9, 2, 'A'),
(19, 9, 3, 'B'),
(20, 10, 4, 'A'),
(21, 10, 5, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE `instructors` (
  `instructor_id` int(11) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `email` text NOT NULL,
  `hire_date` text NOT NULL,
  `department` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`instructor_id`, `first_name`, `last_name`, `email`, `hire_date`, `department`) VALUES
(1, 'Jane', 'Smith', 'jane.smith@example.com', '2015-08-23', 'Mathematics'),
(2, 'John', 'Doe', 'john.doe@example.com', '2018-06-15', 'Computer Science'),
(3, 'Mary', 'Jane', 'mary.jane@example.com', '2016-04-20', 'Mathematics'),
(4, 'Paul', 'Walker', 'paul.walker@example.com', '2017-09-05', 'Physics'),
(5, 'Linda', 'Hill', 'linda.hill@example.com', '2019-01-12', 'Chemistry'),
(6, 'James', 'Bond', 'james.bond@example.com', '2015-03-30', 'Biology');

-- --------------------------------------------------------

--
-- Table structure for table `instructors_test`
--

CREATE TABLE `instructors_test` (
  `instructor_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` text NOT NULL,
  `major` varchar(100) NOT NULL,
  `enrollment_year` year(4) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `last_name`, `email`, `date_of_birth`, `gender`, `major`, `enrollment_year`, `age`, `deleted_at`, `updated_at`, `created_at`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2000-01-01', 'Male', 'Computer Science', '2021', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(2, 'Alice', 'Johnson', 'alice.johnson@example.com', '2001-02-14', 'Female', 'Computer Science', '2022', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(3, 'Bob', 'Smith', 'bob.smith@example.com', '2000-07-23', 'Male', 'Mathematics', '2021', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(4, 'Charlie', 'Brown', 'charlie.brown@example.com', '1999-11-04', 'Male', 'Physics', '2020', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(5, 'Diana', 'Ross', 'diana.ross@example.com', '2002-03-15', 'Female', 'Chemistry', '2023', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(6, 'Eve', 'White', 'eve.white@example.com', '2001-05-18', 'Female', 'Biology', '2022', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(7, 'Frank', 'Black', 'frank.black@example.com', '2000-09-21', 'Male', 'Computer Science', '2021', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(8, 'Grace', 'Green', 'grace.green@example.com', '2002-12-10', 'Female', 'Mathematics', '2023', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(9, 'Hank', 'Blue', 'hank.blue@example.com', '2001-06-11', 'Male', 'Physics', '2022', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(10, 'Ivy', 'Yellow', 'ivy.yellow@example.com', '2000-08-19', 'Female', 'Chemistry', '2021', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(11, 'Jack', 'Purple', 'jack.purple@example.com', '1999-10-25', 'Male', 'Biology', '2020', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42'),
(626, 'Abdullah', 'Alhendi', 'alhendi97@gmail.com', '1998-07-25', 'Male', 'Software engineering', '2017', NULL, NULL, '2025-02-20 10:44:16', '2025-02-20 12:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `students_test`
--

CREATE TABLE `students_test` (
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `major` varchar(50) DEFAULT NULL,
  `enrollment_year` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `idx_course_code` (`course_code`(768));

--
-- Indexes for table `course_assignments`
--
ALTER TABLE `course_assignments`
  ADD PRIMARY KEY (`assignment_id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `idx_student_id` (`student_id`),
  ADD KEY `idx_course_id` (`course_id`);

--
-- Indexes for table `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `instructors_test`
--
ALTER TABLE `instructors_test`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `course_assignments`
--
ALTER TABLE `course_assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `instructors`
--
ALTER TABLE `instructors`
  MODIFY `instructor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=627;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
