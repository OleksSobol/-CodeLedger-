import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  static const int rows = 20;
  static const int columns = 20;
  static const double speed = 200.0; // milliseconds

  List<Point<int>> snake = [const Point(10, 10)];
  Point<int> food = const Point(5, 5);
  Direction direction = Direction.up;
  Direction? nextDirection;
  Timer? timer;
  bool isPlaying = false;
  bool isGameOver = false;
  int score = 0;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startGame() {
    setState(() {
      snake = [const Point(10, 10)];
      direction = Direction.up;
      nextDirection = null;
      score = 0;
      isPlaying = true;
      isGameOver = false;
      spawnFood();
    });
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: speed.toInt()), (Timer t) {
      updateGame();
    });
  }

  void spawnFood() {
    final random = Random();
    Point<int> newFood;
    do {
      newFood = Point(random.nextInt(columns), random.nextInt(rows));
    } while (snake.contains(newFood));
    food = newFood;
  }

  void updateGame() {
    setState(() {
      if (nextDirection != null) {
        direction = nextDirection!;
        nextDirection = null;
      }

      Point<int> newHead;
      final head = snake.first;
      switch (direction) {
        case Direction.up:
          newHead = Point(head.x, head.y - 1);
          break;
        case Direction.down:
          newHead = Point(head.x, head.y + 1);
          break;
        case Direction.left:
          newHead = Point(head.x - 1, head.y);
          break;
        case Direction.right:
          newHead = Point(head.x + 1, head.y);
          break;
      }

      // Check boundaries
      if (newHead.x < 0 ||
          newHead.x >= columns ||
          newHead.y < 0 ||
          newHead.y >= rows) {
        gameOver();
        return;
      }

      // Check self collision
      if (snake.contains(newHead)) {
        gameOver();
        return;
      }

      snake.insert(0, newHead);

      // Check food
      if (newHead == food) {
        score++;
        spawnFood();
      } else {
        snake.removeLast();
      }
    });
  }

  void gameOver() {
    timer?.cancel();
    setState(() {
      isPlaying = false;
      isGameOver = true;
    });
  }

  void setDirection(Direction newDirection) {
    if (!isPlaying) return;

    // Prevent 180 degree turns
    if (direction == Direction.up && newDirection == Direction.down) return;
    if (direction == Direction.down && newDirection == Direction.up) return;
    if (direction == Direction.left && newDirection == Direction.right) return;
    if (direction == Direction.right && newDirection == Direction.left) return;

    nextDirection = newDirection;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Invaders... Wait, Snake?'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Score: $score',
                style: theme.textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 0) {
                        setDirection(Direction.down);
                      } else if (details.delta.dy < 0) {
                        setDirection(Direction.up);
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 0) {
                        setDirection(Direction.right);
                      } else if (details.delta.dx < 0) {
                        setDirection(Direction.left);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHigh,
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          // Draw snake and food
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final cellWidth = constraints.maxWidth / columns;
                              final cellHeight = constraints.maxHeight / rows;

                              return Stack(
                                children: [
                                  // Food
                                  Positioned(
                                    left: food.x * cellWidth,
                                    top: food.y * cellHeight,
                                    width: cellWidth,
                                    height: cellHeight,
                                    child: const Icon(
                                      Icons.attach_money,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                                  // Snake
                                  ...snake.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final p = entry.value;
                                    final isHead = index == 0;
                                    return Positioned(
                                      left: p.x * cellWidth,
                                      top: p.y * cellHeight,
                                      width: cellWidth,
                                      height: cellHeight,
                                      child: Container(
                                        margin: const EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: isHead
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.primary
                                                    .withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(
                                            isHead ? 4 : 2,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              );
                            },
                          ),
                          // Overlay
                          if (!isPlaying)
                            Container(
                              color: Colors.black.withValues(alpha: 0.5),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isGameOver) ...[
                                      Text(
                                        'GAME OVER',
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                    ElevatedButton.icon(
                                      onPressed: startGame,
                                      icon: const Icon(Icons.play_arrow),
                                      label: Text(
                                        isGameOver
                                            ? 'Play Again'
                                            : 'Start Game',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Mobile D-Pad controls for easier play
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                children: [
                  IconButton.filled(
                    onPressed: () => setDirection(Direction.up),
                    icon: const Icon(Icons.keyboard_arrow_up),
                    iconSize: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filled(
                        onPressed: () => setDirection(Direction.left),
                        icon: const Icon(Icons.keyboard_arrow_left),
                        iconSize: 48,
                      ),
                      const SizedBox(width: 48), // Space for down button below
                      IconButton.filled(
                        onPressed: () => setDirection(Direction.right),
                        icon: const Icon(Icons.keyboard_arrow_right),
                        iconSize: 48,
                      ),
                    ],
                  ),
                  IconButton.filled(
                    onPressed: () => setDirection(Direction.down),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 48,
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
