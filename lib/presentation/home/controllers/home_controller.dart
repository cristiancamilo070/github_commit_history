// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:get/get.dart';
import 'package:github_commit_history/core/controllers/base_getx_controller.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commits_use_case.dart';

class HomeController extends BaseGetxController {
  late final GetCommitsUseCase _getCommitsUseCase;

  final advancedDrawerController = AdvancedDrawerController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController repoController = TextEditingController();
  Rx<List<GitHubCommitModel>?> listOfCommits = Rx(null);

  @override
  void onInit() {
    _getCommitsUseCase = Get.find<GetCommitsUseCase>();
    super.onInit();

    getCommits(GetCommitsParams(
      'cristiancamilo070',
      'todo_list_app',
    ));
  }

  Future<void> getCommits(GetCommitsParams params) async {
    final result = await _getCommitsUseCase.execute(params);

    result.fold((l) {
      return false;
    }, (r) {
      showLoading();
      Get.back();
      showSuccessMessage("SEARCH_SUCCESS".tr, '');
      ownerController.clear();
      repoController.clear();
      listOfCommits.value = r;
      closeLoading();
      return true;
    });
  }
}
