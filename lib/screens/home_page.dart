import 'package:ex5/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ex5/providers/note_provider.dart';
import 'package:ex5/models/note.dart';
import 'package:ex5/screens/note_editor_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((time) {
      Provider.of<NoteProvider>(context, listen: false).loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ghi chú"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      body: Consumer<NoteProvider>(
        builder: (context, noteData, child) {
          if (noteData.notes.isEmpty) {
            return const Center(
              child: Text(
                "Chưa có ghi chú nào hết",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: noteData.notes.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, i) {
              final ghiChu = noteData.notes[i];
              return NoteCard(
                note: ghiChu,
                onTap: () {
                  _goEdit(context, ghiChu);
                },
                onDelete: () {
                  _showDelete(context, ghiChu.id!);
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goAdd(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _goAdd(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => const NoteEditorScreen()),
    );
  }

  void _goEdit(BuildContext ctx, Note note) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => NoteEditorScreen(note: note)),
    );
  }

  void _showDelete(BuildContext ctx, int id) {
    showDialog(
      context: ctx,
      builder: (c) {
        return AlertDialog(
          title: const Text("Xóa ghi chú"),
          content: const Text("Bạn có chắc muốn xóa không?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(c);
              },
              child: const Text("Không"),
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<NoteProvider>(
                  ctx,
                  listen: false,
                ).deleteNote(id);
                Navigator.pop(c);
              },
              child: const Text("Xóa", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}