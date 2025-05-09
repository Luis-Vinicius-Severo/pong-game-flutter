import 'package:flutter/material.dart';

class Regras extends StatelessWidget {
  const Regras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/imagens/fundo.png', fit: BoxFit.cover),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Text(
                  "Regras",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontFamily: "Grenze",
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Progressão de Nível\nCada vez que você completa uma meta no jogo, o nível aumenta.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Grenze",
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Condição de Vitória\nFaça 20 pontos e você vence a máquina!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Grenze",
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Text(
                            "Velocidade da Bola\nA bola acelera conforme avança de fase.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Grenze",
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
