-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS fisiosport_db;
USE fisiosport_db;

-- Tabla de usuarios (para autenticación)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de pacientes
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    deporte VARCHAR(50) NOT NULL,
    alergias TEXT,
    historial_medico TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de notas médicas
CREATE TABLE notas_medicas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    contenido TEXT NOT NULL,
    fecha DATE NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);

-- Tabla de visitas
CREATE TABLE visitas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    tipo ENUM('Consulta', 'Tratamiento', 'Revisión', 'Terapia') NOT NULL,
    estado ENUM('Programada', 'Completada', 'Cancelada') DEFAULT 'Programada',
    notas TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE
);

-- Insertar usuario por defecto (Fisiosport/FS120321)
INSERT INTO usuarios (username, password_hash, nombre_completo) 
VALUES ('Fisiosport', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Usuario Administrador');

-- Datos de ejemplo
INSERT INTO pacientes (nombre, fecha_nacimiento, genero, telefono, email, deporte, alergias, historial_medico) 
VALUES 
('Juan Pérez', '1985-04-23', 'Masculino', '5551234567', 'juan@email.com', 'Fútbol', 'Penicilina', 'Lesión de rodilla en 2018. Cirugía de menisco.'),
('María García', '1990-11-15', 'Femenino', '5557654321', 'maria@email.com', 'Tenis', NULL, 'Dolor crónico en hombro derecho.');

INSERT INTO notas_medicas (paciente_id, titulo, contenido, fecha) 
VALUES 
(1, 'Primera consulta', 'Paciente presenta dolor en rodilla izquierda. Se recomienda terapia física 2 veces por semana.', '2023-01-10'),
(2, 'Evaluación inicial', 'Limitación de movimiento en hombro derecho. Iniciar programa de rehabilitación.', '2023-01-12');

INSERT INTO visitas (paciente_id, fecha, hora, tipo, estado, notas) 
VALUES 
(1, '2023-01-17', '10:00:00', 'Tratamiento', 'Completada', 'Sesión de electroterapia y ejercicios de fortalecimiento.'),
(2, '2023-01-18', '11:30:00', 'Consulta', 'Programada', 'Revisión de progreso.');