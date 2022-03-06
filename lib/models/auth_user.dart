class AuthUser {
  String? uid;
  String? name;
  int? phoneNumner;

  AuthUser(this.uid, this.name, this.phoneNumner);

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumner': phoneNumner,
    };
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      json['uid'],
      json['name'],
      json['phoneNumner'].toInt(),
    );
  }
}
