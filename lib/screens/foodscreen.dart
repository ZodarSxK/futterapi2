import 'package:flutter/material.dart';
import 'package:projectfinal/screens/orderfoodscreen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  var foodNames = [
    "แฮมเบอเกอร์",
    "ปีกไก่ทอด",
    "ยำวุ้นเส้น",
    "ต้มยำ",
    "ข้าวผัด",
    "กระเพรา",
    "สลัด",
    "สปาเก๊ตตี้"
  ];
  var foodImages = [
    "images/foods/hamburger.png",
    "images/foods/chickenwings.png",
    "images/foods/yumwoonsen.png",
    "images/foods/tomyum.png",
    "images/foods/firerice.png",
    "images/foods/krapauw.png",
    "images/foods/salad.png",
    "images/foods/spaghetti.png"
  ];

  var FpriceList = ['10', '12', '8', '30', '35', '40', '45', '50'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: foodNames.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2)),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () {
              //กดเลือกอาหาร
              //print(foodNames[index]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderFoodScreen(
                        imageName: foodImages[index],
                        foodname: foodNames[index],
                        FpriceList: FpriceList[index]),
                  ));
            },
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  foodImages[index],
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    foodNames[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('ราคา ${FpriceList[index]} บาท'))
              ],
            ),
          ),
        );
      },
    );
  }
}
