import 'video.dart';

/// A list of Training items
///
/// Contains a list of `Training` items
class TrainingList {
  TrainingList(this.trainingList);

  final List<Training> trainingList;

  TrainingList.fromJson(Map<String, dynamic> json)
      : trainingList = (json['products'] as List)
      .map((trainingJson) => Training.fromJson(trainingJson))
      .toList();
}

/// Training item
///
/// `productId` int
/// `name` String
/// `description` String
/// `featuredImage` String
/// `videoList` List<Video> a list of training videos
class Training {
  Training(this.productId, this.name, this.description, this.featuredImage,
      this.videoList);

  final int productId;
  final String name;
  final String description;
  final String featuredImage;
  final List<Video> videoList;

  Training.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        name = json['name'],
        description = json['description'],
        featuredImage = json['featured_image'],
        videoList = (json['videos'] as List).map((videoJson) => Video.fromJson(videoJson)).toList();
}
