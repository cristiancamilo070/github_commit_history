import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';

class GitHubProvider {
  Future<Response<List<GitHubCommitModel>?>> getCommits({
    required String owner,
    required String repo,
  }) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        'https://api.github.com/repos/$owner/$repo/commits',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<GitHubCommitModel> commits = data
            .map((commitData) => GitHubCommitModel.fromJson(commitData))
            .toList();

        final result = Response<List<GitHubCommitModel>?>(
          data: commits,
          statusCode: response.statusCode,
          headers: response.headers,
          requestOptions: response.requestOptions,
        );

        return result;
      } else {
        throw Exception('Failed to load commits');
      }
    } catch (error) {
      log('GitHub API ERROR: $error');
      rethrow;
    }
  }
}
