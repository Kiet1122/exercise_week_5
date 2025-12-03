import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ex5/models/note.dart';
import 'package:ex5/providers/note_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note; 

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  bool dangSua = false;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      dangSua = true;
      titleCtrl.text = widget.note!.title;
      contentCtrl.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  void luuNote() async {
    if (titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nhập tiêu đề trước nha")),
      );
      return;
    }

    final provider = Provider.of<NoteProvider>(context, listen: false);
    final now = DateTime.now();

    if (dangSua) {
      Note n = Note(
        id: widget.note!.id,
        title: titleCtrl.text,
        content: contentCtrl.text,
        createdAt: widget.note!.createdAt,
        updatedAt: now,
      );

      await provider.updateNote(n);
    } else {
      Note n = Note(
        title: titleCtrl.text,
        content: contentCtrl.text,
        createdAt: now,
        updatedAt: now,
      );

      await provider.addNote(n);
    }

    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dangSua ? "Sửa ghi chú" : "Thêm ghi chú"),
        actions: [
          TextButton(
            onPressed: luuNote,
            child: const Text("Lưu"),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: "Tiêu đề",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: TextField(
                controller: contentCtrl,
                decoration: const InputDecoration(
                  hintText: "Nhập nội dung",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
