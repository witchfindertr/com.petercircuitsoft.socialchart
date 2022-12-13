import 'package:get/get.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';

class CommentController extends GetxController {
  CommentController({
    required this.commentId,
    required this.commentData,
  });
  final String commentId;
  final ModelUserComment commentData;

  final _userData = Rxn<ModelUserData>();
  ModelUserData? get userData => _userData.value;

  final _isComment = true.obs;
  bool get isComment => _isComment.value;

  @override
  void onInit() {
    _isComment.value = commentData.createdAt == commentData.commentCreatedAt;
    userDataColRef().doc(commentData.author).get().then((value) {
      _userData.value = value.data();
    });

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
