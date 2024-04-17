import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article_page.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FavoriteListPage extends StatefulWidget{

  FavoriteListPage();

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();

}


class _FavoriteListPageState extends State<FavoriteListPage>{

  List<String> favoriteTitleList = [];
  List<String> favoriteTextList = [];
  List<String> favoriteFilePathList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async{
    final prefs = await SharedPreferences.getInstance();
    favoriteTitleList = prefs.getStringList("favoriteTitleList")??[];
    favoriteTextList = prefs.getStringList("favoriteTextList")??[];
    favoriteFilePathList = prefs.getStringList("favoriteFilePathList")??[];
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("FavoriteList"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: favoriteTitleList.length,
                  itemBuilder: (context, index){
                    return SizedBox(
                      height: 120,
                      child: Card(
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: SizedBox(
                                        height: 100,
                                        width:  130,
                                        child: Image.file(File(favoriteFilePathList[index]),
                                          height: 100,
                                          width: 130,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, top: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(favoriteTitleList[index], style: TextStyle(fontSize: 23, color: Colors.blueGrey.shade900),),
                                          Text(favoriteTextList[index], style: TextStyle(fontSize: 20,color: Colors.blueGrey.shade400),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //articleList[index]),
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) =>
                                          ArticlePage({'title': favoriteTitleList[index], 'text': favoriteTextList[index],
                                           'filePath': favoriteFilePathList[index]}),
                                      )
                                  );
                                },
                              ),
                            ),
                          )
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
        );

  }

}