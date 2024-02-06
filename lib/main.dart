import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _displayController = TextEditingController();
  String _displayText = '';

  Map<int, int> dollarValues = {
    500: 0,
    100: 0,
    50: 0,
    20: 0,
    10: 0,
    5: 0,
    2: 0,
    1: 0,
  };

  @override
  void dispose() {
    _displayController.dispose();
    super.dispose();
  }

  Widget _portraitMode() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                children: [
                  const Text(
                    'Taka: ',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _displayText,
                    style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Container(
              height: 100,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var key in dollarValues.keys)
                      Text(
                        '\$$key : ${dollarValues[key]}',
                        style: const TextStyle(fontSize: 20),
                      ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCalculatorButton('7'),
                        _buildCalculatorButton('8'),
                        _buildCalculatorButton('9'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCalculatorButton('4'),
                        _buildCalculatorButton('5'),
                        _buildCalculatorButton('6'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCalculatorButton('1'),
                        _buildCalculatorButton('2'),
                        _buildCalculatorButton('3'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCalculatorButton('0'),
                        _buildCalculatorButton('CLEAR'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _landscapeMode() {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 150.0),
                child: Row(
                  children: [
                    const Text(
                      'Taka: ',
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _displayText,
                      style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (var key in dollarValues.keys.toList().getRange(0, 4))
                                Column(
                                  children: [
                                    Text(
                                      '\$$key : ${dollarValues[key]}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 50.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (var key in dollarValues.keys.toList().getRange(4, 8))
                                Column(
                                  children: [
                                    Text(
                                      '\$$key : ${dollarValues[key]}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCalculatorButton('7'),
                              _buildCalculatorButton('8'),
                              _buildCalculatorButton('9'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCalculatorButton('4'),
                              _buildCalculatorButton('5'),
                              _buildCalculatorButton('6'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCalculatorButton('1'),
                              _buildCalculatorButton('2'),
                              _buildCalculatorButton('3'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCalculatorButton('0'),
                              _buildCalculatorButton('CLEAR'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: const Text(
          'Vangti-Chai',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return _portraitMode();
          }else{
            return _landscapeMode();
          }
        },
      ),
    );
  }

  Widget _buildCalculatorButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'CLEAR') {
          if (_displayText.isNotEmpty) {
            _displayText = _displayText.substring(0, _displayText.length - 1);
          }
          dollarValues.updateAll((key, value) => 0);
        } else {
          _displayText += text;
          dollarValues.updateAll((key, value) => 0);
        }

        int enteredAmount = int.tryParse(_displayText) ?? 0;

        if (dollarValues.keys.isNotEmpty) {
          for (var key in dollarValues.keys) {
            while (enteredAmount >= key) {
              dollarValues[key] = (dollarValues[key] as int) + 1;
              enteredAmount = enteredAmount - key;
            }
          }
        }

        setState(() {
          _displayController.text = _displayText;
        });
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}

