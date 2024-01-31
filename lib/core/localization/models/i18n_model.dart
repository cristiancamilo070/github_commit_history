class I18nModel {
  String? name;
  String? code;
  Map<String, String>? texts;

  I18nModel({
    this.name,
    this.code,
    this.texts,
  });

  I18nModel.fromJson(Map<String, dynamic> json, String this.code) {
    texts = Map<String, String>.from(json);
  }
}
