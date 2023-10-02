import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_tester/view/user_datas.dart';
import 'package:user_tester/view_model/data_provider.dart';

void dialogbox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Consumer<DataProvider>(builder:
            (BuildContext context, DataProvider consumer, Widget? child) {
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
                      controller: consumer.usernamecontroller,
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
                      controller: consumer.passcontroller,
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
                      controller: consumer.agecontroller,
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
                      controller: consumer.housenamecontroller,
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
                      controller: consumer.Streetcontroller,
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
                            consumer.restfieald();
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
                          if (consumer.usernamecontroller.text.isNotEmpty) {
                            consumer
                                .createNewuser(
                                    consumer.usernamecontroller.text,
                                    consumer.passcontroller.text,
                                    int.tryParse(consumer.agecontroller.text) ??
                                        0, //it retrieve the string text as int ! just replaced the cast
                                    consumer.housenamecontroller.text,
                                    consumer.Streetcontroller.text)
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
      });
}

//address displayer
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

//List creator
Widget ListCreator(BuildContext context, Map<String, dynamic> mapofuserdetails,
    int index, String Username) {
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
                      fetchdUsername: Username,
                    )),
          )
        },
      ),
    ),
  );
}
