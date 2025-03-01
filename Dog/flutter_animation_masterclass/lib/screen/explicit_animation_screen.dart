import 'dart:ffi';

import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  //=> SingleTickerProviderStateMixin은 에니메이션이 있는 화면에서만 존재하는 Ticker를 제공한다.
  late final AnimationController _animationController = AnimationController(
    //SingleTickerProviderStateMixin에는 createTicker가 있는데 이를 통해 animationController가 ticker를 생성하여 제공 받는다.
    vsync: this,
    //animation의 길이
    duration: Duration(seconds: 1),
    //default value?
    lowerBound: 0, //animation 하한 값
    upperBound: 1, //animation 최대값
  )..addListener(() {
      //이건 setState가 없지만 _value는 ValueNotifier기 때문에 값이 변화하는 것을 캐치한다.
      _value.value = _animationController.value;
    });
  //매번 이벤트(값) 이 변경 될때마다 build를 해주면 애니메이션이 변하기는 하지만 최적화 관점에서는 최악이다.
  // ..addListener(() {
  //     //이벤트가 발생할 때 마다 해당 함수안에 정의된 내용이 실행된다.
  //     setState(() => {});
  //   });
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //_animationController를 통해 ColorTween의 값이 변화한다.
  //widget 중 Animated~ 는 implicit ~Transit sms Explicit
  late final Animation _colorAnimation =
      //시작값과 끝 값을 설정한 후 animation controller에 연결한다.
      ColorTween(begin: Colors.yellow, end: Colors.red).animate(_curved);

  late final Animation<Decoration> _boxAnimation = DecorationTween(
          begin: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          end: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(120))))
      .animate(_curved);
  late final Animation<double> _rotation =
      Tween(begin: 0.0, end: .5).animate(_curved);
  late final Animation<Offset> offsetAnimation =
      Tween(begin: Offset.zero, end: Offset(0, 0.5)).animate(_curved);
  //animation의 value 값 변경 방식을 바꾼다.
  late final CurvedAnimation _curved =
      CurvedAnimation(parent: _animationController, curve: Curves.bounceIn);

  @override
  void initState() {
    super.initState();
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  //valueNotifier는 값이 바뀌어도 builder를 호출 안한다.
  final ValueNotifier<double> _value = ValueNotifier(0.0);
  void onChange(double value) {
    _value.value = value;
    _animationController.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Explicit Animation"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //AnimateBuilder는 builder 안에 내용을 _animationController에 따라 계속 build해준다.
              //AnimatedBuilder 도 좋지만 한번에 명시적으로 어떤 animation을 해주는지 해주는지 표시하는게 좋기 때문에 ~Transition을 써주는겍 좋다.

              // AnimatedBuilder(
              //   animation: _boxAnimation,
              //   builder: (context, child) {
              //     return Container(
              //       width: 400,
              //       height: 400,
              //       decoration: _boxAnimation.value,
              //     );
              //   },
              // ),
              //만약 animationBuilder로만 했으면 기능을 구현하는데 어려울테지만 각 기능을 구현하는 explicit를 사용해서 쉽게 구현이 가능하다.
              SlideTransition(
                position: offsetAnimation,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                      decoration: _boxAnimation,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                      )),
                ),
              ),
              ElevatedButton(onPressed: _play, child: Text('Play')),
              ElevatedButton(onPressed: _pause, child: Text('Pause')),
              ElevatedButton(onPressed: _rewind, child: Text('Rewind')),
              // Slider(value: _value.value, onChanged: onChange)
              //한 부분에 대해서만 ValueNotifier 의 값이 변할 때 그 값이 ValueListenablebuilder에서만 바뀌도록 한다.? setState는 변화에 따라 전체를 build하지만 ValueListenableBuilder는 _value 값만 build 해준다.
              ValueListenableBuilder(
                  valueListenable: _value,
                  builder: (context, val, child) {
                    return Slider(value: val, onChanged: onChange);
                  })
            ],
          ),
        ));
  }
}
