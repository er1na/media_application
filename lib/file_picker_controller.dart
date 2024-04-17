import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerController with ChangeNotifier{

  bool pickSuccess = false;
  File? file;
  String fileName = '';

  Future<void> pickImage() async{
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if(result != null){
        file = File(result.files.single.path!);
        fileName = result.files.single.name;
        pickSuccess = true;
      }else{
        pickSuccess = false;
      }
    }catch(e){
      pickSuccess = false;
      print('Error picking image: $e');
    }

    notifyListeners();
  }
}