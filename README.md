# Sistema POS - Punto de Venta

>  **Trabajo Final Integrador** - Metodología de Sistemas II  
>  **Comisión 2.2**
>  **Integrantes: Jennifer Coronel - Nahuel Espinola**

---

## Tabla de Contenidos

- [Características](#características)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Ejecución/Instalación con Docker](#opción-alternativa-ejecución-con-docker)
- [Testing y Calidad](#testing-y-calidad)
- [CI/CD](#cicd)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Tecnologías](#tecnologías)
---

## Características

### Módulos Principales

- **Gestión de Productos**
    - CRUD completo de productos
    - Organización por categorías
    - Control de stock
    - Búsqueda por código de barras o nombre

- **Gestión de Clientes**
    - Registro de clientes
    - Información de contacto

- **Punto de Venta (POS)**
    - Interfaz reactiva con Livewire
    - Búsqueda instantánea de productos
    - Carrito de compras dinámico
    - Cálculo automático de totales

- **Ventas**
    - Registro de transacciones
    - Historial de ventas realizadas
    - Detalle de productos por venta

- **Configuración**
    - Datos básicos de la empresa
    - Configuración de impuestos

### Características Técnicas
- **Testing:** Tests Unitarios y de Integración (Feature) automatizados.
- **CI/CD:** Pipeline de GitHub Actions para testing automático.
- **Calidad:** Estándares de código PSR-12 validados con Laravel Pint.
- **Git:** Historial basado en Conventional Commits.

---

## Requisitos

- **PHP**: 8.3 o superior
- **MySQL**: 8.4+ / MariaDB
- **Composer**: 2.x
- **Node.js**: 22.x+ & NPM

---

## Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/nahueldevup/Punto-De-Venta-Pipos
cd Punto-De-Venta-Pipos
```

### 2. Instalar Dependencias PHP

```bash
composer install
npm install && npm run build
```

### 3. Configurar Variables de Entorno

```bash
cp .env.example .env
php artisan key:generate
```

### 4. Configurar Base de Datos

Edita el archivo `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=mi_pos_4
DB_USERNAME=root
DB_PASSWORD=tu_password
```

### 5. Crear la Base de Datos

```bash
# MySQL
mysql -u root -p
CREATE DATABASE mi_pos_4;
exit;
```

### 6. Ejecutar Migraciones y Seeders

```bash
php artisan migrate --seed
```

Esto creará:
- Todas las tablas necesarias
- Un usuario de prueba: `test@example.com` / `password`
- Configuración inicial del sistema

### 7. Compilar Assets

```bash
# Para desarrollo
npm run dev

# Para producción
npm run build
```
## Opción Alternativa: Ejecución con Docker

Si prefieres usar Docker en lugar de instalar dependencias manualmente:

1. **Copiar entorno:**
```bash
   cp .env.example .env
```
2. **Iniciar contenedores:**
```bash
   docker-compose up -d
```
3. **Instalar dependencias (dentro del contenedor):**
```bash
docker-compose exec app composer install
docker-compose exec app npm install && npm run build
docker-compose exec app php artisan migrate --seed
```
### 8. Iniciar el Servidor

```bash
# Usando npm (Laravel + Vite simultáneamente)
npm run serve
```

Accede a: **http://localhost:8000**

---

## Testing y Calidad

### Ejecutar Tests

```bash
# Todos los tests
php artisan test

# Tests con cobertura
php artisan test --coverage

# Tests específicos
php artisan test --filter ProductTest
```

### Estructura de Tests

```
tests/
├── Unit/              # Tests unitarios
│   ├── ProductTest.php
│   ├── CategoryTest.php
│   ├── CustomerTest.php
│   └── SettingTest.php
└── Feature/           # Tests de integración
    ├── SaleTest.php
    └── ProductControllerTest.php
```

### Ejecutar Laravel Pint (formateador)

Utilizamos Laravel Pint para mantener el estilo de código limpio y estandarizado.

```bash
./vendor/bin/pint
```

---

## CI/CD

### Pipeline Automatizado

El proyecto utiliza GitHub Actions para integración continua. Cada vez que se realiza un push a la rama main, se ejecuta automáticamente el archivo `.github/workflows/laravel.yml` que:

1. Instala el entorno PHP y dependencias.
2. Ejecuta la suite de tests completa.
3. Verifica la integridad del código.

---

## Estructura del Proyecto

```
Punto-De-Venta-Pipos/
├── app/
│   ├── Http/
│   │   ├── Controllers/        # Controladores
│   │   └── Requests/           # Form Requests (validaciones)
│   ├── Livewire/              # Componentes Livewire
│   └── Models/                # Modelos Eloquent
├── database/
│   ├── factories/             # Factories para testing
│   ├── migrations/            # Migraciones
│   └── seeders/               # Seeders
├── resources/
│   ├── css/                   # Estilos (Tailwind)
│   ├── js/                    # JavaScript
│   └── views/                 # Vistas Blade
│       ├── layouts/           # Layout principal
│       ├── livewire/          # Templates Livewire
│       └── [módulos]/         # Vistas por módulo
├── routes/
│   └── web.php                # Rutas
├── tests/
│   ├── Feature/               # Tests de integración
│   └── Unit/                  # Tests unitarios
├── .github/
│   └── workflows/
│       └── ci.yml             # Pipeline CI/CD
├── phpcs.xml                  # Config PHP Code Sniffer
├── phpstan.neon               # Config PHPStan
└── docker-compose.yml         # MySQL para desarrollo
```

---

## Tecnologías

### Backend
- **Framework**: Laravel 12
- **Reactive UI**: Livewire 3
- **Database**: MySQL 8.3+
- **ORM**: Eloquent
- **Testing**: Pest / PHPUnit

### Frontend
- **CSS Framework**: Tailwind CSS 3
- **Templates**: Blade
- **Build Tool**: Vite
- **Icons**: Emoji / Lucide
- **JavaScript**: Alpine.js (via Livewire)

### Herramientas
- **CI/CD**: GitHub Actions
- **Calidad**: Laravel Pint
- **Version Control**: Git + Conventional Commits

---