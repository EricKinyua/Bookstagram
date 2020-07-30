import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  StorageUploadTask storageUploadTask;
  StorageTaskSnapshot taskSnapshot;

  StorageProvider() {
    print('Cloud storage initialized');
  }

  Future<String> startUpload(String uid, File file) async {
    /// Unique file name for the file
    DateTime now = DateTime.now();
    String filePath;
    filePath = 'posts/$uid/${now.toLocal()}.png';
    //Create a storage reference
    StorageReference reference = FirebaseStorage.instance.ref().child(filePath);
    //Create a task that will handle the upload
    storageUploadTask = reference.putFile(
      file,
    );
    taskSnapshot = await storageUploadTask.onComplete;
    String urlResult = await taskSnapshot.ref.getDownloadURL();
    return urlResult;
  }
}
