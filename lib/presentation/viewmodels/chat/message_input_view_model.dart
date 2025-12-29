import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class MessageInputViewModel extends ChangeNotifier {
  final TextEditingController? inputController;

  MessageInputViewModel({this.inputController});

  List<PlatformFile> files = [];

  void addFile(PlatformFile file) {
    files.add(file);
    notifyListeners();
  }

  void addFiles(List<PlatformFile> fileList) {
    files.addAll(fileList);
    notifyListeners();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    notifyListeners();
  }

  void removeFileAt(int index) {
    files.removeAt(index);
    notifyListeners();
  }

  void clearFiles() {
    files.clear();
    notifyListeners();
  }
}