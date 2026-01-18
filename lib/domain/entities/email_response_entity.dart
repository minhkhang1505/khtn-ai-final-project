/// Entity đại diện cho Email Response trong domain layer
class EmailResponseEntity {
  final String email;
  final int remainingUsage;

  const EmailResponseEntity({
    required this.email,
    required this.remainingUsage,
  });

  bool get hasUsageRemaining => remainingUsage > 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailResponseEntity &&
          runtimeType == other.runtimeType &&
          email == other.email;

  @override
  int get hashCode => email.hashCode;
}
