import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tester/model/user_details_model.dart';

class DataProvider extends ChangeNotifier {
  List<UserDetails> detailedList = [];
  final CollectionReference dataRetriver =
      FirebaseFirestore.instance.collection('userDetails');

  void DetailsLoaderH() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loaddetails();
      notifyListeners();
    });
  }

  Future<void> loaddetails() async {
    try {
      notifyListeners();
      // final snapshot = dataRetriver.get(); is it works??
      final snapshot =
          await FirebaseFirestore.instance.collection('userDetails').get();
      final userDetails =
          snapshot.docs.map((doc) => UserDetails.fromJson(doc.data())).toList();
      detailedList = userDetails;
      if (detailedList.isEmpty) {
        print('List is empty');
        Text('The List Is empty');
        notifyListeners();
      }
    } catch (error) {
      print('error Loading the data');
    }
    notifyListeners();
  }

  Widget ListCreator(Map<String, dynamic> mapofuserdetails, int index) {
    //notifyListeners();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(mapofuserdetails['username']),
          subtitle: Text(mapofuserdetails['password']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('AGE'), Text(mapofuserdetails['age'].toString())],
          ),
          onTap: () => {},
        ),
      ),
    );
  }
}
