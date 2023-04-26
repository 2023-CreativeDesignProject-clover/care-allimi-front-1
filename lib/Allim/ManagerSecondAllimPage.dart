import 'package:flutter/material.dart';
import '/Allim/EditAllimPage.dart';
import '/Supplementary/PageRouteWithAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../domain/NoticeDetail.dart';

//@@API <알림장 상세 목록>
//프론트에서 알림장의 id를 보내면
//백에서 작성자이름, 사진, 알림장 내용, 알림장 섭취내용?(전량섭취) 줘

class ManagerSecondAllimPage extends StatefulWidget {
  final int noticeId;
  ManagerSecondAllimPage({super.key, required this.noticeId}) {}

  @override
  State<ManagerSecondAllimPage> createState() =>
      _ManagerSecondAllimPageState(noticeId: this.noticeId);
}

class _ManagerSecondAllimPageState extends State<ManagerSecondAllimPage> {
  final int noticeId;
  _ManagerSecondAllimPageState({required this.noticeId}) {}

  late Future<NoticeDetail> futureNoticdDetail;

  @override
  void initState() {
    super.initState();
    futureNoticdDetail = fetchNoticeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('알림장 내용'),
      ),
      body: eachmanager(),
    );
  }

  //시설장 및 직원 알림장(각 목록)
  Widget eachmanager() {
    return FutureBuilder<NoticeDetail>(
        future: fetchNoticeDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!; // 불러온 더미 데이터
            return ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.test,
                                //snapshot.data!.userName,
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                  data.createDate,
                                //snapshot.data!.createDate,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            child: OutlinedButton(
                                onPressed: () async {
                                  //TODO: 수정 화면으로 넘어가기






                                },
                                child: Text('수정')),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            //alignment: Alignment.centerRight,
                            child: OutlinedButton(
                                onPressed: () {
                                  //삭제 화면으로 넘어가기
                                },
                                child: Text('삭제')),
                          ),
                        ],
                      ),
                    ),

                    //알림장 사진
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: double.infinity,
                        color: Colors.white,
                        height: 300,
                        child: Container(
                          child: Image.asset(
                            data.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        )),

                    //알림장 세부 내용
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        //snapshot.data!.content,
                        data.content,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    //알림장 안에 있는 어르신의 일일정보
                    informdata('${data.subContent}'),
                    //informdata(snapshot.data!.subContent) - 연동용
                  ],
                )
              ],
            );
          } else {
            return ListView();
          }
        });
  }

  //알림장 안에 있는 어르신의 일일정보 함수
  Widget informdata(String subContent) {
    //subContent는 전량섭취\n전량섭취\n전량섭취 꼴로 들어오게 해뒀어 -효림
    //\n으로 구분하는 코드
    List info = subContent.split('\n');
    print(info.toString());

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
      child: Column(
        children: [
          // inform('아침', '전량섭취'),
          inform('아침', info[0]),
          Divider(
            thickness: 0.5,
          ),
          inform('점심', info[1]),
          Divider(
            thickness: 0.5,
          ),
          inform('저녁', info[2]),
          Divider(
            thickness: 0.5,
          ),
          inform('투약', info[3]),
        ],
      ),
    );
  }

  Widget inform(String text1, String text2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 30),
          child: Text(
            '$text1',
            style: TextStyle(fontSize: 15, color: Colors.black38),
          ),
        ),
        Text(
          '$text2',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  Future<NoticeDetail> fetchNoticeDetail() async {
    // String url =
    //     'http://43.201.27.95:ㅁㄴㅇㄹ/v1/notices/detail/' + noticeId.toString();
    //
    // print(url);
    // final response =
    // await http.get(Uri.parse(url), headers: {'Accept-Charset': 'utf-8'});
    // final jsonResponse = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    //
    // if (response.statusCode == 202) {
    //   return NoticeDetail.fromJson(jsonResponse);
    // } else {
    //   print(noticeId.toString());
    //   throw Exception('Failed to load NoticeDetail');
    // }

    //TODO: 더미 데이터
    List<Map<String, dynamic>> dummyData = [
      {
        'noticeId': 1,
        'userId': 1,
        'test': '삼족오 보호자님',
        'create_date': '2022-04-26',
        'content': '안녕하세요! 이번 주말에는 서울에서 개최되는 대한민국 축구 대회에 참가하실 분들은 꼭 참고하세요!',
        'subContent': '전량섭취\n전량섭취\n전량섭취\n아침',
        'image_url': 'assets/images/cake.jpg'
      },
      {
        'noticeId': 2,
        'userId': 1,
        'test': '스쿨존 보호자님',
        'create_date': '2022-05-01',
        'content': '오늘은 교통안전 교육을 진행합니다.',
        'subContent': '전량섭취\nㅋㅋㅋㅋ\n전량섭취\n아침에만',
        'image_url': 'assets/images/cake.jpg'
      },
      {
        'noticeId': 3,
        'userId': 1,
        'test': '동네 친구들 보호자님',
        'create_date': '2022-05-10',
        'content': '어린이집 미술교육 결과물을 전달합니다.',
        'subContent': '전량섭취\n어쩔방구\n전량섭취\n아침에만',
        'image_url': 'assets/images/cake.jpg'
      },
    ];

    List<NoticeDetail> dummyDetails = dummyData.map((data) => NoticeDetail.fromJson(data)).toList();
    //await Future.delayed(Duration(seconds: 1));

    return dummyDetails.firstWhere((detail) => detail.noticeId == noticeId);

  }
}