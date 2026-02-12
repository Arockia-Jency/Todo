import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/task_model.dart';
import '../view_model/todo_view_model.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () => viewModel.fetchTasks(),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], // Deep Blue/Purple Gradient
          ),
        ),
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
          children: [
            const SizedBox(height: 100), // Spacing for transparent AppBar
            _buildHeader(viewModel.tasks.length),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 100),
                  itemCount: viewModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = viewModel.tasks[index];
                    return _buildTaskCard(context, viewModel, task);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2575FC),
        onPressed: () => _showAddTaskDialog(context, viewModel),
        icon: const Icon(Icons.add_task),
        label: const Text("Add New Task"),
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today's Plan",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(15)),
            child: Text("$count Tasks", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, TodoViewModel viewModel, TaskModel task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            activeColor: const Color(0xFF6A11CB),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: task.isDone,
            onChanged: (_) => viewModel.toggleTask(task),
          ),
        ),
        title: Text(
          task.task,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: task.isDone ? Colors.grey : Colors.black87,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_note_rounded, color: Colors.blueAccent, size: 28),
              onPressed: () => _showEditTaskDialog(context, viewModel, task),
            ),
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent, size: 28),
              onPressed: () => viewModel.deleteTask(task.id),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TodoViewModel viewModel) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter task name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                viewModel.addTask(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, TodoViewModel viewModel, TaskModel task) {
    final controller = TextEditingController(text: task.task);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter new task name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty && controller.text != task.task) {
                viewModel.updateTaskName(task.id, controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}