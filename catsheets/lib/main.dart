import 'package:flutter/material.dart';
import 'package:catsheets/controller.dart';
import 'package:catsheets/models/form.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'catsheets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'catsheets Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController whoController = TextEditingController();
  TextEditingController whatController = TextEditingController();
  TextEditingController whichController = TextEditingController();
  TextEditingController whyController = TextEditingController();
  TextEditingController whereController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      FeedbackForm feedbackForm = FeedbackForm(
          DateTime.now().toString(),
          whoController.text,
          whatController.text,
          whichController.text,
          whyController.text,
          position.toString(), //whereController.text,
          photoController.text);
      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Feedback Submitted");
          _clearForm();
        } else {
          _showSnackbar("Error Occurred!");
        }
      });
      _showSnackbar("Submitting Feedback");
      formController.submitForm(feedbackForm);
    }
  }

  _clearForm() {
    _showSnackbar("Clearing Form");
    setState(() {
      whoController.text = "";
      whatController.text = "";
      whichController.text = "";
      whyController.text = "";
      photoController.text = "";
    });
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("catsheets"),
        actions: [],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          value: "Mom",
                          child: Center(
                            child: Text("Mom"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Carla",
                          child: Center(
                            child: Text("Carla"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Chris",
                          child: Center(
                            child: Text("Chris"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Carol",
                          child: Center(
                            child: Text("Carol"),
                          ),
                        ),
                      ],
                      onChanged: (_value) => {
                        print(_value.toString()),
                        setState(() {
                          whoController.text = _value;
                        }),
                      },
                      hint: Text("Select Who"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          value: "AL",
                          child: Center(
                            child: Text("AL"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Donate",
                          child: Center(
                            child: Text("Donate"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Carla",
                          child: Center(
                            child: Text("Carla"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Chris",
                          child: Center(
                            child: Text("Chris"),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Carol",
                          child: Center(
                            child: Text("Carol"),
                          ),
                        ),
                      ],
                      onChanged: (_value) => {
                        print(_value.toString()),
                        setState(() {
                          whatController.text = _value;
                          whichController.text = _value+"-"+DateTime.now().toString();
                        }),
                      },
                      hint: Text("Select Pile"),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _clearForm,
                      child: Text('Clear Form'),
                    )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: whoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Valid Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Name of who"),
                    ),
                    TextFormField(
                      controller: whatController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "To which pile"),
                    ),
                    TextFormField(
                      controller: whichController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Box Label";
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "Item in Box Labeled"),
                    ),
                    TextFormField(
                      controller: whyController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Notes";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Notes"),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                      child: Text('Save this pile'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
