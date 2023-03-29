//ex

class UserModel {
  int? id;
  String? name;

  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
  }
}
