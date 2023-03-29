import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class OrderDrinkScreen extends StatefulWidget {
  const OrderDrinkScreen(
      {super.key,
      required this.imageName,
      required this.drinkNames,
      required this.DpriceList});
  final String imageName;
  final String drinkNames;
  final String DpriceList;

  @override
  State<OrderDrinkScreen> createState() => _OrderDrinkScreenState();
}

class _OrderDrinkScreenState extends State<OrderDrinkScreen> {
  int orderNum = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ระบุจำนวนเครื่องดื่ม")),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(20),
              child: Image.asset(widget.imageName),
            ),
            Container(
              width: 400,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (orderNum >= 10) {
                            orderNum = 10;
                          } else {
                            orderNum++;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.add,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  Text("$orderNum",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (orderNum == 1) {
                            orderNum = 1;
                          } else {
                            orderNum--;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              height: 100,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.amber),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    //MAP
                    Map<String, dynamic> values = Map();
                    values['cust_id'] = '63011212180';
                    values['product_name'] = widget.drinkNames;
                    values['order_num'] = orderNum;
                    values['product_source'] = widget.imageName;
                    values['amount'] = widget.DpriceList;

                    insertOrder(values);
                    Navigator.pop(context);
                  });
                },
                child: Text('ยืนยัน'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void insertOrder(Map<String, dynamic> values) async {
    //var url = Uri.https('http://192.168.1.146:3000/insertorder&#39;);

    try {
      var url = Uri.http('192.168.1.4:3000', '/order');

      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: convert.jsonEncode(values));
      if (response.statusCode == 200) {
        print('Insert Success!!');
        //Navigator.pop(context, true);
      } else {
        print('Insert not Success!!');
      }
    } catch (e) {
      print(e);
    }
  }
}
