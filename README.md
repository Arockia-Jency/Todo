# 🚀 Flutter Modern Todo App - MVVM & Supabase

A high-performance, real-time Todo application built with **Flutter** and **Supabase**. This project demonstrates a clean implementation of the **MVVM (Model-View-ViewModel)** architectural pattern, ensuring a clear separation of concerns and high maintainability.

---

## ✨ Features

- **Anonymous Authentication**: Secure user sessions using Supabase Auth.
- **CRUD Operations**: Create, Read, Update (Text & Completion Status), and Delete tasks.
- **Modern UI/UX**: Custom gradient design with a polished, user-friendly interface.
- **State Management**: Optimized UI updates using the `Provider` package.
- **Security**: Row Level Security (RLS) ensures users can only access their own data.
- **Environment Safety**: Sensitive API keys are managed via `.env` files.

---

## 🛠 Tech Stack

| Category            | Technology                          |
|---------------------|-------------------------------------|
| **Frontend** | Flutter (Dart)                      |
| **Backend** | Supabase (PostgreSQL, Auth)         |
| **Architecture** | MVVM (Model-View-ViewModel)         |
| **State Management**| Provider                            |
| **Local Config** | flutter_dotenv                      |

---

## 🏗 Project Structure

```text
lib/
├── core/                # Global utilities and themes
├── data/                # Data layer
│   ├── models/          # TaskModel (Data structures)
│   ├── supabase_client/ # Supabase initialization & service
├── features/            # Feature-based modules (MVVM)
│   └── todo/            
│       ├── view/        # UI Layer (TodoView)
│       └── view_model/  # Logic Layer (TodoViewModel)
└── main.dart            # Entry point & App configuration
