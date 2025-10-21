

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/03/22

class UserDTO {//TODO: eliminar se reemplaza por entity
  final int userId;
  final String firstName;
  final String? lastName;
  final String phoneNumber;
  final String emailAddress;
  final String? profileImage;

  UserDTO(
      {required this.userId,
      required this.firstName,
      this.lastName,
      required this.phoneNumber,
      required this.emailAddress,
      this.profileImage});

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "profileImage": profileImage
      };
}
