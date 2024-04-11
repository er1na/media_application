import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget{

  ArticlePage(this.data);
  final Map<String, String> data;
  @override
  _ArticlePageState createState() => _ArticlePageState();

}

class _ArticlePageState extends State<ArticlePage>{

  String _title = "";
  String _text = "";

  @override
  void initState(){
    super.initState();
    _title = widget.data['title']??'';
    _text = widget.data['text']??'';
  }

  @override
  Widget build(BuildContext context){
    var favButtonState = context.watch<ArticlePage>;

    return Scaffold(
      appBar: AppBar(
        title: Text('ArticlePage'),
      ),
      body:Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(_title,
                        style: TextStyle(fontSize: 23),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width:  400,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:15, right:20, left:20, bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    surfaceTintColor: MaterialStateProperty.all(Colors.white)
                                  ),
                                  onPressed: (){},
                                  icon: Icon(Icons.favorite_border),
                                  label: Text("Favorite"),
                                ),
                              ),
                            ),
                            Text(_text,
                            style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}