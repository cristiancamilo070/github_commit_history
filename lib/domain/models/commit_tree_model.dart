class CommitTreeModel {
  final String sha;
  final String url;
  final List<CommitTreeNodeModel> tree;
  final bool truncated;

  CommitTreeModel({
    required this.sha,
    required this.url,
    required this.tree,
    required this.truncated,
  });

  factory CommitTreeModel.fromJson(Map<String, dynamic> json) {
    return CommitTreeModel(
      sha: json['sha'] ?? '',
      url: json['url'] ?? '',
      tree: (json['tree'] as List<dynamic>?)
              ?.map((node) => CommitTreeNodeModel.fromJson(node))
              .toList() ??
          [],
      truncated: json['truncated'] ?? false,
    );
  }
}

class CommitTreeNodeModel {
  final String path;
  final String mode;
  final String type;
  final String sha;
  final int size;
  final String url;

  CommitTreeNodeModel({
    required this.path,
    required this.mode,
    required this.type,
    required this.sha,
    required this.size,
    required this.url,
  });

  factory CommitTreeNodeModel.fromJson(Map<String, dynamic> json) {
    return CommitTreeNodeModel(
      path: json['path'] ?? '',
      mode: json['mode'] ?? '',
      type: json['type'] ?? '',
      sha: json['sha'] ?? '',
      size: json['size'] ?? 0,
      url: json['url'] ?? '',
    );
  }
}
