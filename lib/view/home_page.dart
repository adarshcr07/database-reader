import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_tester/view_model/data_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data's From database"),
        backgroundColor: Colors.amber,
      ),
      body: Consumer<DataProvider>(builder: (context, connector, child) {
        connector.DetailsLoaderH();
        return ListView.builder(
          itemCount: connector.detailedList.length,
          itemBuilder: ((context, index) {
            Map<String, dynamic> detailsList = {
              'username': connector.detailedList[index].username,
              'password': connector.detailedList[index].password,
              'age': connector.detailedList[index].age,
            };

            return connector.ListCreator(context, detailsList, index);
            //GridTile(child: doctorsCard(doctorslist, index));
          }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Provider.of<DataProvider>(context, listen: false).dialogbox(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
