import 'package:khtn_ai_final_project/domain/entities/category.dart';

enum CategoryType {
  coding,
  career,
  business,
  education,
  marketing,
  writing,
  fun,
  chatbot,
  productivity,
  ceo,
  other,
}

final List<Category> categories = [
  Category(
    id: CategoryType.coding,
    name: "Coding",
    iconPath: "assets/icons/ic_coding.svg",
  ),
  Category(
    id: CategoryType.career,
    name: "Career",
    iconPath: "assets/icons/ic_career.svg",
  ),
  Category(
    id: CategoryType.business,
    name: "Business",
    iconPath: "assets/icons/ic_business.svg",
  ),
  Category(
    id: CategoryType.education,
    name: "Education",
    iconPath: "assets/icons/ic_education.svg",
  ),
  Category(
    id: CategoryType.marketing,
    name: "Marketing",
    iconPath: "assets/icons/ic_marketing.svg",
  ),
  Category(
    id: CategoryType.writing,
    name: "Writing",
    iconPath: "assets/icons/ic_writing.svg",
  ),
  Category(
    id: CategoryType.fun,
    name: "Fun",
    iconPath: "assets/icons/ic_fun.svg",
  ),
  Category(
    id: CategoryType.chatbot,
    name: "Chatbot",
    iconPath: "assets/icons/ic_bot.svg",
  ),
  Category(
    id: CategoryType.productivity,
    name: "Productivity",
    iconPath: "assets/icons/ic_productivity.svg",
  ),
  Category(
    id: CategoryType.ceo,
    name: "CEO",
    iconPath: "assets/icons/ic_ceo.svg",
  ),
  Category(
    id: CategoryType.other,
    name: "Other",
    iconPath: "assets/icons/ic_other.svg",
  ),
];
