import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:user_tester/model/user_details_model.dart';
import 'package:user_tester/view/user_datas.dart';

class DataProvider extends ChangeNotifier {
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

  void dialogbox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('USERNAME'),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 63, 45, 45),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text('PASSWORD'),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 63, 45, 45),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: passcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text('AGE'),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 63, 45, 45),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: agecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text('HOUSENAME'),
                SizedBox(height: 3),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 63, 45, 45),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: housenamecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text('STREET'),
                SizedBox(
                  height: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 63, 45, 45),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: Streetcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                          onPressed: () {
                            restfieald();
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: Text(
                            'Discard',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {
                          if (usernamecontroller.text.isNotEmpty) {
                            notifyListeners();
                            createNewuser(
                                    usernamecontroller.text,
                                    passcontroller.text,
                                    agecontroller.text,
                                    housenamecontroller.text,
                                    Streetcontroller.text)
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 54, 152, 244)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ));
        });
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
      // notifyListeners();
      await dataRetriver.add({
        'username': Username,
        'password': pass,
        'age': age,
        // 'HouseName': HouseName,
        // 'Street': Street
      }).then((value) {
        loaddetails();
        //loadaddress();
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
      final userDetails =
          snapshot.docs.map((doc) => UserDetails.fromJson(doc.data())).toList();
      detailedList = userDetails;

      print('jobb ${userDetails.length}');
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

  // address loader
  void AddressLoader() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadaddress();
      notifyListeners();
    });
  }

  Future<void> loadaddress() async {
    try {
      notifyListeners();

      final snapshot =
          //remove the collection group and fetch the data with document id .
          //await FirebaseFirestore.instance.collectionGroup('address').get();
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc('john') //enter the id here!
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
    } catch (error) {
      print('error Loading the data');
    }
    notifyListeners();
  }

  Widget DisplayAddress(
      BuildContext context, Map<String, dynamic> address, int index) {
    //print('test ${index}');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(address['HouseName']),
          subtitle: Text(address['Street']),
        ),
      ),
    );
  }

  Widget ListCreator(
      BuildContext context, Map<String, dynamic> mapofuserdetails, int index) {
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
          onTap: () => {
            // index = savedindex,
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Displaypage(
                        index: index,
                      )),
            )
          },
        ),
      ),
    );
  }
}
