import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:noteapp/data/note.dart';
import 'package:noteapp/data/util.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/detail_note_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note>? notes = [];
  final LocalStorage storage = new LocalStorage('note.json');
  @override
  void initState() {
    notes!.add(Note(id: 'test-test', title: "Judul", body: "Contoh Body"));
    super.initState();
  }

  void _incrementCounter() {
    setState(() {});
  }

  _toggleItem(Note item) {
    setState(() {
      _saveToStorage();
    });
  }

  _addItem(String title, String body) {
    setState(() {
      _saveToStorage();
    });
  }

  _saveToStorage() {
    // storage.setItem('todos', list.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      // list.items = storage.getItem('todos') ?? [];
    });
  }

  void detailNote(Note note) {
    //find note in notes and pop from notes
    notes!.removeWhere((element) => element.id == note.id);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailNotePage(
                  note: note,
                ))).then((note) {
      if (note != null) {
        setState(() {
          if (note.title != '' || note.body != '') notes!.add(note);
        });
      } else
        setState(() {});
    });
  }

  void createNote() {
    //find note in notes and pop from notes
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailNotePage(
                  note:
                      Note(body: '', title: '', id: DateTime.now().toString()),
                ))).then((note) {
      if (note != null) {
        setState(() {
          if (note.title != '' || note.body != '') notes!.add(note);
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Text(
                'NoteKoe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                'Halo Selamat Datang di NoteKoe',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List Note',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < notes!.length; i++)
                    GestureDetector(
                      onTap: () {
                        detailNote(notes![i]);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints(minHeight: 90),
                        decoration: BoxDecoration(
                          color: grayColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${notes![i].title}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${(notes![i].body.length > 50) ? notes![i].body.substring(0, 50) + '...' : notes![i].body}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (notes!.length == 0)
                    Center(
                      child: Text('Tidak ada note'),
                    )
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
