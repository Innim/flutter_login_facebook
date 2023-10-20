typedef JsonData = Map<String, Object?>;
typedef JsonRawData = Map<Object?, Object?>;

extension ObjectExtension on Object {
  JsonData castJsonData() => (this as JsonRawData).cast<String, Object?>();
}
