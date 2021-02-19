import 'package:flutter/material.dart';
import 'package:msb/HomeScreen.dart';
import 'package:msb/ProfileScreen.dart';
import 'package:msb/api/feedback_api.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  GlobalKey<FormState> _feedbackKey =
      GlobalKey<FormState>(debugLabel: '_feedbackScreen');
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String feedbackCategory;
  List _feedbackCategory = [
    "Keluhan Aplikasi",
    "Masukan",
  ];
  @override
  Widget build(BuildContext context) {
    final TextEditingController feedback = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Feedback'),
      ),
      key: _globalKey,
      body: Form(
        key: _feedbackKey,
        child: SafeArea(
          child: Column(children: <Widget>[
            SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Select Category :',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  elevation: 10,
                  icon: Icon(Icons.arrow_drop_down_circle),
                  iconSize: 25.0,
                  isExpanded: true,
                  value: feedbackCategory,
                  onChanged: (value) {
                    setState(() {
                      feedbackCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select the category';
                    }
                    return null;
                  },
                  items: _feedbackCategory.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  'Write Your Feedback :',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextFormField(
                controller: feedback,
                maxLength: 360,
                minLines: 4,
                maxLines: null,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please write your feedback';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Write your feedback",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    // doRegister(_userStore);
                    if (_feedbackKey.currentState.validate()) {
                      submitFeedback(feedbackCategory, feedback.text);
                      _globalKey.currentState.showSnackBar(new SnackBar(
                          content: new Text("Feedback Submitted!")));
                      Future.delayed(Duration(milliseconds: 1000)).then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(index: 4),
                          ),
                        ),
                      );
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
