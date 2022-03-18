class Subject {
  final String subCode;
  final String subject;

  Subject({required this.subject, required this.subCode});

  @override
  String toString() {
    return 'Subject{subCode: $subCode, subject: $subject}';
  }
}
