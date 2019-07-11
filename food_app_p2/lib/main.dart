import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Category').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
                itemExtent: 220.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  String image =
                      snapshot.data.documents[index].data['Image'].toString();
                  String name =
                      snapshot.data.documents[index].data['Name'].toString();
                  return Column(
                    children: <Widget>[
                      new Image.network(
                        image,
                        fit: BoxFit.fill,
                        height: 201.0,
                        width: double.infinity,
                      ),
                      new Text(
                        name,
                      ),
                    ],
                  );
                });
          } else {
            return Center(child: new CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
