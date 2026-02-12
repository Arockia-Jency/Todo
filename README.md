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

🚦 Getting Started
1. Prerequisites
Flutter SDK installed

A Supabase project created at supabase.com

2. Setup Database
Run the following SQL in your Supabase SQL Editor to create the tasks table:

create table tasks (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users not null,
  task text not null,
  is_done boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable RLS
alter table tasks enable row level security;
create policy "Users can manage their own tasks" on tasks for all using (auth.uid() = user_id);

3. Environment Variables
Create a .env file in the root directory and add your credentials:

SUPABASE_URL=YOUR_SUPABASE_PROJECT_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY

4. Run the App
flutter pub get
flutter run

👨‍💻 Developed By
Mobile Application Developer

Expertise: Swift (iOS) & Dart (Flutter)

Specialization: Enterprise Solutions & Clean Architecture


