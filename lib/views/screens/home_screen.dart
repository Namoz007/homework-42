import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late final AnimationController animationController;
  late final Animation<double> containerAnimation;
  bool isTrue = true;
  late List<Widget> items;
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;


  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * (MediaQuery.of(context).size.width - 50), // item width + margin
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }


  void initState(){
    super.initState();

    animationController = AnimationController(vsync: this,duration: Duration(seconds: 2));

    containerAnimation = Tween<double>(begin: 0,end: 68).animate(CurvedAnimation(parent: animationController, curve: Curves.decelerate));

    _scrollController = ScrollController();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentIndex < items.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollToIndex(_currentIndex);
    });

  }


  @override
  Widget build(BuildContext context) {
    items = [
      Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 250,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 250,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 250,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
        ),
      ),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Center(
            child: InkWell(
              onTap: (){
                setState(() {
                  if(isTrue){
                    isTrue = !isTrue;
                    animationController.forward();
                  }else{
                    isTrue = !isTrue;
                    animationController.reverse();
                  }
                  setState(() {
                  });
                });
              },
              child: AnimatedBuilder(
                  animation: containerAnimation,
                  builder: (context,child) {
                    return Container(
                      // width: containerAnimation.value,
                      width: 150,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(80),
                        color: isTrue ? Colors.amber : Colors.blue,
                      ),
                      alignment: isTrue ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: containerAnimation.value,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red
                            ),
                            child: Icon(Icons.airplanemode_on_sharp,color: isTrue ? Colors.white: Colors.black,size: 40,),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),

          SizedBox(height: 100,),

          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < items.length; i++) items[i],
                ],
              ),
            ),
          ),

          SizedBox(height: 30,),


        ],
      ),
    );
  }
}
