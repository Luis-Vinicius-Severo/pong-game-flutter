import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:name_app/rank.dart';
import 'package:name_app/tela_inicial.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: PongGame()),
    );
  });
}

class PongGame extends StatefulWidget {
  const PongGame({super.key});

  @override
  State<PongGame> createState() => _PongGameState();
}

class _PongGameState extends State<PongGame> {
  late double screenWidth;
  late double screenHeight;

  double paddleWidth = 10;
  double paddleHeight = 100;
  double ballSize = 12;

  double playerY = 0;
  double iaY = 0;

  double bolaX = 0;
  double bolaY = 0;
  double velocidadeBolaX = 5;
  double velocidadeBolaY = 5;
  double ballacel = 0.5;

  int playerPontuacao = 0;
  int pontoIA = 0;

  late Timer gameLoop;
  bool isPause = false;
  bool bolaMovendo = false;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startGame());
  }

  void startGame() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    playerY = screenHeight / 2 - paddleHeight / 2;
    iaY = screenHeight / 2 - paddleHeight / 2;
    bolaX = screenWidth / 2;
    bolaY = screenHeight / 2;

    gameLoop = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPause) {
        updateBall();
        updateAI();
      }
    });
  }

  void updateBall() {
    if (!bolaMovendo) return;

    setState(() {
      bolaX += velocidadeBolaX;
      bolaY += velocidadeBolaY;

      if (bolaY <= 0 || bolaY + ballSize >= screenHeight) {
        velocidadeBolaY = -velocidadeBolaY;
      }

      if (bolaX <= paddleWidth &&
          bolaY + ballSize >= playerY &&
          bolaY <= playerY + paddleHeight) {
        velocidadeBolaX = -(velocidadeBolaX.abs() + ballacel);
      }

      if (bolaX + ballSize >= screenWidth - paddleWidth &&
          bolaY + ballSize >= iaY &&
          bolaY <= iaY + paddleHeight) {
        velocidadeBolaX = -(velocidadeBolaX.abs() + ballacel);
      }

      if (bolaX < 0) {
        pontoIA++;
        if (pontoIA >= 3) {
          setState(() {
            isGameOver = true;
            isPause = false;
          });
        }
        resetaBola();
      }

      if (bolaX > screenWidth) {
        playerPontuacao++;
        resetaBola();
      }
    });
  }

  void updateAI() {
    final random = Random();
    int maxScore = max(playerPontuacao, pontoIA);
    double aiSpeed = 3 + (maxScore * 0.5);
    double errorRange = (15 - maxScore * 1.5).clamp(3, 15);
    double error = random.nextDouble() * errorRange * 2 - errorRange;

    if (velocidadeBolaX > 0) {
      double aiCenter = iaY + paddleHeight / 2 + error;
      if (aiCenter < bolaY) {
        iaY += aiSpeed;
      } else if (aiCenter > bolaY) {
        iaY -= aiSpeed;
      }
      iaY = iaY.clamp(0, screenHeight - paddleHeight);
    } else {
      iaY += ((screenHeight / 2 - paddleHeight / 2) - iaY) * 0.05;
    }
  }

  void resetaBola() {
    bolaX = screenWidth / 2;
    bolaY = screenHeight / 2;
    bolaMovendo = false;
  }

  void startBallMovement() {
    final random = Random();
    velocidadeBolaX = random.nextBool() ? 5 : -5;
    velocidadeBolaY = random.nextBool() ? 5 : -5;
    bolaMovendo = true;
  }

  @override
  void dispose() {
    gameLoop.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                playerY += details.delta.dy;
                playerY = playerY.clamp(0, screenHeight - paddleHeight);
              });
            },
            onTap: () {
              if (!bolaMovendo && !isPause) {
                startBallMovement();
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: PongPainter(
                    playerY,
                    iaY,
                    bolaX,
                    bolaY,
                    playerPontuacao,
                    pontoIA,
                    paddleWidth,
                    paddleHeight,
                    ballSize,
                  ),
                );
              },
            ),
          ),

          // Botão de pausa
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                isPause ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  isPause = !isPause;
                });
              },
            ),
          ),

          // Tela de perdeu
          if (isGameOver)
            Positioned.fill(
              child: GameOverScreen(
                onRestart: () {
                  setState(() {
                    pontoIA = 0;
                    playerPontuacao = 0;
                    isPause = false;
                    isGameOver = false;
                    resetaBola();
                  });
                },
              ),
            ),

          // Tela de pausa
          if (isPause)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "PAUSADO",
                      style: GoogleFonts.grenze(
                        color: Colors.white,
                        fontSize: 90,
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPause = false; // Continua o jogo
                            });
                          },
                          child: Image.asset(
                            'assets/imagens/play.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
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
}

class PongPainter extends CustomPainter {
  final double playerY;
  final double iaY;
  final double bolaX;
  final double bolaY;
  final int playerPontuacao;
  final int pontoIA;
  final double paddleWidth;
  final double paddleHeight;
  final double ballSize;

  PongPainter(
    this.playerY,
    this.iaY,
    this.bolaX,
    this.bolaY,
    this.playerPontuacao,
    this.pontoIA,
    this.paddleWidth,
    this.paddleHeight,
    this.ballSize,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = const Color(0xFF262536);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width / 2, size.height), paint);

    paint.color = const Color(0xFF8361FF);
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height),
      paint,
    );

    paint.color = Colors.grey.shade300;
    paint.strokeWidth = 4;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    paint.color = const Color(0xFFD9D9D9);
    canvas.drawRect(
      Rect.fromLTWH(0, playerY, paddleWidth, paddleHeight),
      paint,
    );

    paint.color = Colors.grey.shade900;
    canvas.drawRect(
      Rect.fromLTWH(size.width - paddleWidth, iaY, paddleWidth, paddleHeight),
      paint,
    );

    paint.color = Colors.grey.shade300;
    canvas.drawRect(Rect.fromLTWH(bolaX, bolaY, ballSize, ballSize), paint);

    final textStylePlayer = TextStyle(
      color: Colors.white,
      fontSize: 48,
      fontWeight: FontWeight.bold,
    );
    final tpPlayer = TextPainter(
      text: TextSpan(text: '$playerPontuacao', style: textStylePlayer),
      textDirection: TextDirection.ltr,
    );
    tpPlayer.layout();
    tpPlayer.paint(canvas, Offset(size.width / 4 - tpPlayer.width / 2, 20));

    final textStyleAI = TextStyle(
      color: Colors.black,
      fontSize: 48,
      fontWeight: FontWeight.bold,
    );
    final tpAI = TextPainter(
      text: TextSpan(text: '$pontoIA', style: textStyleAI),
      textDirection: TextDirection.ltr,
    );
    tpAI.layout();
    tpAI.paint(canvas, Offset(size.width * 3 / 4 - tpAI.width / 2, 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GameOverScreen extends StatelessWidget {
  final VoidCallback onRestart;

  const GameOverScreen({super.key, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "FIM DE JOGO",
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
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
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
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Rank()),
                    );
                  },
                  child: Image.asset(
                    'assets/imagens/rank.png',
                    width: 70,
                    height: 70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
