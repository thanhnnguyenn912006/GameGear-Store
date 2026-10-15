<?php
// Cấu hình kết nối MySQL cho XAMPP
$host = 'localhost';
$dbname = 'gamegear_store';
$username = 'root';
$password = '';
$charset = 'utf8mb4';
$dsn = "mysql:host=$host;dbname=$dbname;charset=$charset";
$options = [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES => false];
try { $pdo = new PDO($dsn, $username, $password, $options); }
catch (PDOException $e) { exit('Không thể kết nối CSDL. Hãy import sql/gamegear_store.sql trong phpMyAdmin và kiểm tra config.php.'); }
if (session_status() === PHP_SESSION_NONE) session_start();
function e($value) { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function money($value) { return number_format((float)$value, 0, ',', '.') . ' đ'; }
function is_admin() { return isset($_SESSION['user']) && $_SESSION['user']['role'] === 'admin'; }
function require_admin() { if (!is_admin()) { header('Location: ../login.php'); exit; } }
?>
