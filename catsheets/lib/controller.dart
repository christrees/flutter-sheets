import 'dart:convert' as convert;
import 'package:catsheets/models/form.dart';
import 'package:http/http.dart' as http;

class FormController {
  final void Function(String) callback;
  static const String URL =
      "https://script.google.com/macros/s/AKfycbyp3YmTzXlnBJ7DC6YcqCAxJE5s9WgSO2gVNXV5/exec";
  //    "https://script.google.com/macros/s/AKfycbyR-IeKj0-3mqDoJcYIaUA2yjiyMqZFow3VQM8VNM4lfxUN9Dg/exec";
  //  "https://script.google.com/macros/s/AKfycbyp3YmTzXlnBJ7DC6YcqCAxJE5s9WgSO2gVNXV5/exec";
  //  "https://script.google.com/macros/s/AKfycbyR-IeKj0-3mqDoJcYIaUA2yjiyMqZFow3VQM8VNM4lfxUN9Dg/exec";
  static const STATUS_SUCCESS = "SUCCESS";
  FormController(this.callback);
  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(URL + feedbackForm.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
