import 'package:khtn_ai_final_project/data/models/user_models.dart';

/// Constants for the Account feature
const double avatarSize = 48.0;

// Subscription Plans Data
final freePlan = SubscriptionPlan(
  name: 'Free Plan',
  price: '\$0',
  billingPeriod: '/month',
  subtitle: 'Limited features',
  features: [],
  isCurrent: true,
);

final proPlan = SubscriptionPlan(
  name: 'Pro Plan',
  price: '\$19.00',
  billingPeriod: '/month',
  // Mock next billing date set 30 days from now
  nextBillingDate: DateTime.now().add(Duration(days: 30)),
  subtitle: 'Cancel anytime',
  features: [
    PlanFeature(
      title: 'Unlimited AI Chats',
      description: 'Chat as much as you want with no limits',
    ),
    PlanFeature(
      title: 'Custom AI Bots',
      description: 'Create unlimited custom bots for your needs',
    ),
    PlanFeature(
      title: 'Advanced Workflows',
      description: 'Access to all workflow templates and automation',
    ),
    PlanFeature(
      title: 'Priority Support',
      description: 'Get help faster with priority email support',
    ),
    PlanFeature(
      title: 'Early Access',
      description: 'Try new features before everyone else',
    ),
  ],
);

const appVersion = '1.0.0';
