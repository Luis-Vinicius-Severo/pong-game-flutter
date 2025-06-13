import 'package:flutter/material.dart';
import 'package:name_app/configuracao.dart';
import 'package:name_app/regras.dart';
import 'package:name_app/tela_inicial.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaGame extends StatefulWidget {
  const TelaGame({super.key});

  @override
  State<TelaGame> createState() => _TelaGameState();
}

class _TelaGameState extends State<TelaGame> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = true;

  void _verificarENavegar() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _isValid = false;
      });
    } else {
      setState(() {
        _isValid = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Regras()),
      ).then((_) {
        _controller.clear();
        setState(() {
          _isValid = true;
        });
      });
    }
  }

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
                            controller: _controller,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.grenze(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: "Nome do usuário",
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      _isValid
                                          ? Colors.transparent
                                          : Colors.red,
                                  width: 4,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isValid ? Colors.blue : Colors.red,
                                  width: 4,
                                ),
                              ),
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
                        ).then((_) {
                          _controller.clear();
                          setState(() {
                            _isValid = true;
                          });
                        });
                      },
                      child: Image.asset(
                        'assets/imagens/retornar.png',
                        width: 150,
                        height: 80,
                      ),
                    ),
                    GestureDetector(
                      onTap: _verificarENavegar,
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
