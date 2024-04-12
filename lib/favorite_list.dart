import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article_page.dart';
import 'package:provider/provider.dart';
import 'favorite_model.dart';

class FavoriteListPage extends StatefulWidget{

  FavoriteListPage();

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();

}


class _FavoriteListPageState extends State<FavoriteListPage>{

  List<String> favoriteArticles = [];
  
  @override
  void initState(){
    super.initState();
    init();
  }
  
  void init() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteArticles = prefs.getStringList("favoriteArticles")??[];
    });
  }

  @override
  Widget build(BuildContext context){

    return
      Scaffold(
      appBar: AppBar(
        title: Text("FavoriteList"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
          itemCount: favoriteArticles.length,
          itemBuilder: (context, index){
            SizedBox(
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
                              child: Image.asset('assets/015_l.jpg',
                                height: 100,
                                width: 130,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(favoriteArticles[index], style: TextStyle(fontSize: 23, color: Colors.blueGrey.shade900),),
                                  Text(favoriteArticles[index], style: TextStyle(fontSize: 20,color: Colors.blueGrey.shade400),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        //articleList[index]),
                        onTap: ()async{
                          final prefs = await SharedPreferences.getInstance();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  ArticlePage({'title': favoriteArticles[index], 'text': favoriteArticles[index]}),
                              )
                          );
                        },
                      ),
                    ),
                  )
              ),
            );
          }),
        );

  }

}