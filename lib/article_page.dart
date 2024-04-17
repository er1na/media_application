import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ArticlePage extends StatefulWidget{

  ArticlePage(this.data);
  final Map<String, String> data;
  //final String articleTitle;
  @override
  _ArticlePageState createState() => _ArticlePageState();

}

class _ArticlePageState extends State<ArticlePage>{

  String _title = "";
  String _text = "";
  String _filePath = "";
  List<String> favoriteTitleList = [];
  List<String> favoriteTextList = [];
  List<String> favoriteFilePathList = [];
  Map<String, String> favoriteArticles = {};
  bool _isFavorite = false;

  @override
  void initState(){
    super.initState();
    init();
}

  void init() async{
    final prefs = await SharedPreferences.getInstance();

    _title = widget.data['title'] ?? '';
    _text = widget.data['text'] ?? '';
    _filePath = widget.data['filePath']??'';
    favoriteTitleList = prefs.getStringList("favoriteTitleList")??[];
    favoriteTextList = prefs.getStringList("favoriteTextList")??[];
    favoriteFilePathList = prefs.getStringList("favoriteFilePathList")??[];
    _isFavorite = favoriteTitleList.contains(_title);

    setState(() {});
  }

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('ArticlePage'),
        ),
        body: Padding(
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
                  if(_filePath.isNotEmpty)
                    SizedBox(
                      height: 200,
                      width: 300,
                      child: Image.file(File(_filePath),
                        height: 200,
                        width: 300,
                        fit: BoxFit.cover,),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 400,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 20, left: 20, bottom: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                        surfaceTintColor: MaterialStateProperty
                                            .all(
                                            _isFavorite
                                                ? Colors.blueGrey.shade300
                                                : Colors.white
                                        )
                                    ),
                                    onPressed: () async {
                                      final prefs = await SharedPreferences
                                          .getInstance();
                                      setState(() {
                                        _isFavorite = !_isFavorite;
                                        if (_isFavorite) {
                                          favoriteTitleList.add(_title);
                                          favoriteTextList.add(_text);
                                          favoriteFilePathList.add(_filePath);
                                        }else{
                                          int remIndex = favoriteTitleList.indexOf(_title);
                                          favoriteTitleList.removeAt(remIndex);
                                          favoriteTextList.removeAt(remIndex);
                                          favoriteFilePathList.removeAt(remIndex);
                                        }
                                        print(favoriteTitleList);
                                        prefs.setStringList("favoriteTitleList", favoriteTitleList);
                                        prefs.setStringList("favoriteTextList", favoriteTextList);
                                        prefs.setStringList("favoriteFilePathList", favoriteFilePathList);

                                      });
                                    },
                                    icon: Icon(
                                      _isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    ),
                                    label: Text("Favorite"),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(_text,
                                  style: TextStyle(fontSize: 20,
                                      color: Colors.blueGrey.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: 130,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("< Back",
                          style: TextStyle(
                              fontSize: 17),),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          surfaceTintColor: Colors.white,

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