import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatelessWidget {
  final String dacBiet;

  // Constructor này cho phép truyền dữ liệu vào khi khởi tạo DetailScreen
  DetailScreen({required this.dacBiet, Key? key}) : super(key: key);
  Future<String> getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('key') ?? '';
    return value;
  }
  Widget _buildTextRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.amberAccent), // Icon với màu sắc tùy chỉnh
          SizedBox(width: 8), // Khoảng cách giữa icon và text
          Flexible(
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 16),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
  String generateRandomNumber2Digits() {
    return (Random().nextInt(90) + 10).toString(); // Đảm bảo rằng số có 2 chữ số
  }
  String generateThreeRandomNumbers4Digits() {
    return List.generate(3, (_) => generateRandomNumber2Digits()).join(',');
  }
  String generateTwoRandomNumbers4Digits() {
    return List.generate(2, (_) => generateRandomNumber2Digits()).join(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phân tích số', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/theme_load.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FutureBuilder<String>(
            future: getValue(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                // Nội dung được sắp xếp theo cột
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Phân tích dự đoán KQXSO ${snapshot.data}',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    _buildTextRow(icon: Icons.star, text: ' Giải đặc biệt: '+dacBiet),
                    _buildTextRow(icon: Icons.star, text: ' Xuất hiện lô kẹp: '+generateThreeRandomNumbers4Digits()),
                    _buildTextRow(icon: Icons.star, text: ' Lô kép: '+generateThreeRandomNumbers4Digits()),
                    _buildTextRow(icon: Icons.star, text: '  Đầu lô câm: 2, khả năng sẽ có lô '+generateThreeRandomNumbers4Digits()),
                    _buildTextRow(icon: Icons.star, text: '  Đuôi (đít) lô câm: không có.'),
                    _buildTextRow(icon: Icons.star, text: '   Đầu lô về nhiều nhất: 9.'),
                    _buildTextRow(icon: Icons.star, text: '    Đuôi lô về nhiều nhất: 7'),
                    _buildTextRow(icon: Icons.star, text: '     Lô nhiều nháy: '+generateThreeRandomNumbers4Digits()+'( 2 lần)'),
                    Text(
                      'Chốt cặp số đẹp ${snapshot.data} hôm nay: '+generateTwoRandomNumbers4Digits(),
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Bạch thủ đề ${snapshot.data}: '+generateRandomNumber2Digits(),
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Song thủ lô bao trúng: '+generateThreeRandomNumbers4Digits(),
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Lô kép ngon: '+generateThreeRandomNumbers4Digits(),
                      style: TextStyle(color: Colors.red, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),

                    // Tiếp tục thêm các Text widget khác nếu cần
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
