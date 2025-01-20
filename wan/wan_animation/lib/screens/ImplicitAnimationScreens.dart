import 'package:flutter/material.dart';

class Implicitanimationscreens extends StatefulWidget {
  const Implicitanimationscreens({super.key});

  @override
  State<Implicitanimationscreens> createState() =>
      _ImplicitanimationscreensState();
}

class _ImplicitanimationscreensState extends State<Implicitanimationscreens> {
  bool flag = true;
  bool showImage = false;

  void tigger() {
    setState(() {
      flag = !flag;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (flag) {
        setState(() {
          showImage = true;
        });
      } else {
        setState(() {
          showImage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                curve: Curves.elasticInOut,
                duration: const Duration(seconds: 2),
                width: size.width * 0.8,
                height: size.width * 0.8,
                transform: Matrix4.rotationZ(flag ? 1 : 0),
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                  color: flag ? Colors.amber : Colors.red,
                  borderRadius: BorderRadius.circular(flag ? 100 : 0),
                ),
                child: showImage
                    ? TweenAnimationBuilder(
                        tween: ColorTween(begin: Colors.red, end: Colors.white),
                        duration: const Duration(seconds: 1),
                        builder: (context, Color? value, child) {
                          return Image.network(
                            "https://static1.e926.net/data/sample/0e/a8/0ea842fd74cb28e6986d791bb4c3a2bd.jpg",
                            color: value,
                            colorBlendMode: BlendMode.colorBurn,
                          );
                        },
                      )
                    : null,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: tigger,
                child: const Text("GO"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
