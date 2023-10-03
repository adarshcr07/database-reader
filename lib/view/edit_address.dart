import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_tester/view/home_page.dart';
import 'package:user_tester/view/user_datas.dart';
import 'package:user_tester/view_model/data_provider.dart';
//import 'package:user_tester/view/user_datas.dart';

class EditAddresspage extends StatefulWidget {
  final String fetchdUsername;
  final Map<String, dynamic> currentUserAddress;

  const EditAddresspage(
      {super.key,
      required this.currentUserAddress,
      required this.fetchdUsername});

  EditAddresspageState createState() => EditAddresspageState();
}

class EditAddresspageState extends State<EditAddresspage> {
  TextEditingController EditHousenamecontroller = TextEditingController();
  TextEditingController EditStreetcontroller = TextEditingController();

  late String value;
  bool isUpdating = false;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EditHousenamecontroller.text = widget.currentUserAddress['HouseName'];
      EditStreetcontroller.text = widget.currentUserAddress['Street'];
    });
    // print(widget.currentDoctordetails.departmentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Edit Address of ${widget.fetchdUsername}'),
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
      body: Consumer<DataProvider>(builder: (context, test, child) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 0.75,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 63, 45, 45),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: EditHousenamecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //hintText: widget.currentUserAddress['HouseName']
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 0.75,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 63, 45, 45),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: TextField(
                      controller: EditStreetcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: widget.currentUserAddress['Street']
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 27, 175, 233)),
                      overlayColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (!isUpdating) {
                        setState(() {
                          isUpdating = true;
                        });
                        print(
                            'house name changed ${EditHousenamecontroller.text}');
                        print('street changed ${EditStreetcontroller.text}');
                        test.UpdateUserAddress(
                                name: widget.fetchdUsername,
                                Housename: EditHousenamecontroller.text,
                                Street: EditStreetcontroller.text)
                            .then((value) {
                          setState(() {
                            isUpdating = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Displaypage(
                                    fetchdUsername: widget.fetchdUsername)),
                          );
                        });
                      }
                    },
                    child: isUpdating
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue), // Change the color
                            strokeWidth:
                                4.0, // Adjust the thickness of the indicator
                            backgroundColor:
                                Colors.grey, // Set the background color
                          )
                        : Text(
                            'Tap TO UPDATE',
                            style: TextStyle(color: Colors.white),
                          ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
