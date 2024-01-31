import 'package:dartz/dartz.dart';
import 'package:github_commit_history/domain/exceptions/base_exception.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';

abstract class GithubRepository {
  Future<Either<BaseException, List<GitHubCommitModel>?>> getCommits({
    required String owner,
    required String repo,
  });
}
