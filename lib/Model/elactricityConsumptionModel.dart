import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:household/Constant.dart';
import 'package:http/http.dart' as http;

class elactricityConsumptionModel extends ChangeNotifier{
  getConsumptionDetails () async{
    var data = await http.get(Uri.parse('${IOT_URL}'));
    var jsonData = jsonDecode(data.body);

  }

}