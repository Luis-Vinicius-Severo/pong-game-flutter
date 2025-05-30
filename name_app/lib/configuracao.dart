import 'package:flutter/material.dart';
import 'package:name_app/regras.dart';
import 'package:name_app/tela_inicial.dart';
import 'package:google_fonts/google_fonts.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  double volume = 0.5;
  bool musica = true;
  bool sfx = true;

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
                width: 60,
                height: 90,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Configuração",
                  style: GoogleFonts.grenze(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Áudio",
                          style: GoogleFonts.grenze(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 250,
                          child: Slider(
                            value: volume,
                            onChanged: (value) {
                              setState(() {
                                volume = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white38,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Música
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Música",
                          style: GoogleFonts.grenze(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Checkbox(
                          value: musica,
                          onChanged: (value) {
                            setState(() {
                              musica = value!;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.transparent,
                          side: const BorderSide(color: Colors.white),
                        ),
                      ],
                    ),

                    // SFX
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SFX",
                          style: GoogleFonts.grenze(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Checkbox(
                          value: sfx,
                          onChanged: (value) {
                            setState(() {
                              sfx = value!;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.transparent,
                          side: const BorderSide(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Botão Regras
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Regras()),
                    );
                  },
                  child: Text(
                    "Regras",
                    style: GoogleFonts.grenze(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
