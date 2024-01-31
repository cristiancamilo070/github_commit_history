import 'package:get/get.dart';
import 'package:github_commit_history/domain/repositories/github_repository.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commits_use_case.dart';
import 'package:github_commit_history/presentation/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());

    Get.lazyPut(
      () => GetCommitsUseCase(
        Get.find<GithubRepository>(),
      ),
    );
  }
}
