import 'package:flutter/material.dart';
import 'package:project2/Screen_page/login_screen.dart';
import 'package:project2/Screen_page/page_galery_foto.dart';
import 'package:project2/Screen_page/page_list_berita.dart';
import 'package:project2/Screen_page/page_list_pegawai.dart';
import 'package:project2/Screen_page/page_user.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            PageListBerita(), PageMovieGallery(), PageListPegawai(),ProfilScreen()
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.white,
          backgroundColor: Colors.blue,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.new_releases_rounded,
              outlinedIcon: Icons.new_releases_outlined,
            ),
            BarItem(
              filledIcon: Icons.add_a_photo_rounded,
              outlinedIcon: Icons.add_a_photo_outlined,
            ),
            BarItem(
              filledIcon: Icons.library_add_rounded,
              outlinedIcon: Icons.library_add_outlined,
            ),
            BarItem(
                filledIcon: Icons.person_2_rounded,
                outlinedIcon: Icons.person_2_outlined),
          ],
        ),
      ),
    );
  }
}
