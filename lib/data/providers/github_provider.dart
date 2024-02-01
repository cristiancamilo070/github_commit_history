// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:github_commit_history/domain/models/commit_blob_model.dart';
import 'package:github_commit_history/domain/models/commit_tree_model.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';

class GitHubProvider {
  Future<Response<List<GitHubCommitModel>?>> getCommits({
    required String owner,
    required String repo,
  }) async {
    try {
      Dio dio = Dio();
      print('https://api.github.com/repos/$owner/$repo/commits');
      final response = await dio.get(
        'https://api.github.com/repos/$owner/$repo/commits',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            //'Authorization': 'Bearer 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',
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

  Future<Response<CommitTreeModel?>> getCommitTree({
    required String url,
  }) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            //   'Authorization': 'Bearer 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',
          },
        ),
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
        throw Exception('Failed to load commit tree');
      }
    } catch (error) {
      log('GitHub API ERROR: $error');
      rethrow;
    }
  }

  Future<Response<CommitBlobModel?>> getCommitBlob({
    required String url,
  }) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            //        'Authorization': 'Bearer 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',
          },
        ),
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
        throw Exception('Failed to load commit blob');
      }
    } catch (error) {
      log('GitHub API ERROR: $error');
      rethrow;
    }
  }
}
