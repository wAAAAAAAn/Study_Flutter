import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

//ImplicitAnimation은 거의 자동으로 애니메이션을 만들어 준다.
class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;
  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text('Implicit Animations')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: size.width * (_visible ? 0.8 : 1),
                height: size.width * (_visible ? 0.8 : 1),
                decoration: BoxDecoration(
                    color: _visible ? Colors.amber : Colors.red,
                    borderRadius: BorderRadius.circular(_visible ? 10 : 0)),
                //어떻게 바뀔 것인지
                transform: Matrix4.identity()
                  ..translate(0.0, _visible ? 0 : 200),
                //어디를 기준으로 바꿀건지
                transformAlignment: Alignment.center,
                //어느 속도로 바뀔 것인지
                curve: Curves.bounceOut,
              ),
              //직접 Animation을 구현하는 것
              TweenAnimationBuilder(
                //animation의 시작값과 종료값
                tween: Tween(
                    begin: _visible ? 10.0 : 20,
                    end: _visible ? 20.0 : 10), //ColorTween도 된다(색이 점직적으로 변한다.)
                //animation의 변화 정도
                curve: Curves.bounceInOut,
                duration: const Duration(seconds: 10),
                builder: (context, value, child) {
                  //value에 tween값이 들어간다.
                  return Text("$value");
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.amber),
                  width: 100,
                  height: 100,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: _trigger, child: Text('Go!'))
            ],
          ),
        ));
  }
}
