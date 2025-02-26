class PageModel {
  String name;
  String lastUpdatedAtStaticText;
  String? noticeText;
  String headText;
  String bodyText;
  String? image;
  String? realUpdatedAtText;

  PageModel(
      {required this.name,
      required this.lastUpdatedAtStaticText,
      required this.noticeText,
      required this.bodyText,
      required this.headText,
      this.image,
      this.realUpdatedAtText});

  factory PageModel.fromJson(json, int pageId) {
    return PageModel(
      name: json['data'][pageId]['name'],
      lastUpdatedAtStaticText: json['data'][pageId]['last_updated_at'],
      noticeText: json['data'][pageId]['notice_text'],
      bodyText: json['data'][pageId]['body_text'],
      headText: json['data'][pageId]['head_text'],
      image: json['data'][pageId]['image'],
      realUpdatedAtText: json['data'][pageId]['updated_at'],
    );
  }
}
