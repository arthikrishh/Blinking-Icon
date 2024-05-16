import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Blinking Animation Icon',
                style: GoogleFonts.hammersmithOne(
                    fontSize: 18,
                    color: Color(0xFF12397B),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 194, 235, 194),
                      Color(0xFFC0F0E5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 220, 218, 218),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Transform.scale(
                    scale: 1.0, // Remove the scaling
                    child: AnimationIconWidget(
                      children: <Widget>[
                        Transform.scale(
                          scale: 5.0, // Scale the icons individually
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFFFB928A),
                          ),
                        ),
                        Transform.scale(
                          scale: 5.0,
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFFCF362B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimationIconWidget extends StatefulWidget {
  final List<Widget>? children;
  final int interval;

  AnimationIconWidget({required this.children, this.interval = 500, Key? key})
      : super(key: key);

  @override
  _AnimationIconWidgetState createState() => _AnimationIconWidgetState();
}

class _AnimationIconWidgetState extends State<AnimationIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.interval),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentWidget = (_currentWidget + 1) % widget.children!.length;
        });
        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.children![_currentWidget];
  }
}
