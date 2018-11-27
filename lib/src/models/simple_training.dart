import 'video.dart';

/// A list of Training items
///
/// Contains a list of `Training` items
class SimpleTrainingList {
  SimpleTrainingList(this.trainingList);

  final List<SimpleTraining> trainingList;

  SimpleTrainingList.fromJson(Map<String, dynamic> json)
      : trainingList = (json['products'] as List)
      .map((trainingJson) => SimpleTraining.fromJson(trainingJson))
      .toList();
}

/// Training item
///
/// `productId` int
/// `name` String
/// `description` String
/// `featuredImage` String
/// `videoList` List<Video> a list of training videos
class SimpleTraining {
  SimpleTraining(this.productId, this.name, this.description, this.featuredImage,
      this.videoList);

  final int productId;
  final String name;
  final String description;
  final String featuredImage;
  final List<Video> videoList;

  SimpleTraining.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        name = json['name'],
        description = json['description'],
        featuredImage = json['featured_image'],
        videoList = (json['videos'] as List).map((videoJson) => Video.fromJson(videoJson)).toList();
}
