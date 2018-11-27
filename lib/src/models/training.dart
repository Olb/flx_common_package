import 'video.dart';
import 'document.dart';
import 'coupon.dart';

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
      this.instructionVideos, this.productVideos, this.coupons, this.documents);

  final int productId;
  final String name;
  final String description;
  final String featuredImage;
  final List<Document> documents;
  final List<Coupon> coupons;
  final List<Video> productVideos;
  final List<Video> instructionVideos;

  Training.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        name = json['name'],
        description = json['description'],
        featuredImage = json['featured_image'],
        documents = (json['documents'] as List).map((documentJson) => Document.fromJson(documentJson)).toList(),
        coupons = (json['coupons'] as List).map((couponJson) => Coupon.fromJson(couponJson)).toList(),
        productVideos = (json['featured_videos'] as List).map((videoJson) => Video.fromJson(videoJson)).toList(),
        instructionVideos = (json['how_to_videos'] as List).map((videoJson) => Video.fromJson(videoJson)).toList();
}
