import 'dart:convert';

class GitHubCommitModel {
  final String sha;
  final String nodeId;
  final CommitModel commit;
  final String url;
  final String htmlUrl;
  final String commentsUrl;
  final AuthorModel author;
  final AuthorModel committer;
  final List<CommitParentModel> parents;

  GitHubCommitModel({
    required this.sha,
    required this.nodeId,
    required this.commit,
    required this.url,
    required this.htmlUrl,
    required this.commentsUrl,
    required this.author,
    required this.committer,
    required this.parents,
  });

  factory GitHubCommitModel.fromJson(Map<String, dynamic> json) {
    return GitHubCommitModel(
      sha: json['sha'] ?? '',
      nodeId: json['node_id'] ?? '',
      commit: CommitModel.fromJson(json['commit'] ?? {}),
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      commentsUrl: json['comments_url'] ?? '',
      author: AuthorModel.fromJson(json['author'] ?? {}),
      committer: AuthorModel.fromJson(json['committer'] ?? {}),
      parents: List<CommitParentModel>.from(
        (json['parents'] ?? []).map(
          (parent) => CommitParentModel.fromJson(parent),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'sha': sha,
      'nodeId': nodeId,
      'commit': commit.toMap(),
      'url': url,
      'htmlUrl': htmlUrl,
      'commentsUrl': commentsUrl,
      'author': author.toMap(),
      'committer': committer.toMap(),
      'parents': parents.map((parent) => parent.toMap()).toList(),
    };
  }
}

class CommitModel {
  final AuthorModel author;
  final AuthorModel committer;
  final String message;
  final TreeModel tree;
  final String url;
  final int commentCount;
  final VerificationModel verification;

  CommitModel({
    required this.author,
    required this.committer,
    required this.message,
    required this.tree,
    required this.url,
    required this.commentCount,
    required this.verification,
  });

  factory CommitModel.fromJson(Map<String, dynamic> json) {
    return CommitModel(
      author: AuthorModel.fromJson(json['author'] ?? {}),
      committer: AuthorModel.fromJson(json['committer'] ?? {}),
      message: json['message'] ?? '',
      tree: TreeModel.fromJson(json['tree'] ?? {}),
      url: json['url'] ?? '',
      commentCount: json['comment_count'] ?? 0,
      verification: VerificationModel.fromJson(json['verification'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author.toMap(),
      'committer': committer.toMap(),
      'message': message,
      'tree': tree.toMap(),
      'url': url,
      'commentCount': commentCount,
      'verification': verification.toMap(),
    };
  }
}

class AuthorModel {
  final String name;
  final String email;
  final String date;

  AuthorModel({
    required this.name,
    required this.email,
    required this.date,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'date': date,
    };
  }
}

class TreeModel {
  final String sha;
  final String url;

  TreeModel({
    required this.sha,
    required this.url,
  });

  factory TreeModel.fromJson(Map<String, dynamic> json) {
    return TreeModel(
      sha: json['sha'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sha': sha,
      'url': url,
    };
  }
}

class VerificationModel {
  final bool verified;
  final String reason;
  final String signature;
  final String payload;

  VerificationModel({
    required this.verified,
    required this.reason,
    required this.signature,
    required this.payload,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      verified: json['verified'] ?? false,
      reason: json['reason'] ?? '',
      signature: json['signature'] ?? '',
      payload: json['payload'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'verified': verified,
      'reason': reason,
      'signature': signature,
      'payload': payload,
    };
  }
}

class CommitParentModel {
  final String sha;
  final String url;
  final String htmlUrl;

  CommitParentModel({
    required this.sha,
    required this.url,
    required this.htmlUrl,
  });

  factory CommitParentModel.fromJson(Map<String, dynamic> json) {
    return CommitParentModel(
      sha: json['sha'] ?? '',
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sha': sha,
      'url': url,
      'htmlUrl': htmlUrl,
    };
  }
}
