import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:user_tester/model/user_details_model.dart';
import 'package:user_tester/view_model/data_provider.dart';

class Displaypage extends StatefulWidget {
  final int index;
  const Displaypage({super.key, required this.index});
  /* final String fetchdUsername;

  const Displaypage({super.key, required this.fetchdUsername});*/

  DisplaypageState createState() => DisplaypageState();
}

class DisplaypageState extends State<Displaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub collection data"),
        backgroundColor: const Color.fromARGB(255, 143, 142, 139),
      ),
      body: Consumer<DataProvider>(
        builder: (context, connector, child) {
          // ignore: unnecessary_null_comparison
          if (connector.nestedList == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            connector.AddressLoader(); //fetch the id with widget dot
            return ListView.builder(
                itemCount: connector.nestedList.length,
                itemBuilder: ((context, index) {
                  Map<String, dynamic> nestlist = {
                    'HouseName': connector.nestedList[index].HouseName,
                    'Street': connector.nestedList[index].Street,
                  };
                  print('object ${nestlist.length}');
                  return connector.DisplayAddress(context, nestlist, index);
                }));
          }
        },
      ),
    );
  }
}
