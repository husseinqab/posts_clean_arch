import 'package:equatable/equatable.dart';

class Company extends Equatable{
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  final String name;
  final String catchPhrase;
  final String bs;

  @override
  // TODO: implement props
  List<Object?> get props => [name,catchPhrase,bs];
}