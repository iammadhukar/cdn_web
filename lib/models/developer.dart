class Developer {
  String? id;
  String? userName;
  String? email;
  int? phone;
  String? skillSet;
  String? hobby;

  Developer(this.id, this.userName, this.email, this.phone, this.skillSet,
      this.hobby);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phone': phone,
      'skillSet': skillSet,
      'hobby': hobby,
    };
  }

  factory Developer.fromJson(Map<String, dynamic> json, String id) {
    return Developer(
      id,
      json['userName'],
      json['email'],
      json['phone']?.toInt(),
      json['skillSet'],
      json['hobby'],
    );
  }

  Developer.empty();
}
