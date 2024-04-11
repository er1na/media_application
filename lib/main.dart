import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/src/widgets/scroll_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'article_add.dart';
import 'article_edit.dart';
import 'article_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Media App",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
        primary: Colors.blueGrey.shade300
        )
      ),
      home: articleListPage(),
    );
  }
}

class articleListPage extends StatefulWidget{
  @override
  _articleListPageState createState() => _articleListPageState();
}

class _articleListPageState extends State<articleListPage>{

  List<String> articleTitleList = [];
  List<String> articleTextList = [];

  @override
  void initState(){
    super.initState();
    init();
  }

  void init() async{
    final prefs = await SharedPreferences.getInstance();
    articleTitleList = prefs.getStringList("articleTitleList")??[];
    articleTextList = prefs.getStringList("articleTextList")??[];
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("ArticleList"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.favorite),
                    label: Text("List"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50)
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: articleTitleList.length,
                    itemBuilder: (context, index){
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.25,
                          children: [
                            SlidableAction(onPressed: (context) async{
                              final prefs = await SharedPreferences.getInstance();
                              setState(() {
                                articleTitleList.removeAt(index);
                                articleTextList.removeAt(index);
                              });
                            },
                                icon: Icons.delete
                            )
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.15,
                          children: [
                            SlidableAction(onPressed: (context) async{
                              final prefs = await SharedPreferences.getInstance();
                              final Map<String, String> editData;

                              editData = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticleEditPage({'title': articleTitleList[index], 'text': articleTextList[index]})));

                              if(editData['title'] != null){
                                setState(() {
                                  articleTitleList[index] = editData['title']??'';
                                });
                              }else{
                                articleTitleList[index] = editData['title']??'';
                              }

                              if(editData['text'] != null){
                                setState(() {
                                  articleTextList[index] = editData['text']??'';
                                });
                              }else{
                                articleTextList[index] = editData['text']??'';
                              }

                              prefs.setStringList("articleTitleList", articleTitleList);
                              prefs.setStringList("articleTextList", articleTextList);
                            },
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                  
                        child: SizedBox(
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
                                            Text(articleTitleList[index], style: TextStyle(fontSize: 23, color: Colors.blueGrey.shade900),),
                                            Text(articleTextList[index], style: TextStyle(fontSize: 20,color: Colors.blueGrey.shade400),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Icon(Icons.favorite_border,
                                      color: Colors.blueGrey.shade500),
                                  ),
                                  //articleList[index]),
                                  onTap: ()async{
                                    final prefs = await SharedPreferences.getInstance();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) =>
                                      ArticlePage({'title': articleTitleList[index], 'text': articleTextList[index]})
                                      )
                                    );
                                  },
                                  ),
                              ),
                            )
                          ),
                        ),
                      );
                    }
                            ),
                ),
              ],
            ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final prefs = await SharedPreferences.getInstance();
            final addData = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return ArticleAddPage();
              }),
            );

            if (addData['title'] != null){
              setState(() {
                articleTitleList.add(addData['title']);
              });
            }
            if (addData['text'] != null){
              setState(() {
                articleTextList.add(addData['text']);
              });
            }
            prefs.setStringList("articleTitleList", articleTitleList);
            prefs.setStringList("articleTextList", articleTextList);
          },
          child: Icon(
            Icons.add
          )
        ),

    );
  }
}