import 'package:flutter/material.dart';
import 'package:name_app/tela_inicial.dart';

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
                const Text(
                  "Configuração",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: "Grenze",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Audio",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(),
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

                Padding(
                  padding: const EdgeInsets.only(
                    left: 290,
                  ), // ajusta aqui o quanto quiser deslocar
                  child: Row(
                    children: [
                      const Text(
                        "Musica",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ), // espaço entre o texto e o checkbox
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 290),
                  child: Row(
                    children: [
                      const Text(
                        "SFX",
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
                ),

                const SizedBox(height: 40),

                // BOTÃO "REGRAS"
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaInicial(),
                      ),
                    );
                  },
                  child: const Text(
                    "Regras",
                    style: TextStyle(color: Colors.white, fontSize: 25),
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
