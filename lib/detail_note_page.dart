import 'package:flutter/material.dart';
import 'package:noteapp/data/note.dart';
import 'package:noteapp/data/util.dart';

class DetailNotePage extends StatelessWidget {
  const DetailNotePage({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, note);
            return false;
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView(children: [
              //back button
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, note);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text('Detail Note',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Judul',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: grayColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: TextEditingController(text: note.title),
                        onChanged: (value) {
                          note.title = value;
                        },
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Isi',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      minLines: 8,
                      maxLines: 100,
                      //or null
                      //add padding to textfield
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        filled: true,
                        fillColor: grayColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: TextEditingController(text: note.body),
                      onChanged: (value) {
                        note.body = value;
                      },
                    ),
                  ],
                ),
              )
            ]),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Trash',
        child: const Icon(Icons.delete),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
