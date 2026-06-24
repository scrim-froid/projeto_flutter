class UserModel {
  final String uid;
  final String email;
  final String nome;
  final String bio;
  final bool isAuthor;

  UserModel({
    required this.uid,
    required this.email,
    required this.nome,
    required this.bio,
    required this.isAuthor,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'nome': nome,
      'bio': bio,
      'isAuthor': isAuthor,
    };
  }

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      nome: json['nome'] ?? '',
      bio: json['bio'] ?? '',
      isAuthor: json['isAuthor'] ?? false,
    );
  }

  UserModel copyWith({
    String? nome,
    String? bio,
    bool? isAuthor,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      nome: nome ?? this.nome,
      bio: bio ?? this.bio,
      isAuthor: isAuthor ?? this.isAuthor,
    );
  }
}
