import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_tester/model/user_details_model.dart';

class DataProvider extends ChangeNotifier {
  late String fetchedname;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController housenamecontroller = TextEditingController();
  TextEditingController Streetcontroller = TextEditingController();

  void restfieald() {
    usernamecontroller.clear();
    passcontroller.clear();
    agecontroller.clear();
    housenamecontroller.clear();
    Streetcontroller.clear();
    notifyListeners();
  }

  //databse services
  //Firestore irebase services
  List<UserDetails> detailedList = [];
  List<Address> nestedList = [];
  final CollectionReference dataRetriver =
      FirebaseFirestore.instance.collection('userDetails');

//CRUD
  Future<void> createNewuser(String Username, String pass, String age,
      String HouseName, String Street) async {
    try {
      notifyListeners();
      await dataRetriver.add({
        'username': Username,
        'password': pass,
        'age': age,
        // 'HouseName': HouseName,
        // 'Street': Street
      }).then((value) {
        //print("JustTry ${Username}");
        loaddetails();
        //loadaddress();
        //print("After ${Username}");
        notifyListeners();
      });
      print('New user document added to Firestore');
    } catch (e) {
      notifyListeners();
      print('Error adding new user document: $e');
    }
  }

  //user details loader
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
      print('check here${snapshot.docs.length}');
      final userDetails =
          snapshot.docs.map((doc) => UserDetails.fromJson(doc.data())).toList();
      print('Here23 ${userDetails[0]}');
      detailedList = userDetails;
      // print('boomerang ${detailedList[0]}');

      print('jobb ${userDetails.length}');
      if (detailedList.isEmpty) {
        print('List is empty');
        Text('The List Is empty');
        notifyListeners();
      }
    } catch (error) {
      print('error Loading the data main');
    }
    notifyListeners();
  }

  // address loader
  void AddressLoader(String Username) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadaddress(Username);
      notifyListeners();
    });
  }

  Future<void> loadaddress(String Fetchedusername) async {
    try {
      notifyListeners();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userDetails')
          .where("username", isEqualTo: Fetchedusername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first (and usually only) matching document
        var docid = querySnapshot.docs[0].id;

        final snapshot = await FirebaseFirestore.instance
            .collection('userDetails')
            .doc(docid) // Use the retrieved document ID here
            .collection('address')
            .get();

        final userAddress =
            snapshot.docs.map((doc) => Address.fromJson(doc.data())).toList();
        nestedList = userAddress;

        if (nestedList.isEmpty) {
          print('List is empty');
          Text('The List Is empty');
          notifyListeners();
        }
      } else {
        // if  no matching documents were found
        print('No matching documents found.');
      }
    } catch (error) {
      print('error Loading the data');
    }
    notifyListeners();
  }
}
