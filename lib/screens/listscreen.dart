import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:projectfinal/database/GetOrder.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Data>? _listOrder = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                //leading: Image.network('${_lsProducts?[index].thumbnail}'),
                leading: Image.asset('${_listOrder?[index].product_source}'),
                title: Text('${_listOrder?[index].product_name}'),
                subtitle: Text(
                    'จำนวน ${_listOrder?[index].order_num} ชิ้น รวม ${_listOrder?[index].amount} บาท'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print(
                        'Delete order number: ${_listOrder?[index].order_no}');
                    setState(() {
                      deleteOrder('${_listOrder?[index].product_name}');
                    });
                  },
                ),
                // onTap: () {
                //   print('${_listOrder?[index].product_source}');
                // },
              );
            },
            separatorBuilder: (context, index) => Divider(color: Colors.grey),
            itemCount: _listOrder == null ? 0 : _listOrder!.length));
  }

//!----------------------------------------------------------------------------
  void getAPI() async {
//var url = Uri.parse('http:// IP:portnumber/orderwhere');

    try {
      String oid = '63011212180';

      var url = Uri.http('192.168.1.4:3000', '/order/${oid}');

      ;

      print(url);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        print('data : ${response.body}');

        GetOrder gorder = GetOrder.fromJson(convert.jsonDecode(response.body));

        print('data : ${gorder.data}');

// return products_model.products;

        setState(() {
          _listOrder = gorder.data;
        });

// print(_lsProducts?[0].title);

      } else {
        print('Request failed with status: ${response.statusCode}.');

        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteOrder(String product_name) async {
    try {
      var url = Uri.http('192.168.1.4:3000', '/order/63011212180/product/${product_name}');

      print(url);

      var response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        getAPI();
        print('data : ${response.body}');

        GetOrder gorder = GetOrder.fromJson(convert.jsonDecode(response.body));

        print('data : ${gorder.data}');

// return products_model.products;

        setState(() {
          _listOrder = gorder.data;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');

        throw Exception('Failed to load Data');
      }
    } catch (e) {
      print(e);
    }
  } //g
  //getAPI
}
