import 'package:clase2_login/pages/login_page.dart';
import 'package:clase2_login/startPages/st1.dart';
import 'package:clase2_login/startPages/st2.dart';
import 'package:clase2_login/startPages/st3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: camel_case_types
class onBoardingScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const onBoardingScreen({Key? key}) : super(key: key);

  @override
  State<onBoardingScreen> createState() => onBoardingScreenState();
}

class onBoardingScreenState extends State<onBoardingScreen> {
  // ignore: prefer_final_fields
  PageController _controller = PageController();
  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onlastPage = (index == 2);
              });
            },
            children: [
              Start1(),
              start2(),
              start3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('skip')),
                SmoothPageIndicator(controller: _controller, count: 3),
                onlastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'done',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Container(
                        child: GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(
                            'next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
