import 'package:get/get.dart';
import 'package:github_commit_history/core/controllers/main_controller.dart';
import 'package:github_commit_history/core/localization/repositories/localization_repository.dart';
import 'package:github_commit_history/data/providers/github_provider.dart';
import 'package:github_commit_history/data/repositories/github_repository_impl.dart';
import 'package:github_commit_history/data/repositories/security/secure_storage_repository_impl.dart';
import 'package:github_commit_history/data/repositories/security/shared_preference_repository_impl.dart';
import 'package:github_commit_history/domain/repositories/github_repository.dart';
import 'package:github_commit_history/domain/repositories/security/secure_storage_repository.dart';
import 'package:github_commit_history/domain/repositories/security/shared_preference_repository.dart';

class DependencyCreator {
  static initialize() {
    Get.put(GitHubProvider(), permanent: true);

    Get.put(LocalizationRepository(), permanent: true);

    Get.put<GithubRepository>(
      GitHubRepositoryImpl(Get.find<GitHubProvider>()),
      permanent: true,
    );

    Get.put<SecureStorageRepository>(
      SecureStorageRepositoryImpl(),
      permanent: true,
    );

    Get.put<SharedPreferencesRepository>(
      SharedPreferencesRepositoryImpl(),
      permanent: true,
    );

    Get.put(
      MainController(),
      permanent: true,
    );
  }
}
