import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ArticleEditPage extends StatefulWidget {

  ArticleEditPage(this.data);
  final Map<String, String> data;
  @override
  _ArticleEditPageState createState() => _ArticleEditPageState();
}

class _ArticleEditPageState extends State<ArticleEditPage> {

  String _title = "";
  String _text = "";
  String _filePath = "";

  @override
  void initState() {
    super.initState();
    _title = widget.data['title']??'';
    _text = widget.data['text']??'';
    _filePath = widget.data['filePath']??'';
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: _title);
    titleController.selection = TextSelection.fromPosition(
      TextPosition(offset: titleController.text.length),
    );

    TextEditingController textController = TextEditingController(text: _text);
    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ArticleEdit'),
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
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
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: () async{
                      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
                          type:  FileType.any
                      );
                      if(filePickerResult != null){
                        String filePath = filePickerResult.files.first.path!;
                        _filePath = filePath;
                        print(_filePath);
                      }else{
                        print("No image");
                      }
                    },
                    child: Text("select image")),
              ),
              TextField(
                maxLength: 15,
                enabled: true,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.blueGrey.shade200)
                ),
                controller: titleController,
                onChanged: (String value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  maxLength: 2048,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Text",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade200)
                  ),
                  controller: textController,
                  onChanged: (String value){
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
                  onPressed: () {
                    Navigator.of(context).pop({"title": _title,"text": _text, "filePath": _filePath});
                  },
                  child: Text("Save"),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop({'title': _title, 'text': _text, 'filePath': _filePath});
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