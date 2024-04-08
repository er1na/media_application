import 'package:flutter/material.dart';

class ArticleAddPage extends StatefulWidget{
  @override
  _ArticleAddPageState createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage>{

  String _text = "";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ArticleAdd"),
      ),
      body: Container(
        padding:  EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(_text);
                },
                child: Text("Save"),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width:  double.infinity,
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

