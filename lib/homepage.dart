import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/game_buttons.dart';
import 'custom_dialog.dart';

class HomePage extends StatefulWidget {
  final bool singlePlayer;
  final bool multiPlayer;

  HomePage({this.singlePlayer, this.multiPlayer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonList;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    activeplayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activeplayer == 1) {
        gb.text = 'X';
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = 'O';
        gb.bg = Colors.black;
        activeplayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      var winner = checkwinner();
      if (winner == -1) {
        if (buttonList.every((p) => p.text != '')) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog(
                    title: 'Game Tied',
                    content: 'Press the reset button to start again!',
                    callback: resetGame,
                  ));
        } else {
          if (activeplayer == 2 && widget.singlePlayer == true) {
            autoPlay();
          }
        }
      }
    });
  }

  autoPlay() {
    var emptyCells = [];
    var list = List.generate(9, (index) => index + 1);
    for (var CellId in list) {
      if (!(player1.contains(CellId) || player2.contains(CellId))) {
        emptyCells.add(CellId);
      }
    }

    var r = Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randIndex];
    int i = buttonList.indexWhere((p) => p.id == cellId);
    playGame(buttonList[i]);
  }

  int checkwinner() {
    var winner = -1;

    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player1.contains(4) &&
        player1.contains(5) &&
        player1.contains(6)) {
      winner = 1;
    } else if (player1.contains(1) &&
        player1.contains(4) &&
        player1.contains(7)) {
      winner = 1;
    } else if (player1.contains(2) &&
        player1.contains(5) &&
        player1.contains(8)) {
      winner = 1;
    } else if (player1.contains(3) &&
        player1.contains(6) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(4) &&
        player2.contains(7)) {
      winner = 2;
    } else if (player2.contains(2) &&
        player2.contains(5) &&
        player2.contains(8)) {
      winner = 2;
    } else if (player2.contains(3) &&
        player2.contains(6) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player1.contains(7) &&
        player1.contains(8) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player1.contains(1) &&
        player1.contains(5) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player1.contains(3) &&
        player1.contains(5) &&
        player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    } else if (player2.contains(4) &&
        player2.contains(5) &&
        player2.contains(6)) {
      winner = 2;
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player2.contains(1) &&
        player2.contains(5) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player2.contains(3) &&
        player2.contains(5) &&
        player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  title: 'Player 1 Won!',
                  content: 'Press the reset button to start again',
                  callback: resetGame,
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                  title: 'Player 2 Won!',
                  content: 'Press the reset button to start again',
                  callback: resetGame,
                ));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          height: double.infinity,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: buttonList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: RaisedButton(
                        color: buttonList[index].bg,
                        disabledColor: buttonList[index].bg,
                        onPressed: buttonList[index].enabled
                            ? () => playGame(buttonList[index])
                            : null,
                        child: Text(
                          buttonList[index].text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                color: Colors.red,
                padding: EdgeInsets.all(20),
                onPressed: resetGame,
              )
            ],
          ),
        ),
      ),
    );
  }
}
