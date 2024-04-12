import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier{

  Map<String, String> favoriteArticles = {};
  void toggleFavorite(String articleTitle, String articleText){
    if(favoriteArticles.containsKey(articleTitle)){
      favoriteArticles.remove(articleTitle);
    }else{
      favoriteArticles[articleTitle] = articleText;
    }
    notifyListeners();
  }

}