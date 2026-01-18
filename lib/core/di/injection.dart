// lib/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/core/di/injection.config.dart';
// File này sẽ được tự động sinh ra

final GetIt sl = GetIt.instance; // sl = Service Locator

@InjectableInit(
  initializerName: 'init', // tên hàm khởi tạo mặc định
  preferRelativeImports: true, // dùng import tương đối cho gọn
  asExtension: true, // dùng extension method
)
Future<void> configureDependencies() => sl.init();
