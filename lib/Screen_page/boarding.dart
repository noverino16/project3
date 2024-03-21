import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:project2/Screen_page/login_screen.dart';
import 'package:project2/Screen_page/register_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: FinishButtonStyle(backgroundColor: Colors.lightBlue),
        onFinish: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        skipTextButton: Text('Skip'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text('Login'),
        ),
        background: [
          // Image.asset('images/manread.png'),
          // Image.asset('images/output.png'),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                SizedBox(height: 20),
                Text('Selamat Datang Di Kamus Besar Bahasa',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 25)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                SizedBox(height: 20),
                Text('Gunakan Dimanapun dan Kapanpun!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 25)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
