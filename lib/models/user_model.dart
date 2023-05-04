class UserModel {
  final String? name;
  final String? surName;
  final String? eMail;
  final String? password;

  UserModel(
    this.name,
    this.surName,
    this.eMail,
    this.password,
  );

  Map toMap() {
    return {
      'userName': name,
      'userSurname': surName,
      'userMail': eMail,
      'userPassword': password,
      'iot': {
        'IoT Switch 1': 'false',
        'IoT Switch 2': 'false',
        'IoT Switch 3': 'false',
        'IoT Switch 4': 'false',
        'IoT Switch 5': 'false',
      }
    };
  }
}
