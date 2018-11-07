/// A generic response from FLX server
///
/// message String the messaged returned from the server
class GenericResponse {
  final String message;

  GenericResponse.fromJson(Map<String, dynamic> json) : message = json['message'];
}