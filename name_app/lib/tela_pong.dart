import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 24),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PongGame()),
            );
          },
          child: const Text('Jogar Pong'),
        ),
      ),
    );
  }
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
  double aiY = 0;

  double ballX = 0;
  double ballY = 0;
  double ballSpeedX = 5;
  double ballSpeedY = 5;
  double ballacel = 0.5;

  int playerScore = 0;
  int aiScore = 0;

  late Timer gameLoop;
  bool isPaused = false;
  bool isBallMoving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startGame());
  }

  void startGame() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    playerY = screenHeight / 2 - paddleHeight / 2;
    aiY = screenHeight / 2 - paddleHeight / 2;
    ballX = screenWidth / 2;
    ballY = screenHeight / 2;

    gameLoop = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!isPaused) {
        updateBall();
        updateAI();
      }
    });
  }

  void updateBall() {
    if (!isBallMoving) return;

    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;

      if (ballY <= 0 || ballY + ballSize >= screenHeight) {
        ballSpeedY = -ballSpeedY;
      }

      if (ballX <= paddleWidth &&
          ballY + ballSize >= playerY &&
          ballY <= playerY + paddleHeight) {
        ballSpeedX += ballacel;
        ballSpeedX = -ballSpeedX;
      }

      if (ballX + ballSize >= screenWidth - paddleWidth &&
          ballY + ballSize >= aiY &&
          ballY <= aiY + paddleHeight) {
        ballSpeedX += ballacel;
        ballSpeedX = -ballSpeedX;
      }

      if (ballX < 0) {
        aiScore++;
        resetBall();
      }

      if (ballX > screenWidth) {
        playerScore++;
        resetBall();
      }
    });
  }

  void updateAI() {
    final random = Random();
    int maxScore = max(playerScore, aiScore);
    double aiSpeed = 3 + (maxScore * 0.5);
    double errorRange = (15 - maxScore * 1.5).clamp(3, 15);
    double error = random.nextDouble() * errorRange * 2 - errorRange;

    if (ballSpeedX > 0) {
      double aiCenter = aiY + paddleHeight / 2 + error;
      if (aiCenter < ballY) {
        aiY += aiSpeed;
      } else if (aiCenter > ballY) {
        aiY -= aiSpeed;
      }
      aiY = aiY.clamp(0, screenHeight - paddleHeight);
    } else {
      aiY += ((screenHeight / 2 - paddleHeight / 2) - aiY) * 0.05;
    }
  }

  void resetBall() {
    ballX = screenWidth / 2;
    ballY = screenHeight / 2;
    isBallMoving = false;
  }

  void startBallMovement() {
    final random = Random();
    ballSpeedX = random.nextBool() ? 5 : -5;
    ballSpeedY = random.nextBool() ? 5 : -5;
    isBallMoving = true;
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
              if (!isBallMoving && !isPaused) {
                startBallMovement();
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: PongPainter(
                    playerY,
                    aiY,
                    ballX,
                    ballY,
                    playerScore,
                    aiScore,
                    paddleWidth,
                    paddleHeight,
                    ballSize,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                isPaused ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                setState(() {
                  isPaused = !isPaused;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PongPainter extends CustomPainter {
  final double playerY;
  final double aiY;
  final double ballX;
  final double ballY;
  final int playerScore;
  final int aiScore;
  final double paddleWidth;
  final double paddleHeight;
  final double ballSize;

  PongPainter(
    this.playerY,
    this.aiY,
    this.ballX,
    this.ballY,
    this.playerScore,
    this.aiScore,
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
      Rect.fromLTWH(size.width - paddleWidth, aiY, paddleWidth, paddleHeight),
      paint,
    );

    paint.color = Colors.grey.shade300;
    canvas.drawRect(Rect.fromLTWH(ballX, ballY, ballSize, ballSize), paint);

    final textStylePlayer = TextStyle(
      color: Colors.white,
      fontSize: 48,
      fontWeight: FontWeight.bold,
    );
    final tpPlayer = TextPainter(
      text: TextSpan(text: '$playerScore', style: textStylePlayer),
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
      text: TextSpan(text: '$aiScore', style: textStyleAI),
      textDirection: TextDirection.ltr,
    );
    tpAI.layout();
    tpAI.paint(canvas, Offset(size.width * 3 / 4 - tpAI.width / 2, 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
