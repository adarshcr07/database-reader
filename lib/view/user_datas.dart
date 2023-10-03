import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_tester/view/home_page.dart';
import 'package:user_tester/view/widgets.dart';
import 'package:user_tester/view_model/data_provider.dart';

class Displaypage extends StatefulWidget {
  final String fetchdUsername;

  const Displaypage({super.key, required this.fetchdUsername});

  DisplaypageState createState() => DisplaypageState();
}

class DisplaypageState extends State<Displaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub collection data"),
        backgroundColor: const Color.fromARGB(255, 143, 142, 139),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'title')),
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Consumer<DataProvider>(
        builder: (context, connector, child) {
          // ignore: unnecessary_null_comparison
          if (connector.nestedList == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            connector.AddressLoader(
                widget.fetchdUsername); //fetch the id with widget dot
            //  print('anser ${widget.fetchdUsername}');
            return ListView.builder(
                itemCount: connector.nestedList.length,
                itemBuilder: ((context, index) {
                  Map<String, dynamic> nestlist = {
                    'HouseName': connector.nestedList[index].HouseName,
                    'Street': connector.nestedList[index].Street,
                  };
                  // print('object ${nestlist.length}');
                  return DisplayAddress(
                      context, nestlist, index, widget.fetchdUsername);
                }));
          }
        },
      ),
    );
  }
}
