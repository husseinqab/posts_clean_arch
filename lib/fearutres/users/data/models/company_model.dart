import 'package:posts_clean_arch/fearutres/users/domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel(
      {required super.name, required super.catchPhrase, required super.bs});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
