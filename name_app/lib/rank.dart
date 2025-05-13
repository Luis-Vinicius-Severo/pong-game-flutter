import 'package:flutter/material.dart';
import 'package:name_app/tela_inicial.dart';

const Color customBlue = Color(0xFF3A3E71);

class Rank extends StatelessWidget {
  const Rank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/imagens/fundo.png', fit: BoxFit.cover),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaInicial()),
                );
              },
              child: Image.asset(
                'assets/imagens/retornar.png',
                width: 50,
                height: 90,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                "Rank",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontFamily: "Grenze",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imagens/medalhaOuro.png',
                      width: 70,
                      height: 70,
                    ),

                    // Margem externa do input
                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: SizedBox(
                        width: 300,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Player 1",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                suffixIcon: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "20",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imagens/medalhaPrata.png',
                      width: 70,
                      height: 70,
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: SizedBox(
                        width: 300,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Player 2",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                suffixIcon: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "20",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imagens/medalhaBronze.png',
                      width: 70,
                      height: 70,
                    ),

                    // Margem externa do input
                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: SizedBox(
                        width: 300,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Player 3",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                suffixIcon: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "20",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
