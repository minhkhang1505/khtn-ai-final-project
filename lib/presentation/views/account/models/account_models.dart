/// Models for the Account feature
class User {
  final String id;
  final String email;
  final String username;
  final List<String> roles;
  final Geo geo;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.roles,
    required this.geo,
  });
}

class Geo {
  final String lat;
  final String long;

  Geo({required this.lat, required this.long});
}

class PlanFeature {
  final String title;
  final String description;

  PlanFeature({required this.title, required this.description});

  // For backward compatibility with Map-based usage
  Map<String, String> toMap() => {'title': title, 'description': description};
}

class SubscriptionPlan {
  final String name;
  final String price;
  final String billingPeriod;
  final String subtitle;
  final List<PlanFeature> features;
  final bool isCurrent;

  SubscriptionPlan({
    required this.name,
    required this.price,
    required this.billingPeriod,
    required this.subtitle,
    required this.features,
    this.isCurrent = false,
  });
}
