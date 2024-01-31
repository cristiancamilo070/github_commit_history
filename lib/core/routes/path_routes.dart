import 'package:get/get.dart';
import 'package:github_commit_history/core/routes/app_routes.dart';
import 'package:github_commit_history/presentation/home/controllers/home_binding.dart';
import 'package:github_commit_history/presentation/home/pages/home_page.dart';
import 'package:github_commit_history/presentation/splash_page.dart';

/// The PagesManager class is responsible for managing the list of pages in a Dart application,
/// including their names, associated widgets, and bindings.
class PagesManager {
  PagesManager._();
  static final List<GetPage> pages = [
    GetPage(
      name: RoutesPaths.splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RoutesPaths.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
