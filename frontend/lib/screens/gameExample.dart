import 'package:flutter/material.dart';
import '../services/models/games.dart';

class GameExample extends StatefulWidget {
  final Game game;
  final String gameQuestion;
  const GameExample(
      {super.key, required this.game, required this.gameQuestion});

  @override
  State<GameExample> createState() => GameExampleState();
}

class GameExampleState extends State<GameExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/childSide/background_game1.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 20), // Use `const EdgeInsets`
            child: Center(
              // Ensures horizontal centering of the column
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    '${widget.gameQuestion} question',
                    textAlign:
                        TextAlign.center, // Center the text inside the widget
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration:
                        const BoxDecoration(color: Color.fromARGB(99, 0, 0, 0)),
                    child: Center(
                      child: Text(
                        widget.game.getByCategory(widget.gameQuestion).text,
                        textAlign: TextAlign
                            .center, // Center the text inside the widget
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              _submit(widget.game
                                  .getByCategory(widget.gameQuestion)
                                  .choices[0]);
                            },
                            child: Text(widget.game
                                .getByCategory(widget.gameQuestion)
                                .choices[0])),
                      ),
                      SizedBox(
                        width: 140,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              _submit(widget.game
                                  .getByCategory(widget.gameQuestion)
                                  .choices[1]);
                            },
                            child: Text(widget.game
                                .getByCategory(widget.gameQuestion)
                                .choices[1])),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              _submit(widget.game
                                  .getByCategory(widget.gameQuestion)
                                  .choices[2]);
                            },
                            child: Text(widget.game
                                .getByCategory(widget.gameQuestion)
                                .choices[2])),
                      ),
                      SizedBox(
                        width: 140,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              _submit(widget.game
                                  .getByCategory(widget.gameQuestion)
                                  .choices[3]);
                            },
                            child: Text(widget.game
                                .getByCategory(widget.gameQuestion)
                                .choices[3])),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(String anser) async {
    if (anser.toString() ==
        widget.game.getByCategory(widget.gameQuestion).answer.toString()) {
          print('true1');
      Navigator.of(
        context,
      ).push(MaterialPageRoute(
          builder: (context) => GameExample(
                game: widget.game,
                gameQuestion: widget.gameQuestion == 'math'
                    ? 'science'
                    : widget.gameQuestion == 'science'
                        ? 'geography'
                        : widget.gameQuestion == 'geography'
                            ? 'history'
                            : widget.gameQuestion == 'history'
                                ? 'islamic'
                                : 'end',
              )));
    }
  }
}
