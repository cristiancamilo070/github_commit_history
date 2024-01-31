import 'package:dartz/dartz.dart';
import 'package:github_commit_history/domain/exceptions/base_exception.dart';
import 'package:github_commit_history/domain/models/commit_tree_model.dart';
import 'package:github_commit_history/domain/repositories/github_repository.dart';
import 'package:github_commit_history/domain/use_cases/base_use_cases.dart';

class GetCommitTreeUseCase
    extends BaseUseCases<CommitTreeModel?, GetCommitTreeParams> {
  final GithubRepository _githubRepository;

  GetCommitTreeUseCase(this._githubRepository);

  @override
  Future<Either<BaseException, CommitTreeModel?>> execute(
      GetCommitTreeParams params) async {
    return _githubRepository.getCommitTree(url: params.url);
  }
}

class GetCommitTreeParams {
  final String url;

  GetCommitTreeParams(
    this.url,
  );
}
