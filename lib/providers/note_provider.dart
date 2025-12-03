import 'package:ex5/database/db_helper.dart';
import 'package:ex5/models/note.dart';
import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;


  Future<void> loadNotes() async {
    _notes = await DatabaseHelper.instance.readALL();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await DatabaseHelper.instance.create(note);
    await loadNotes();
  }
  
  Future<void> updateNote(Note note) async {
    await DatabaseHelper.instance.update(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadNotes();
  }
}