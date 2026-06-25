enum SubmissionStatus { pending, approved, rejected }

class SpotSubmission {
  const SpotSubmission({
    required this.id,
    required this.name,
    required this.cityId,
    required this.description,
    required this.submittedAt,
    this.status = SubmissionStatus.pending,
  });

  final String id;
  final String name;
  final String cityId;
  final String description;
  final DateTime submittedAt;
  final SubmissionStatus status;
}
