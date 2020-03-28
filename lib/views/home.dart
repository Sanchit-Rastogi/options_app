import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.lightBlueAccent,
              title: Text(
                'Are you sure?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: Text(
                'Do you want to exit the app ?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('YES'),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trivia Time"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/optionsBG.jpg",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              child: Center(
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    elevation: 10,
                    color: Colors.blue,
                    focusColor: Colors.green,
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        letterSpacing: 2,
                      ),
                    ),
                    onPressed: () {
                      _fcm.subscribeToTopic('options');
                      Navigator.pushNamed(context, 'game');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
