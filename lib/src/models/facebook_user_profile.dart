import 'types.dart';

/// Facebook user profile.
class FacebookUserProfile {
  final String userId;
  final String? name;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;

  FacebookUserProfile.fromMap(JsonData map)
      : userId = map['userId'] as String,
        name = map['name'] as String?,
        firstName = map['firstName'] as String?,
        middleName = map['middleName'] as String?,
        lastName = map['lastName'] as String?,
        gender = map['user_gender'] as String?;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'user_gender': gender
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
          lastName == other.lastName &&
          gender == other.gender;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode ^
      gender.hashCode;

  @override
  String toString() {
    return 'FacebookUserProfile(userId: $userId, name: $name, '
        'firstName: $firstName, middleName: $middleName, lastName: $lastName)';
  }
}
