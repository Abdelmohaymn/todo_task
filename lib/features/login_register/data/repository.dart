
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'model/phone_model.dart';

class LogRegRepository{

  // get phones code
  Future<List<PhoneModel>> fetchPhonesCodeFromJson() async {
    // Load JSON file as a string
    String jsonString = await rootBundle.loadString('assets/jsons/phones.json');
    // Decode JSON string into Dart object
    List<dynamic> jsonList = json.decode(jsonString);
    // Convert List<dynamic> to List<DataModel>
    List<PhoneModel> data = jsonList.map((json) => PhoneModel.fromJson(json)).toList();

    return data;
  }

  Future<bool> validatePhoneNumber(String phoneNumber) async {
    try {
      final parsedNumber = await parse(phoneNumber);
      print('Valid phone number: ${parsedNumber['e164']}');
      return true;
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

}