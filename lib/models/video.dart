library flx_common_package;

/// A list of videos
///
/// `videos` List<dynamic> a list of `video`
class VideoList {
  VideoList(this.videos);

  final List<dynamic> videos;

  VideoList.fromJson(Map<String, dynamic> json)
      : videos = json['how_to_videos'];
}

/// Video
///
/// `fileName` String
/// `fileUrl` String
/// `videoId` int
class Video {
  Video(this.fileName, this.fileUrl, this.videoId);

  final String fileName;
  final String fileUrl;
  final int videoId;

  Video.fromJson(Map<String, dynamic> json)
      : fileName = json['file_name'],
        fileUrl = json['file_url'],
        videoId = json['file_id'];
}