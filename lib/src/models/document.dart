/// A list of documents
///
/// `documents` List<dynamic> a list of documents
class Documents {
  Documents(this.documents);

  final List<dynamic> documents;

  Documents.fromJson(Map<String, dynamic> json)
      : documents = json['documents'];
}

/// Document
///
/// `name` String
/// `url` String
/// `id` int
class Document {
  Document(this.name, this.url, this.id);

  final String name;
  final String url;
  final int id;

  Document.fromJson(Map<String, dynamic> json)
      : name = json['file_name'],
        url = json['file_url'],
        id = json['"file_id"'];
}