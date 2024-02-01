// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:github_commit_history/core/controllers/base_getx_controller.dart';
import 'package:github_commit_history/core/widgets/forms/github_repo_form.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commit_blob_use_case.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commit_tree_use_case.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commits_use_case.dart';
import 'package:github_commit_history/presentation/home/pages/commit_blob_page.dart';
import 'package:github_commit_history/presentation/home/pages/commit_details_page.dart';
import 'package:github_commit_history/core/widgets/animations/loading_page.dart';

class HomeController extends BaseGetxController {
  late final GetCommitsUseCase _getCommitsUseCase;
  late final GetCommitBlobUseCase _commitBlobUseCase;
  late final GetCommitTreeUseCase _commitTreeUseCase;

  final advancedDrawerController = AdvancedDrawerController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController repoController = TextEditingController();

  Rx<List<GitHubCommitModel>?> listOfCommits = Rx(null);
  RxString ownerTitle = 'cristiancamilo070'.obs;
  RxString repoTitle = 'github_commit_history'.obs;

  @override
  void onInit() {
    _getCommitsUseCase = Get.find<GetCommitsUseCase>();
    _commitBlobUseCase = Get.find<GetCommitBlobUseCase>();
    _commitTreeUseCase = Get.find<GetCommitTreeUseCase>();

    super.onInit();
    ownerController.text = ownerTitle.value;
    repoController.text = repoTitle.value;
    getCommits(GetCommitsParams(
      ownerTitle.value,
      repoTitle.value,
    ));
  }

  Future<void> getCommits(GetCommitsParams params) async {
    final result = await _getCommitsUseCase.execute(params);

    result.fold((l) {
      return false;
    }, (r) {
      showLoading();
      Get.back();
      showSuccessMessage(
        "SUCCESS".tr,
        "SEARCH_SUCCESS".tr,
      );
      ownerTitle.value = ownerController.text;
      repoTitle.value = repoController.text;
      listOfCommits.value = r;
      closeLoading();
      return true;
    });
  }

  Future<void> getTreeCommit(
      {required GetCommitTreeParams params, required String title}) async {
    final result = await _commitTreeUseCase.execute(params);

    result.fold((l) {
      return false;
    }, (r) {
      showLoading();
      print(r!.tree.length);
      Get.to(() => const EmptyPage());

      Get.to(() => CommitDetailsPage(
            widgetTree: r,
            commitTitle: title,
            key: UniqueKey(),
          ));

      closeLoading();

      return true;
    });
  }

  Future<void> getBlobCommit(
      {required GetCommitBlobParams params, required String title}) async {
    final result = await _commitBlobUseCase.execute(params);

    result.fold((l) {
      return false;
    }, (r) {
      showLoading();

      Get.to(() => CommitBlobPage(
            widgetBlob: r,
            fileTitle: title,
            key: UniqueKey(),
          ));

      closeLoading();
      return true;
    });
  }

  Future<void> showBottomSheet([void Function()? cb]) async {
    await Get.bottomSheet(
      searchCommitsSheet(),
      elevation: 34,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );

    cb?.call();
  }

  Widget searchCommitsSheet() {
    return SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          height: 240.h,
          child: GitHubRepoForm(
            searchButton: () async {
              await getCommits(
                GetCommitsParams(
                  ownerController.text,
                  repoController.text,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
