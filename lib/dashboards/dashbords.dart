import 'package:flutter/material.dart';
import 'package:projectfinal/screens/foodscreen.dart';
import 'package:projectfinal/screens/drinkscreen.dart';
import 'package:projectfinal/screens/listscreen.dart';
import 'package:projectfinal/screens/otherscreen.dart';

// 1. import เพื่อใช้ template และ library ในการสร้าง Lock screen version 2.0.1
import 'dart:async';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

//2. กำหนดรหัสผ่านเป็น 123456
const storedPasscode = '123456';

// //3. ประกาศตัวแปรเพื่อตรวจสอบการ authen ใน class _xxx
// final StreamController<bool> _verificationNotifier =
//     StreamController<bool>.broadcast();
// //ตรวจสอบว่ามีการ authen หรือยัง
// //4. ประกาศตัวแปรเพื่อตรวจการ authen ผ่านหรือยัง ใน class _xxx
// bool isAuthenticated = false;
// //ยังไม่ยืนยัน

class Dashbord extends StatelessWidget {
  const Dashbord({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: dashbordScreen(),
    );
  }
}

class dashbordScreen extends StatefulWidget {
  const dashbordScreen({super.key});

  @override
  State<dashbordScreen> createState() => _dashbordScreenState();
}

class _dashbordScreenState extends State<dashbordScreen> {
  int _menu = 0;
  // String _title = "หน้าหลัก";

  //3. ประกาศตัวแปรเพื่อตรวจสอบการ authen ใน class _xxx
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
//ตรวจสอบว่ามีการ authen หรือยัง
//4. ประกาศตัวแปรเพื่อตรวจการ authen ผ่านหรือยัง ใน class _xxx
  bool isAuthenticated = false;
//ยังไม่ยืนยัน

  var screenTitle = [
    'รายการอาหาร',
    'เครื่องดื่ม',
    'รายการอาหารที่สั่ง',
    'แจ้งเตือน'
  ];

  final List<Widget> _screen = [
    FoodScreen(),
    DrinkScreen(),
    ListScreen(),
    OtherScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(screenTitle[_menu])),
      ),
      body: _screen[isAuthenticated ? _menu : 3],
      backgroundColor: Color.fromARGB(255, 214, 201, 162),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 14),
        fixedColor: Colors.yellow,
        unselectedItemColor: Colors.yellow,
        onTap: (value) {
          setState(() {
            if (isAuthenticated == false) {
              showLockScreen();
            }
            if (isAuthenticated == true) {
              _menu = value;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_rounded,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'อาหาร',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_drink,
                  color: Color.fromARGB(255, 255, 255, 255)),
              label: 'เครื่องดื่ม'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books,
                  color: Color.fromARGB(255, 255, 255, 255)),
              label: 'รายการอาหารที่สั่ง'),
          // BottomNavigationBarItem(
          //     icon:
          //         Icon(Icons.alarm, color: Color.fromARGB(255, 255, 255, 255)),
          //     label: 'แจ้งเตือน'),
        ],
      ),
    );
  }

  // 5. สร้างเมทอดเพื่อเรียก template Lock screen
  void showLockScreen() {
    _showLockScreen(
      context,
      opaque: false,
      cancelButton: Text(
        'ยกเลิก',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'ยกเลิก',
      ),
    );
  }

// คัดลอกตั้งส่วนนี้ไปวาง ใน class _xxx
  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(
              'กรุณาป้อนรหัสผ่าน',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'ลบ',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'ลบ',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
            bottomWidget: _buildPasscodeRestoreButton(),
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            child: Text(
              "ลืมรหัสผ่าน",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            onPressed: _resetAppPassword,
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
          ),
        ),
      );

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "รีเซ็ตรหัสผ่าน",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "การรีเซ็ตรหัสผ่านเป็นการดำเนินการที่ไม่ปลอดภัย!\n\nโปรดพิจารณาลบข้อมูลผู้ใช้ทั้งหมดหากดำเนินการนี้",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "ยกเลิก",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              child: Text(
                "ตกลง",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }

//before end class _xxx
}
