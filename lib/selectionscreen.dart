import 'package:flutter/material.dart';
import 'package:tictactoe/homepage.dart';

class SelectionScreen extends StatefulWidget {
  SelectionScreen({Key key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool singlePlayer;
  bool multiPlayer;

  @override
  void initState() {
    singlePlayer = false;
    multiPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black, scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 150)),
            Center(
                child: Text(
              'Choose Game Mode',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Single Player',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    singlePlayer = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                singlePlayer: this.singlePlayer,
                              )));
                },
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Multiplayer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    multiPlayer = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                multiPlayer: this.multiPlayer,
                              )));
                },
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
