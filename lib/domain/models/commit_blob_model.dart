class CommitBlobModel {
  final String sha;
  final String nodeId;
  final int size;
  final String url;
  final String content;
  final String encoding;

  CommitBlobModel({
    required this.sha,
    required this.nodeId,
    required this.size,
    required this.url,
    required this.content,
    required this.encoding,
  });

  factory CommitBlobModel.fromJson(Map<String, dynamic> json) {
    return CommitBlobModel(
      sha: json['sha'] ?? '',
      nodeId: json['node_id'] ?? '',
      size: json['size'] ?? 0,
      url: json['url'] ?? '',
      content: json['content'] ?? '',
      encoding: json['encoding'] ?? '',
    );
  }
}
