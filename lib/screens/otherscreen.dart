import 'package:flutter/material.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("ลูกค้า Login ก่อนนะครับ!!!"));
  }
}
