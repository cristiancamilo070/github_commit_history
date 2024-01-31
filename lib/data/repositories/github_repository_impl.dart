// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:github_commit_history/data/providers/github_provider.dart';
import 'package:github_commit_history/domain/exceptions/base_exception.dart';
import 'package:github_commit_history/domain/models/commit_blob_model.dart';
import 'package:github_commit_history/domain/models/commit_tree_model.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';
import 'package:github_commit_history/domain/repositories/github_repository.dart';

class GitHubRepositoryImpl extends GithubRepository {
  final GitHubProvider gitHubProvider;

  GitHubRepositoryImpl(this.gitHubProvider);

  @override
  Future<Either<BaseException, List<GitHubCommitModel>?>> getCommits(
      {required String owner, required String repo}) async {
    try {
      final result = await gitHubProvider.getCommits(
        owner: owner,
        repo: repo,
      );

      return right(result.data);
    } catch (e) {
      return left(const BaseException(
        'Error',
        success: false,
        code: null,
        message: '',
      ));
    }
  }

  @override
  Future<Either<BaseException, CommitTreeModel?>> getCommitTree(
      {required String url}) async {
    try {
      final result = await gitHubProvider.getCommitTree(
        url: url,
      );

      return right(result.data);
    } catch (e) {
      return left(const BaseException(
        'Error',
        success: false,
        code: null,
        message: '',
      ));
    }
  }

  @override
  Future<Either<BaseException, CommitBlobModel?>> getCommitBlob(
      {required String url}) async {
    try {
      final result = await gitHubProvider.getCommitBlob(
        url: url,
      );

      return right(result.data);
    } catch (e) {
      return left(const BaseException(
        'Error',
        success: false,
        code: null,
        message: '',
      ));
    }
  }
}
