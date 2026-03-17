# 📱 Aplicación Educativa Offline (MVP)

## 🧠 Problema

En zonas rurales, muchos estudiantes abandonan sus estudios debido a:

- Limitaciones económicas
- Necesidad de trabajar
- Falta de acceso constante a internet
- Dificultad para mantenerse al día con actividades escolares

Cuando un estudiante pierde continuidad (clases, tareas, contenido), aumenta significativamente la probabilidad de deserción educativa.

---

## 🎯 Propuesta de solución

Desarrollar una aplicación móvil **offline-first** que permita a los estudiantes:

- Acceder a contenido educativo sin internet
- Mantenerse informados mediante noticias escolares
- Registrar su progreso académico
- Reforzar la motivación mediante retroalimentación positiva

La aplicación está diseñada para funcionar completamente sin conexión, siendo adecuada para contextos con conectividad limitada o inexistente.

---

## ⚙️ Enfoque técnico

- **Arquitectura:** Offline-first
- **Persistencia:** Base de datos local (Room / SQLite)
- **Acceso a contenido:** Recursos locales (JSON, multimedia)
- **Backend:** No requerido (MVP)

---

## 🧩 Módulos implementados

### 🔐 1. Login básico (local)

Permite identificar al usuario sin necesidad de conexión.

**Funcionalidades:**

- Ingreso mediante nombre de usuario
- Validación básica de datos
- Persistencia de sesión (SharedPreferences)
- Opción de cerrar sesión

---

### 🗄️ 2. Base de datos local

Gestiona toda la información de la aplicación sin depender de internet.

**Incluye:**

- Almacenamiento de contenido educativo
- Registro de progreso del estudiante
- Almacenamiento de noticias

---

### 📚 3. Contenido educativo

Permite al estudiante acceder a recursos de aprendizaje.

**Funcionalidades:**

- Listado de contenidos
- Visualización de contenido (texto y multimedia)
- Acceso completamente offline

---

### ✅ 4. Progreso del estudiante

Permite registrar y visualizar el avance académico.

**Funcionalidades:**

- Marcar contenidos como completados
- Almacenamiento del progreso en base de datos local
- Visualización del estado (completado / pendiente)

---

### 📰 5. Noticias

Mantiene al estudiante informado sobre actividades o avisos.

**Funcionalidades:**

- Listado de noticias locales
- Visualización de detalles
- Carga desde datos locales (JSON)

---

### 🖼️ 6. Multimedia simple

Refuerza el aprendizaje mediante recursos visuales.

**Funcionalidades:**

- Uso de imágenes locales optimizadas
- Reproducción de contenido multimedia básico (video local opcional)

---

### 😊 7. Motivación y satisfacción

Busca reducir la deserción mediante refuerzo positivo.

**Funcionalidades:**

- Mensajes de reconocimiento al completar contenido
- Indicadores visuales de progreso
- Retroalimentación simple al usuario

---

## 🚧 Alcance del MVP

Este proyecto se enfoca en:

- Funcionamiento sin conexión a internet
- Simplicidad en la experiencia de usuario
- Validación de la idea como solución educativa

---

## 🔮 Trabajo futuro

- Sincronización con servidor central
- Integración con plataformas educativas
- Uso de centros comunitarios con acceso a internet
- Recomendaciones personalizadas

---

## 🧠 Justificación técnica

El enfoque **offline-first** permite:

- Garantizar acceso continuo al contenido educativo
- Reducir dependencia de infraestructura tecnológica
- Adaptarse a contextos rurales reales

---

## 📊 Resultado esperado

Una aplicación funcional que:

- Puede ejecutarse completamente sin internet
- Permite al estudiante mantenerse al día con su aprendizaje
- Reduce la fricción que contribuye a la deserción
