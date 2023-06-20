import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
        videoPath, quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('video').child(id);

    ref.putFile(await _compressVideo(videoPath));
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firestore.collection('users')
          .doc(uid)
          .get();

      //get ID

      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadVideoStorage("Video $len", videoPath);

      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          profilePhoto: (userDoc.data()! as Map<String,
              dynamic>)['profilePhoto'],
          thumbnail: thumbnail);
      
      await firestore.collection('videos').doc('Video $len').set(
        video.toJason(),
      );
      Get.back();
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString(),
      );
    }
  }
}
