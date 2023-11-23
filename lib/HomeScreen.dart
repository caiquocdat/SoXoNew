import 'dart:math';

import 'package:flutter/material.dart';

import 'DetailScreen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, String> prizes = {
    'Đặc biệt': '',
    'Giải nhất': '',
    'Giải nhì': '',
    'Giải ba': '',
    'Giải tư': '',
    // Thêm các giải khác nếu cần
  };

  // Hàm tạo số ngẫu nhiên có 5 chữ số
  String generateRandomNumber() {
    return (Random().nextInt(90000) + 10000).toString(); // Đảm bảo rằng số có 5 chữ số
  }
  // Hàm tạo nhiều số ngẫu nhiên, ngăn cách nhau bởi dấu phẩy
  String generateMultipleRandomNumbers(int count) {
    return List.generate(count, (_) => generateRandomNumber()).join(',');
  }

  // Hàm tạo số ngẫu nhiên có 4 chữ số
  String generateRandomNumber4Digits() {
    return (Random().nextInt(9000) + 1000).toString(); // Đảm bảo rằng số có 4 chữ số
  }

// Hàm tạo 3 số ngẫu nhiên có 4 chữ số, ngăn cách nhau bởi dấu phẩy
  String generateThreeRandomNumbers4Digits() {
    return List.generate(3, (_) => generateRandomNumber4Digits()).join(',');
  }

// Hàm tạo số ngẫu nhiên có 3 chữ số
  String generateRandomNumber3Digits() {
    return (Random().nextInt(900) + 100).toString(); // Đảm bảo rằng số có 3 chữ số
  }

// Hàm tạo số ngẫu nhiên có 2 chữ số
  String generateRandomNumber2Digits() {
    return (Random().nextInt(90) + 10).toString(); // Đảm bảo rằng số có 2 chữ số
  }



  Widget _buildRow(String title) {
    bool isSpecial = title == 'Đặc biệt';
    TextStyle textStyle = TextStyle(
      fontWeight: isSpecial ? FontWeight.bold : FontWeight.normal,
      color: isSpecial ? Color(0xFFFF0000) : Colors.black,
    );

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: textStyle,
            ),
            Text(
              prizes[title] ?? '', // Sử dụng giá trị từ map hoặc chuỗi rỗng nếu không tìm thấy
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo các giải với số ngẫu nhiên khi màn hình được mở
    generatePrizes();
  }
  void generatePrizes() {
    setState(() {
      prizes['Đặc biệt'] = generateRandomNumber();
      prizes['Giải nhất'] = generateRandomNumber();
      prizes['Giải nhì'] = generateRandomNumber();
      prizes['Giải ba'] = generateRandomNumber();
      prizes['Giải tư'] = generateMultipleRandomNumbers(3);
      prizes['Giải năm'] = generateRandomNumber4Digits();
      prizes['Giải sáu'] = generateThreeRandomNumbers4Digits();
      prizes['Giải bảy'] = generateRandomNumber3Digits();
      prizes['Giải tám'] = generateRandomNumber2Digits();
      // Thêm logic cho các giải khác nếu cần
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/theme_load.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50, // Adjust as needed
            left: 20,
            right: 20,
            child: Stack(
              alignment: Alignment.center, // Align the text in the center of the stack
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16), // Add some padding to the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/theme_result.png'), // Replace with your layout background image path
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(12), // Optional: if you want the container to have rounded corners
                  ),
                  height: MediaQuery.of(context).size.height * 0.7, // Adjust as needed
                ),
                SingleChildScrollView( // Allows the column content to be scrollable
                  child: Column(
                    children: prizes.keys.map((title) => _buildRow(title)).toList(),
                  ),
                ),
              ],
            ),
          ),
          // Content
          // Positioned buttons at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 60, // Adjust spacing to your preference
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    String dacBietValue = prizes['Đặc biệt'] ?? ''; // Đảm bảo giá trị không null
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(dacBiet: dacBietValue),
                      ),
                    );
                  },
                  child: Text('PHÂN TÍCH SỐ'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Button color
                    fixedSize: Size(160, 50), // Set the fixed width and height of the button
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Bắt sự kiện quay lại
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewScreen()),
                    ); // Sử dụng Navigator để quay lại màn hình trước
                  },
                  child: Text('QUAY LẠI'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Button color
                    fixedSize: Size(160, 50), // Set the fixed width and height of the button
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
