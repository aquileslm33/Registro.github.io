<?php
// Configuración de la base de datos
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'fisiosport_db');

// Configuración de la aplicación
define('APP_NAME', 'FisioSport');
define('APP_VERSION', '1.0.0');
define('APP_SESSION_NAME', 'fisiosport_session');

// Configuración de seguridad
define('SECRET_KEY', 'tu_clave_secreta_única_aqui');
define('PASSWORD_COST', 10); // Coste para bcrypt

// Conexión a la base de datos
try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8", 
        DB_USER, 
        DB_PASS, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
} catch (PDOException $e) {
    error_log("Error de conexión a la base de datos: " . $e->getMessage());
    die("Error al conectar con la base de datos. Por favor, inténtelo más tarde.");
}

// Iniciar sesión segura
session_name(APP_SESSION_NAME);
session_start();

// Función para verificar autenticación
function isAuthenticated() {
    return isset($_SESSION['user_id']) && !empty($_SESSION['user_id']);
}

// Función para redirigir si no está autenticado
function requireAuth() {
    if (!isAuthenticated()) {
        header('Location: login.php');
        exit;
    }
}

// Función para hashear contraseñas
function hashPassword($password) {
    return password_hash($password, PASSWORD_BCRYPT, ['cost' => PASSWORD_COST]);
}

// Función para verificar contraseña
function verifyPassword($password, $hash) {
    return password_verify($password, $hash);
}
?>