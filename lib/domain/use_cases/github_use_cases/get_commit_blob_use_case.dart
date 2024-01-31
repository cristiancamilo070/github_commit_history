import 'package:dartz/dartz.dart';
import 'package:github_commit_history/domain/exceptions/base_exception.dart';
import 'package:github_commit_history/domain/models/commit_blob_model.dart';
import 'package:github_commit_history/domain/repositories/github_repository.dart';
import 'package:github_commit_history/domain/use_cases/base_use_cases.dart';

class GetCommitBlobUseCase
    extends BaseUseCases<CommitBlobModel?, GetCommitBlobParams> {
  final GithubRepository _githubRepository;

  GetCommitBlobUseCase(this._githubRepository);

  @override
  Future<Either<BaseException, CommitBlobModel?>> execute(
      GetCommitBlobParams params) async {
    return _githubRepository.getCommitBlob(url: params.url);
  }
}

class GetCommitBlobParams {
  final String url;

  GetCommitBlobParams(
    this.url,
  );
}
