class Login {
  String? name;
  String? mail;
  String? password;

  Login({this.name, this.mail, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['mail'] = mail;
    data['password'] = password;
    return data;
  }

  String toString() {
    return "Name: " + name! + " Mail: " + mail! + " Password: " + password!;
  }
  
}
