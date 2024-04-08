import 'package:flutter/material.dart';


class ArticleEditPage extends StatefulWidget {
  ArticleEditPage(this.text);
  String text;
  @override
  _ArticleEditPageState createState() => _ArticleEditPageState();
}

class _ArticleEditPageState extends State<ArticleEditPage> {
  String _text = "";

  @override
  void initState() {
    super.initState();
    _text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: _text);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ArticleEdit'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.brown[300])),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // Editボタン
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_text);
                },
                child: Text("Edit"),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
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