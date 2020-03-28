import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final _firestore = Firestore.instance;

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
        title: Text('Trivia Time'),
        backgroundColor: Colors.blue,
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
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
              child: Column(
                children: <Widget>[
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('options')
                          .orderBy(
                            'time',
                            descending: true,
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          );
                        }
                        final messages = snapshot.data.documents;
                        List<String> msgs = [];
                        for (var msg in messages) {
                          final option = msg.data['option'];
                          msgs.add(option);
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  color:
                                      (index == 0) ? Colors.green : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.message),
                                  title: Text(
                                    msgs[index],
                                    style: TextStyle(
                                      color: (index == 0)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: (index == 0)
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: msgs.length,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            letterSpacing: 2,
                          ),
                        ),
                        elevation: 10,
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        )),
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
