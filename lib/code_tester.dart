/*import 'dart:js';

import 'package:alabeer_admin/model/department_model.dart';
import 'package:alabeer_admin/view/utilities/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/doctor_model.dart';
// import 'doctor.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> doctorList = [];
  ProviderStatus providerstatus = ProviderStatus.IDLE;
  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');
  // List<String> departmentList = [];
  Future<void> createNewDoctor(String name, String service, String experience,
      String nationality, String doctorsID, String departmentId) async {
    try {
      providerstatus = ProviderStatus.LOADING;
      notifyListeners();
      await doctorsCollection.add({
        'bio': '',
        'departmentId': departmentId,
        'id': doctorsID,
        'languageKnown': '',
        'nationality': nationality,
        'profilePic': '',
        'serviceId': '',
        'yearOfExperience': experience,
        'name': name,
        'serviceName': service,
        'isDirector': false,
        'order': 0
      }).then((value) {
        loadDoctors();
        // providerstatus = ProviderStatus.LOADED;
        notifyListeners();
      });

      print('New doctor document added to Firestore');
    } catch (e) {
      providerstatus = ProviderStatus.ERROR;
      notifyListeners();
      print('Error adding new doctor document: $e');
    }
  }

  Future<void> updateDoctorsdetails({
    required String bio,
    required String departmentId,
    // required String id,
    required String languageKnown,
    required String nationality,

    // required String serviceId,
    required String yearOfExperience,
    required String name,
    required String serviceName,
    required bool isDirector,
    required int orderId,
  }) async {
    try {
      providerstatus = ProviderStatus.LOADING;
      notifyListeners();

      QuerySnapshot querySnapshot =
          await doctorsCollection.where('name', isEqualTo: name).get();

      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        docSnapshot.reference.update({
          'bio': bio,
          'departmentId': departmentId,
          'languageKnown': languageKnown,
          'nationality': nationality,
          'yearOfExperience': yearOfExperience,
          'name': name,
          'serviceName': serviceName,
          'isDirector': isDirector,
          'order': orderId
        }).then((value) {
          loadDoctors();
        });
      }

      print('New doctor document added to Firestore');
    } catch (e) {
      providerstatus = ProviderStatus.ERROR;
      notifyListeners();
      print('Error adding new doctor document: $e');
    }
  }

  Future<void> deleteDoctor({String? name}) async {
    try {
      providerstatus = ProviderStatus.LOADING;
      notifyListeners();

      QuerySnapshot querySnapshot =
          await doctorsCollection.where('name', isEqualTo: name).get();

      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        docSnapshot.reference.delete().then((value) {
          loadDoctors();
        });
      }

      print('New doctor document added to Firestore');
    } catch (e) {
      providerstatus = ProviderStatus.ERROR;
      notifyListeners();
      print('Error adding new doctor document: $e');
    }
  }

  Future<void> loadDoctors() async {
    try {
      providerstatus = ProviderStatus.LOADING;
      notifyListeners();
      final snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();
      final doctors =
          snapshot.docs.map((doc) => Doctor.fromJson(doc.data())).toList();
      doctorList = doctors;
      if (doctorList.isEmpty) {
        providerstatus = ProviderStatus.EMPTY;
        notifyListeners();
      }
      // print(doctorList[0].name);
      providerstatus = ProviderStatus.LOADED;
    } catch (error) {
      providerstatus = ProviderStatus.ERROR;
      // print('Error loading doctors: $error');
    }
    notifyListeners();
  }

//what???
  Doctor getDoctorByName(String name) {
    return doctorList.firstWhere((doctor) => doctor.name == name);
  }
}*/
