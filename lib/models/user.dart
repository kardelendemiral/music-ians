import 'package:musicians/mockData.dart';

/// This model is for logging the logged in
/// user info.
class User {
  /// Token comes from the API. A different string for
  /// every login.
  final int id;
  final String token;
  final String email;
  /// 1 for Doctor, 2 for Member
  final int usertype;

  final int userid;

  String? profileImageUrl;

  String? dateOfBirth;

  String username;

  String genre;

  final String stageName;
  String eventAddress;


  String? documentUrl;

  User(
      this.id,
      this.token,
      this.email,
      this.usertype,
      {
        this.userid = -1,
        this.username = "",
        this.stageName = "",
        this.eventAddress = "",
        this.genre = "",
      }
      );
}