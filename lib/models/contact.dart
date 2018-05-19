class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String thumbnailUrl;
  final String email;
  final String phone;
  final String avatarUrl;

  Contact(
    this.id,
    this.firstName,
    this.lastName,
    this.thumbnailUrl,
    { this.email,
      this.phone,
      this.avatarUrl }
  );
}