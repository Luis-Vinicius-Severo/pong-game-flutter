import 'package:flutter/material.dart';
import 'package:name_app/configuracao.dart';
import 'package:name_app/rank.dart';
import 'package:name_app/tela_game.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/imagens/fundo.png', fit: BoxFit.cover),
          Positioned(
            top: 38,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Configuracao()),
                );
              },
              child: Image.asset(
                'assets/imagens/configuracao.png',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/imagens/Line.png'),
                    SizedBox(width: 30),
                    Text(
                      "Pong",
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
                    SizedBox(width: 30),
                    Image.asset('assets/imagens/Line.png'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Rank()),
                        );
                      },
                      child: Image.asset(
                        'assets/imagens/rank.png',
                        width: 150,
                        height: 80,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaGame(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/imagens/play.png',
                        width: 150,
                        height: 130,
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
