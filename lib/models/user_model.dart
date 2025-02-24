class UserModel {
  String message;
  String token;
  int id;
  String name;
  String email;
  String image;
  int role;
  String ? password; 

  UserModel({
    required this.message,
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.role,
    this.password
  });

  factory UserModel.fromJson(json , password) { 
    
    return UserModel(
        message: json['message'],
        token: json['token'],
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        image: json['user']['image'],
        role: json['user']['role'],
        password: password);
    

   
  }
}
