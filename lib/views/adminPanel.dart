import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _firestore = Firestore.instance;
  String answer;
  int option = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    color: (option == 1)
                        ? Colors.tealAccent[100]
                        : Colors.grey[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.tealAccent, width: 3)),
                    child: Text(
                      'Option 1',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        answer = 'Option 1';
                        option = 1;
                      });
                    },
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Text(
                      'Option 2',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        answer = 'Option 2';
                        option = 2;
                      });
                    },
                    color: (option == 2)
                        ? Colors.tealAccent[100]
                        : Colors.grey[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.tealAccent, width: 3)),
                  ),
                  RaisedButton(
                    child: Text(
                      'Option 3',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        answer = 'Option 3';
                        option = 3;
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    color: (option == 3)
                        ? Colors.tealAccent[100]
                        : Colors.grey[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.tealAccent, width: 3)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue, width: 3)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                'Send',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                print(answer);
                _firestore.collection('options').add({
                  'option': answer,
                  'time': DateTime.now(),
                });
                _scaffoldkey.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'Option Send',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                ));
              },
              color: Colors.blue[200],
              elevation: 5,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: 350,
                    child: RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red, width: 3)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        'Disable for all',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        print(answer);
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Disabled for all !',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      color: Colors.red[200],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: 350,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red, width: 3)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        'Disable for not joined users',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Disabled for not joined users !',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      color: Colors.red[200],
                      elevation: 5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: 350,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green, width: 3)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text(
                        'Enable for all',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        _scaffoldkey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'Enabled for all !',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      color: Colors.green[200],
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
