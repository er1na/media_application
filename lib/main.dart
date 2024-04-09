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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade100),
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

  List<String> articleList = [];

  @override
  void initState(){
    super.initState();
    init();
  }

  void init() async{
    final prefs = await SharedPreferences.getInstance();
    articleList = prefs.getStringList("articleList")??[];
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("ArticleList"),
        ),
        body: ListView.builder(
            itemCount: articleList.length,
            itemBuilder: (context, index){
              return Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(onPressed: (context) async{
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        articleList.removeAt(index);
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
                      final editText = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticleEditPage(articleList[index])),
                      );
                      if(editText != null){
                        setState(() {
                          articleList[index] = editText;
                        });
                      }
                      prefs.setStringList("articleList", articleList);
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
                                    Text("hello", style: TextStyle(fontSize: 23, color: Colors.blueGrey.shade900),),
                                    Text("subsubsubsubsubs...", style: TextStyle(fontSize: 20,color: Colors.blueGrey.shade400),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //articleList[index]),
                          onTap: (){
                          },
                          ),
                      ),
                    )
                  ),
                ),
              );
            }
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final prefs = await SharedPreferences.getInstance();
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                return ArticleAddPage();
              }),
            );
            if (newListText != null){
              setState(() {
                articleList.add(newListText);
              });
            }
            prefs.setStringList("articleList", articleList);
          },
          child: Icon(Icons.add),
        )
    );
  }
}