import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:xylophone/Note.dart';
import 'dart:async';

class AudioControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AudioControlState();
}

class _AudioControlState extends State<AudioControl> {
  List<Note> notes = List();
  int currentNote = 0;

  void teclaSound(int nota) {
    final audioPlayer = AudioCache();
    audioPlayer.play('audios/sound$nota.mp3');
  }

  Expanded creaTecla(Note n) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          teclaSound(n.note);
          setState(() {
            notes.add(n);
          });
        },
        color: n.color,
      ),
    );
  }

  void playNotes() {
    int time = 0;
    for (var i = 0; i < notes.length; i++) {
      Timer(Duration(seconds: i * 2), () {
        teclaSound(notes[i].note);
        setState(() {
          currentNote = i;
        });
      });
    }
  }

  Future sleep4() {
    return new Future.delayed(const Duration(seconds: 4), () => "4");
  }

  Row pressedNotes() {
    if (notes.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Press colors to record")],
      );
    }

    List<Expanded> elements = List();

    for (var i = 0; i < notes.length; i++) {
      elements.add(Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: notes[i].color,
              border: (i == currentNote)
                  ? Border(top: BorderSide(color: Colors.black, width: 8))
                  : Border(top: BorderSide(color: Colors.black, width: 2))),
        ),
      ));
    }
    return Row(children: elements);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            creaTecla(Note(color: Colors.deepOrange, note: 1)),
            creaTecla(Note(color: Colors.green, note: 2)),
            creaTecla(Note(color: Colors.blue, note: 3)),
            creaTecla(Note(color: Colors.red, note: 4)),
            creaTecla(Note(color: Colors.yellow, note: 5)),
            creaTecla(Note(color: Colors.indigo, note: 6)),
            creaTecla(Note(color: Colors.lime, note: 7)),
            creaTecla(Note(color: Colors.blueAccent, note: 8)),
            creaTecla(Note(color: Colors.lightGreenAccent, note: 9)),
            creaTecla(Note(color: Colors.amber, note: 10)),
            Container(
              height: 55,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FlatButton(
                        child: Text("Restart"),
                        onPressed: () {
                          setState(() {
                            notes = [];
                            currentNote = 0;
                          });
                        },
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FlatButton(
                        child: Text("Play"),
                        onPressed: () {
                          playNotes();
                          setState(() {
                            currentNote = 0;
                          });
                        },
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 30, child: pressedNotes()),
          ],
        ),
      ),
    );
  }
}
