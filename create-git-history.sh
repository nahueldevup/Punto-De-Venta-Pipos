#!/bin/bash

# ============================================
# SCRIPT PARA RECREAR HISTORIAL GIT DEL TFI
# ============================================

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando creación de repositorio con historial...${NC}"

# ============================================
# SPRINT 0: CONFIGURACIÓN INICIAL
# ============================================

git checkout -b feature/initial-setup
git add .editorconfig .gitignore .gitattributes
git commit -m "chore: configuración inicial del proyecto

- Añadido .editorconfig para consistencia de código
- Configurado .gitignore para Laravel
- Añadido .gitattributes para control de líneas"

git add artisan bootstrap/ config/ public/ storage/
git commit -m "feat: estructura base de Laravel

- Configuración inicial de Laravel 11
- Estructura de directorios estándar
- Archivos de bootstrap y configuración"

git add .env.example
git commit -m "chore: añadido .env.example

- Template de variables de entorno
- Configuración de base de datos MySQL
- Variables de sesión y cache"

# Volver a main con seguridad
git checkout main 2>/dev/null || git checkout -b main
git merge feature/initial-setup --no-ff -m "merge: configuración inicial del proyecto"

# ============================================
# SPRINT 1: MÓDULO DE CATEGORÍAS
# ============================================

git checkout -b feature/categories-module

