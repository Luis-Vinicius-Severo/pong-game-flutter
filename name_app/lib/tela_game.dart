import 'package:flutter/material.dart';
import 'package:name_app/configuracao.dart';
import 'package:name_app/regras.dart';
import 'package:name_app/tela_inicial.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaGame extends StatelessWidget {
  const TelaGame({super.key});

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
                    Text(
                      "Pong",
                      style: GoogleFonts.grenze(
                        color: Colors.white,
                        fontSize: 100,
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
                  ],
                ),

                Center(
                  child: SizedBox(
                    width: 300,
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            style: GoogleFonts.grenze(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: "Nome do usuário",
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaInicial(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/imagens/retornar.png',
                        width: 150,
                        height: 80,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Regras(),
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
