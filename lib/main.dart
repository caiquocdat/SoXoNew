import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'LoadScreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Màu trong suốt cho thanh trạng thái
      statusBarIconBrightness: Brightness.dark, // Màu sáng cho các biểu tượng trên thanh trạng thái
    ));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {

    }
  }
  Future<void> saveValue(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', value);
    print('Value saved: $value');
  }
  @override
  Widget build(BuildContext context) {
    // Xây dựng UI của bạn ở đây...
    final double imageWidth = MediaQuery.of(context).size.width * 0.6;
    final double imageHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img_theme_home.png"),
            // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Your other widgets
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  await saveValue('MB');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>LoadScreen()));
                },
                child: Image.asset(
                  'assets/xsmb.png',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit
                      .contain, // Điều này sẽ giữ nguyên tỷ lệ của hình ảnh
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await saveValue('MT');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadScreen()));
                },
                child: Image.asset(
                  'assets/sxmt.png',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await saveValue('MN');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadScreen()));
                },
                child: Image.asset(
                  'assets/sxmn.png',
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
