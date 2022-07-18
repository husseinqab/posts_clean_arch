import 'dart:convert';

import 'package:posts_clean_arch/fearutres/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel(
      {required int id,
      required int userId,
      required String title,
      required String body})
      : super(id: id, body: body, title: title, userId: userId);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body']);
  }

  List<PostModel> listFromJson(String str) =>
      List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }
}
