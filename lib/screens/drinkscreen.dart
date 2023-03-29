import 'package:flutter/material.dart';
import 'package:projectfinal/screens/orderdrinkcreen.dart';

class DrinkScreen extends StatefulWidget {
  const DrinkScreen({super.key});

  @override
  State<DrinkScreen> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  var drinkNames = [
    "โคคา โคล่า",
    "เป๊ปซี่",
    "น้ำเปล่า",
    "กาแฟร้อน",
    "กาแฟเย็น",
    "สตอเบอรี่ปั่น",
    "ชาเย็น",
    "ชาเขียว"
  ];

  var drinkImages = [
    "images/drinks/cocacola.png",
    "images/drinks/pepsi.png",
    "images/drinks/purewater.png",
    "images/drinks/hotcoffee.png",
    "images/drinks/icecoffee.png",
    "images/drinks/strawberry.png",
    "images/drinks/icetea.png",
    "images/drinks/greentea.png"
  ];

  var DpriceList = ['10', '12', '8', '30', '35', '40', '45', '50'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: drinkNames.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2)),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () {
              //กดเลือกน้ำ
              //print(drinkNames[index]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDrinkScreen(
                          imageName: drinkImages[index],
                          drinkNames: drinkNames[index],
                          DpriceList: DpriceList[index])));
            },
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  drinkImages[index],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    drinkNames[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('ราคา ${DpriceList[index]} บาท'))
              ],
            ),
          ),
        );
      },
    );
  }
}
