
class Event {
  final int id;
  final DateTime time;
  final String header;
  final String address;
  final String userame;
  String? profileImageUrl;

  Event(
      this.id,
      this.time,
      this.header,
      this.userame,
      this.address,
      this.profileImageUrl
      );

  setProfileImageUrl(String url) {
    profileImageUrl = url;
  }


}
