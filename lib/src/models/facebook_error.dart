/// Error object from Facebook.
///
/// See https://developers.facebook.com/docs/ios/errors/.
class FacebookError {
  /// An error message for the developer.
  final String developerMessage;

  /// A localized user facing message, if available
  final String localizedDescription;

  /// A localized user facing title, if available
  final String localizedTitle;

  FacebookError(
      {this.developerMessage, this.localizedDescription, this.localizedTitle});

  factory FacebookError.fromMap(Map<String, dynamic> map) => FacebookError(
      developerMessage: map['developerMessage'],
      localizedDescription: map['localizedDescription'],
      localizedTitle: map['localizedTitle']);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'developerMessage': developerMessage,
      'localizedDescription': localizedDescription,
      'localizedTitle': localizedTitle,
    };
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FacebookError &&
        o.developerMessage == developerMessage &&
        o.localizedDescription == localizedDescription &&
        o.localizedTitle == localizedTitle;
  }

  @override
  int get hashCode =>
      developerMessage.hashCode ^
      localizedDescription.hashCode ^
      localizedTitle.hashCode;

  @override
  String toString() => 'FacebookError(developerMessage: $developerMessage, '
      'localizedDescription: $localizedDescription, localizedTitle: $localizedTitle)';
}