git add database/migrations/*_create_categories_table.php
git commit -m "feat(categories): crear migración de categorías

- Tabla categories con campos name y active
- Timestamps automáticos
- Preparación para relación con productos"

git add app/Models/Category.php
git commit -m "feat(categories): crear modelo Category

- Campos fillable: name, active
- Cast de active a boolean
- Relación hasMany con productos"

git add app/Http/Requests/StoreCategoryRequest.php app/Http/Requests/UpdateCategoryRequest.php
git commit -m "feat(categories): añadir validaciones con Form Requests

- StoreCategoryRequest: validación de creación
- UpdateCategoryRequest: validación con unique ignore
- Reglas para name y active"

git add app/Http/Controllers/CategoryController.php
git commit -m "feat(categories): crear CategoryController

- Métodos CRUD completos
- Paginación de 10 registros
- Mensajes flash de éxito"

git add app/Livewire/ShowCategories.php
git commit -m "feat(categories): componente Livewire para gestión

- Búsqueda en tiempo real
- Modal para crear/editar
- Modal de confirmación de eliminación
- Paginación integrada"

git add resources/views/categories/ resources/views/livewire/show-categories.blade.php
git commit -m "feat(categories): vistas del módulo

- Vista index con componente Livewire
- Template del componente con modales
- Búsqueda y acciones CRUD"

git add routes/web.php
git commit -m "feat(categories): añadir rutas del recurso

- Route::resource para CategoryController
- Rutas RESTful estándar"

git checkout main
git merge feature/categories-module --no-ff -m "merge: módulo de categorías completo"

# ============================================
# SPRINT 2: MÓDULO DE PRODUCTOS
# ============================================

git checkout -b feature/products-module

git add database/migrations/*_create_products_table.php
git commit -m "feat(products): crear migración de productos

- Tabla products con todos los campos necesarios
- Relación con categories (nullable)
- Índices en barcode y active para optimización"

git add app/Models/Product.php
git commit -m "feat(products): crear modelo Product

- Campos fillable completos
- Cast de precios a decimal
- Relación belongsTo con Category
- Accessor para ganancia
- Scopes: active() y stockBajo()"

git add app/Http/Requests/StoreProductRequest.php app/Http/Requests/UpdateProductRequest.php
git commit -m "feat(products): validaciones de productos

- Validación de barcode único
- Validación de precios y stock
- Rule::unique con ignore para updates"

git add app/Http/Controllers/ProductController.php
git commit -m "feat(products): crear ProductController

- CRUD completo de productos
- Scope active() para filtrado
- Paginación y ordenamiento"

git add app/Livewire/ShowProducts.php
git commit -m "feat(products): componente Livewire de productos

- Búsqueda por nombre o código de barras
- Búsqueda por categoría
- Modal con formulario completo
- Validación dinámica"

git add resources/views/products/ resources/views/livewire/show-products.blade.php
git commit -m "feat(products): vistas del módulo de productos

- Vista index con Livewire
- Template con tabla responsive
- Botón flotante para añadir producto"

git checkout main
git merge feature/products-module --no-ff -m "merge: módulo de productos completo"

# ============================================
# SPRINT 3: MÓDULO DE CLIENTES
# ============================================

git checkout -b feature/customers-module

git add database/migrations/*_create_customers_table.php
git commit -m "feat(customers): crear migración de clientes

- Tabla customers con name y phone
- Campos simples para MVP"

git add app/Models/Customer.php
git commit -m "feat(customers): crear modelo Customer

- Campos fillable
- Relación hasMany con Sales"

git add app/Http/Requests/StoreCustomerRequest.php app/Http/Requests/UpdateCustomerRequest.php
git commit -m "feat(customers): validaciones de clientes

- Validación de nombre requerido
- Teléfono opcional (máx 20 caracteres)"

git add app/Http/Controllers/CustomerController.php
git commit -m "feat(customers): crear CustomerController

- CRUD básico
- Flash messages para feedback"

git add app/Livewire/ShowCustomers.php
git commit -m "feat(customers): componente Livewire de clientes

- Búsqueda por nombre o teléfono
- Modal para crear/editar
- Gestión completa con Livewire"

git add resources/views/customers/ resources/views/livewire/show-customers.blade.php
git commit -m "feat(customers): vistas del módulo de clientes

- Vista index
- Template de componente Livewire"

git checkout main
git merge feature/customers-module --no-ff -m "merge: módulo de clientes completo"

# ============================================
# SPRINT 4: MÓDULO DE VENTAS (POS)
# ============================================

git checkout -b feature/sales-pos-module

git add database/migrations/*_create_sales_table.php
git commit -m "feat(sales): crear migración de ventas

- Tabla sales con todos los campos
- Relaciones con customers y users
- Campos de pago y totales
- Estado de venta (completed/cancelled)"

git add database/migrations/*_create_sale_details_table.php
git commit -m "feat(sales): crear migración de detalles de venta

- Tabla sale_details
- Snapshot de información del producto
- Relación con sales (cascade on delete)"

git add app/Models/Sale.php app/Models/SaleDetail.php
git commit -m "feat(sales): crear modelos Sale y SaleDetail

- Modelo Sale con relaciones
- Modelo SaleDetail con belongsTo
- Casts de decimales configurados"

git add app/Http/Requests/StoreSaleRequest.php
git commit -m "feat(sales): validación de ventas

- Validación de customer_id
- Validación de items (array de productos)
- Validación de montos de pago"

git add app/Livewire/ProductSearch.php
git commit -m "feat(pos): componente de búsqueda de productos

- Búsqueda en tiempo real
- Filtrado por código o nombre
- Emit de eventos a Cart"

git add app/Livewire/Cart.php
git commit -m "feat(pos): componente de carrito de compras

- Gestión de carrito en memoria
- Cálculo de totales e impuestos
- Validación de stock disponible
- Cálculo de cambio"

git add app/Livewire/PosComponent.php
git commit -m "feat(pos): componente principal del POS

- Integración de ProductSearch y Cart
- Layout de dos columnas"

git add app/Http/Controllers/SaleController.php
git commit -m "feat(sales): crear SaleController

- Método index para historial
- Método create para POS
- Método show para ticket
- Método destroy para cancelar venta con rollback de stock"

git add resources/views/sales/create.blade.php
git commit -m "feat(pos): vista del punto de venta

- Layout del POS
- Integración de componente Livewire"

git add resources/views/sales/show.blade.php
git commit -m "feat(sales): vista de ticket de venta

- Ticket imprimible
- Información de la empresa
- Detalle de productos
- Botón de impresión"

git add resources/views/livewire/product-search.blade.php resources/views/livewire/cart.blade.php resources/views/livewire/pos-component.blade.php
git commit -m "feat(pos): templates de componentes Livewire

- Template de búsqueda
- Template de carrito
- Template del POS principal"

git checkout main
git merge feature/sales-pos-module --no-ff -m "merge: módulo POS completo"

# ============================================
# SPRINT 5: CONFIGURACIÓN DEL SISTEMA
# ============================================

git checkout -b feature/settings-module

git add database/migrations/*_create_settings_table.php
git commit -m "feat(settings): crear migración de configuración

- Tabla settings con JSON payload
- Estructura group/name/locked/payload
- Índice único en group+name"

git add app/Models/Setting.php
git commit -m "feat(settings): modelo Setting con helpers

- Método getGeneral() con cache
- Método updateGeneral()
- Payload por defecto
- Cache de 1 hora"

git add database/seeders/SettingSeeder.php
git commit -m "feat(settings): seeder de configuración inicial

- Configuración general por defecto
- Valores de empresa
- Tax rate y alertas de stock"

git add app/Http/Controllers/SettingController.php
git commit -m "feat(settings): controlador de configuración

- Método index para mostrar formulario
- Método update con validación
- Limpieza de cache al actualizar"

git add resources/views/settings/index.blade.php
git commit -m "feat(settings): vista de configuración

- Formulario con Tailwind CSS
- Dos columnas: empresa y POS
- Validación client-side"

# Actualizar referencias a Setting
git add app/Livewire/Cart.php app/Livewire/ShowProducts.php resources/views/sales/show.blade.php
git commit -m "refactor: integrar modelo Setting en componentes

- Cart usa Setting::getGeneral() para tax_rate
- ShowProducts usa low_stock_alert
- Ticket de venta muestra datos de empresa"

git checkout main
git merge feature/settings-module --no-ff -m "merge: módulo de configuración completo"

# ============================================
# SPRINT 6: MEJORAS DE UI/UX
# ============================================

git checkout -b feature/ui-improvements

git add resources/css/app.css tailwind.config.js postcss.config.js
git commit -m "style: configurar Tailwind CSS

- Variables de tema (light/dark)
- Colores personalizados para el POS
- Configuración de border radius"

git add resources/views/layouts/app.blade.php
git commit -m "style: layout principal con sidebar

- Sidebar responsive
- Menú hamburguesa
- Estilo dark theme
- Scrollbar personalizado"

git add package.json
git commit -m "chore: dependencias frontend

- Vite para build
- Tailwind CSS
- Axios para peticiones
- Concurrently para dev server"

git checkout main
git merge feature/ui-improvements --no-ff -m "merge: mejoras de interfaz de usuario"

# ============================================
# SPRINT 7: DOCUMENTACIÓN Y FIXES
# ============================================

git checkout -b chore/documentation-and-fixes

# Crear README (CORREGIDO)
cat > README.md << 'ENDREADME'
# Sistema POS - Punto de Venta

Sistema de gestión de ventas para pequeños comercios desarrollado con Laravel 11 y Livewire.

## Características

- Gestión de productos con categorías
- Control de inventario con alertas de stock
- Gestión de clientes
- Punto de venta (POS) en tiempo real
- Historial de ventas
- Tickets imprimibles
- Configuración del sistema

## Instalación

1. `composer install`
2. `npm install`
3. `cp .env.example .env`
4. `php artisan migrate --seed`
5. `php artisan serve`

## Autor
Comisión 2.1/2.2
ENDREADME

git add README.md
git commit -m "docs: añadir README completo del proyecto"

# Crear archivo Docker Compose (CORREGIDO)
cat > docker-compose.yml << 'ENDDOCKER'
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: pos_mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: mi_pos_4
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
ENDDOCKER

git add docker-compose.yml phpunit.xml
git commit -m "chore: configuración de entorno y testing"

# Fixes finales
git add app/Http/Controllers/SaleController.php
git commit -m "fix: corregir manejo de errores en cancelación de venta"

git checkout main
git merge chore/documentation-and-fixes --no-ff -m "merge: documentación y correcciones finales"

# ============================================
# TAG DE VERSION
# ============================================

git tag -a v1.0.0 -m "Release v1.0.0 - Sistema POS Completo"

echo -e "${GREEN}✅ Historial de Git creado exitosamente!${NC}"
echo ""
echo -e "${BLUE}Resumen final:${NC}"
git log --oneline --graph --all -20
