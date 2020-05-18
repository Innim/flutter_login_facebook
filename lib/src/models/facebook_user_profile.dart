/// Facebook user profile.
class FacebookUserProfile {
  final String userId;
  final String name;
  final String firstName;
  final String middleName;
  final String lastName;

  FacebookUserProfile.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        firstName = map['firstName'],
        middleName = map['middleName'],
        lastName = map['lastName'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacebookUserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          firstName == other.firstName &&
          middleName == other.middleName &&
          lastName == other.lastName;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode;

  @override
  String toString() {
    return 'FacebookUserProfile(userId: $userId, name: $name, '
        'firstName: $firstName, middleName: $middleName, lastName: $lastName)';
  }
}
