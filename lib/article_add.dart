import 'package:flutter/material.dart';

class ArticleAddPage extends StatefulWidget{
  @override
  _ArticleAddPageState createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage>{

  String _title = "";
  String _text = "";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ArticleAdd"),
      ),
      body: Container(
        padding:  EdgeInsets.all(60),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              TextField(
                maxLength: 15,
                enabled: true,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.blueGrey.shade200)
                ),
                onChanged: (value){
                  setState(() {
                     _title = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextField(
                  maxLength: 2048,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Text",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade200)
                  ),
                  onChanged: (value){
                    setState(() {
                      _text = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop({'title': _title, 'text': _text});
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
      ),
    );
  }

}

