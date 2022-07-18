import '../../domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required int postId,
    required int id,
    required String name,
    required String email,
    required String body,
  }) : super(postId: postId, id: id, name: name, email: email, body: body);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
