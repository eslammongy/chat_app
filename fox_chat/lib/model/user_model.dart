class UserModel {
  String name;
  String email;
  String phone;
  String uId;
  String bio;
  String image;
  String cover;
  String password;
  bool isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.bio,
    this.cover,
    this.password,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'password': password,
      'isEmailVerified': isEmailVerified,
    };
  }
}
