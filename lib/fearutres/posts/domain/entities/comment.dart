/*
{
    "postId": 1,
    "id": 1,
    "name": "id labore ex et quam laborum",
    "email": "Eliseo@gardner.biz",
    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
  },
* */

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => [postId, id, name, email, body];
}
