import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_app/tela_pong.dart';

class Regras extends StatelessWidget {
  const Regras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PongGame()),
          );
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
                  style: GoogleFonts.grenze(
                    color: Colors.white,
                    fontSize: 80,
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
                      "Progressão de Nível :\nCada vez que você completa uma meta no jogo, o nível aumenta.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.grenze(
                        color: Colors.white,
                        fontSize: 25,
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
                            "Condição de Vitória :\n Não existe, apenas sobreviva!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.grenze(
                              color: Colors.white,
                              fontSize: 25,
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
                            "Condição de Derrota :\nSe tomar 3 pontos, você perde e o jogo reinicia desde o começo..",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.grenze(
                              color: Colors.white,
                              fontSize: 25,
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
