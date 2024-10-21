class RegisterResponse {
  bool? isSuccess;

  RegisterResponse({this.isSuccess});

  RegisterResponse.fromJson(Map<String,dynamic>json){
    isSuccess = json['isSuccess'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['isSuccess'] = this.isSuccess;
    return data;
  }

}

class register {
  String? Username;
  String? Password;
  String? Email;

  register(
      {this.Username,
        this.Password,
        this.Email});

  register.fromJson(Map<String, dynamic> json) {
    Username = json['Username'];
    Password = json['Password'];
    Email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = this.Username;
    data['Password'] = this.Password;
    data['Email'] = this.Email;
    return data;
  }
}
