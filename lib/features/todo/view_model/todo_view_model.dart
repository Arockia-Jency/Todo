import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../data/supabase_client/supabase_service.dart';

class TodoViewModel extends ChangeNotifier {
  // Use the static client from your service
  final _client = SupabaseService.client;

  List<TaskModel> tasks = [];
  bool isLoading = false;

  TodoViewModel() {
    _init();
  }

  Future<void> _init() async {
    try {
      if (SupabaseService.currentUser == null) {
        debugPrint("Attempting Anonymous Sign-in...");
        await _client.auth.signInAnonymously();
      }
      await fetchTasks();
    } catch (e) {
      // This will catch the 'anonymous_provider_disabled' error if not enabled in dashboard
      debugPrint("Init Error: $e");
    }
  }


  // READ
  Future<void> fetchTasks() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _client
          .from('tasks')
          .select()
          .order('created_at', ascending: false);

      tasks = (response as List).map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Fetch Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // CREATE
  Future<void> addTask(String title) async {
    final user = SupabaseService.currentUser;

    if (user == null) {
      debugPrint("Error: Still No Authenticated User. Check if Anonymous Auth is enabled in Supabase Dashboard.");
      return;
    }

    try {
      await _client.from('tasks').insert({
        'task': title,
        'user_id': user.id,
        'is_done': false,
      });
      debugPrint("Task added successfully!");
      await fetchTasks();
    } catch (e) {
      debugPrint("Add Error: $e");
    }
  }

// EDIT / UPDATE TEXT
  Future<void> updateTaskName(String id, String newName) async {
    try {
      await _client
          .from('tasks')
          .update({'task': newName}) // Update the text column
          .eq('id', id);             // Match the specific task ID

      debugPrint("Task updated successfully!");
      await fetchTasks(); // Refresh the list to show changes
    } catch (e) {
      debugPrint("Update Name Error: $e");
    }
  }

  // UPDATE - Fixed variable name from _supabase to _client
  Future<void> toggleTask(TaskModel task) async {
    try {
      await _client
          .from('tasks')
          .update({'is_done': !task.isDone})
          .eq('id', task.id);
      await fetchTasks();
    } catch (e) {
      debugPrint("Update Error: $e");
    }
  }

  // DELETE - Fixed variable name from _supabase to _client
  Future<void> deleteTask(String id) async {
    try {
      await _client.from('tasks').delete().eq('id', id);
      await fetchTasks();
    } catch (e) {
      debugPrint("Delete Error: $e");
    }
  }
}