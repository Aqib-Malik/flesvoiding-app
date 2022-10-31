class UserProfileModel {
  String? name;
  DateTime? birthDate;
  String? imageUrl;
  String? email;

  UserProfileModel({this.name, this.birthDate, this.imageUrl, this.email});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthDate = json['birthDate'];
    imageUrl = json['imageUrl'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['birthDate'] = this.birthDate;
    data['imageUrl'] = this.imageUrl;
    data['email'] = this.email;
    return data;
  }
}