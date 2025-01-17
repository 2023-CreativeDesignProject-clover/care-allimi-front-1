class NoticeDetail {
  //  "noticeId": 4,
  // "create_date": "2023-04-10T17:11:10.185313",
  // "content": "오늘도 요양원 행사를 하였습니다. 어제 만든 초콜릿이 너무 맛있어서 이 초콜릿으로 케이크를 만들었답니다.",
  // "subContent: 전량섭취
  //이미지

  final int noticeId;
  final int userId;
  final String test;
  final String createDate;
  final String content;
  final String subContent;
  final String imageUrl;

  const NoticeDetail({
    required this.noticeId,
    required this.userId,
    required this.test,
    required this.createDate,
    required this.content,
    required this.subContent,
    required this.imageUrl,
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> json) {
    return NoticeDetail(
      noticeId: json['noticeId'],
      userId: json['userId'],
      test: json['test'], //삼족오 보호자님
      createDate: json['create_date'],
      content: json['content'],
      subContent: json['subContent'],
      imageUrl: json['image_url']
    );
  }
}
