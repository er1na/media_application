import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'file_picker_controller.dart';
import 'dart:io';

class ArticleAddPage extends StatefulWidget{
  @override
  _ArticleAddPageState createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage>{

  final FilePickerController fileController = FilePickerController();

  String _title = "";
  String _text = "";
  String _filePath = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ArticleAdd"),
      ),
      body: Container(
        padding:  EdgeInsets.all(60),
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
                onChanged: (value){
                  setState(() {
                     _title = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextField(
                  maxLength: 2048,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Text",
                    hintStyle: TextStyle(color: Colors.blueGrey.shade200)
                  ),
                  onChanged: (value){
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
                  onPressed: (){
                    _title == "" && _text == ""
                    ?Navigator.of(context).pop()
                    :Navigator.of(context).pop({'title': _title, 'text': _text, 'filePath': _filePath});
                  },
                  child: Text("Save"),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width:  double.infinity,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
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

