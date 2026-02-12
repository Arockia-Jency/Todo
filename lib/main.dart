import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/todo/view/todo_view.dart';
import 'features/todo/view_model/todo_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase using the .env variables
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    // Wrap with ChangeNotifierProvider to connect your ViewModel
    ChangeNotifierProvider(
      create: (context) => TodoViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoView(),
    );
  }
}