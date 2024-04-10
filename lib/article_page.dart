import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget{

  ArticlePage(this.favoriteState);
  final bool favoriteState;
  //final Map<String, String> data;
  _ArticlePageState createState() => _ArticlePageState();

}

class _ArticlePageState extends State<ArticlePage>{

  bool _favoriteState = false;
  String _title = "";
  String _text = "";

  @override
  void initState(){
    super.initState();
    //_title = widget.data['title'];
    //_text = widget.data['text'];
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
                    child: Text("aaaaaaaaaaaaaaaaasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasasa"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width:  400,
                    child: Card(
                      child: Text("aaaaasasassasasassasassasssassasasasassassasasasassasasasasassassasasasasassaasassasaasaaasasasasasassssaasasasasasasasasasa"),
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