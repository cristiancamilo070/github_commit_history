// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:github_commit_history/domain/models/commit_blob_model.dart';
import 'package:github_commit_history/domain/models/commit_tree_model.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';

class GitHubProvider {
  Dio dio = Dio();

  Future<Response<List<GitHubCommitModel>?>> getCommits({
    required String owner,
    required String repo,
  }) async {
    try {
      final response = await dio.get(
        'https://github-commit-history-backend.fly.dev/api/commits',
        //'http://localhost:3000/api/commits',
        queryParameters: {
          'owner': owner,
          'repo': repo,
        },
        // options: Options(//TODO IN CASE YOU EXCEEDED THE GITHUB API REQUEST LIMIT PUT YOUR TOKEN HERE
        //   headers: {
        //     'Accept': 'application/vnd.github.v3+json',
        //        'Authorization': 'Bearer @YOUR_TOKEN',
        //   },
        // ),
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
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } catch (error) {
      print('Error getCommits: $error');
      rethrow;
    }
  }

  Future<Response<CommitTreeModel?>> getCommitTree({
    required String url,
  }) async {
    try {
      final response = await dio.get(
        'https://github-commit-history-backend.fly.dev/api/commitTree',
        //'http://localhost:3000/api/commitTree',
        queryParameters: {
          'url': url,
        },
        // options: Options(//TODO IN CASE YOU EXCEEDED THE GITHUB API REQUEST LIMIT PUT YOUR TOKEN HERE
        //   headers: {
        //     'Accept': 'application/vnd.github.v3+json',
        //        'Authorization': 'Bearer @YOUR_TOKEN',
        //   },
        // ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final CommitTreeModel commitTree = CommitTreeModel.fromJson(data);

        final result = Response<CommitTreeModel?>(
          data: commitTree,
          statusCode: response.statusCode,
          headers: response.headers,
          requestOptions: response.requestOptions,
        );

        return result;
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } catch (error) {
      print('Error: getCommitTree $error');
      rethrow;
    }
  }

  Future<Response<CommitBlobModel?>> getCommitBlob({
    required String url,
  }) async {
    try {
      final response = await dio.get(
        'https://github-commit-history-backend.fly.dev/api/commitBlob',
        //'http://localhost:3000/api/commitBlob',
        queryParameters: {
          'url': url,
        },
        // options: Options(//TODO IN CASE YOU EXCEEDED THE GITHUB API REQUEST LIMIT PUT YOUR TOKEN HERE
        //   headers: {
        //     'Accept': 'application/vnd.github.v3+json',
        //        'Authorization': 'Bearer @YOUR_TOKEN',
        //   },
        // ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final CommitBlobModel commitBlob = CommitBlobModel.fromJson(data);

        final result = Response<CommitBlobModel?>(
          data: commitBlob,
          statusCode: response.statusCode,
          headers: response.headers,
          requestOptions: response.requestOptions,
        );

        return result;
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } catch (error) {
      print('Error getCommitBlob: $error');
      rethrow;
    }
  }
}
