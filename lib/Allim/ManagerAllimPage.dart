import 'package:flutter/material.dart';
import '/Allim/WriteAllimPage.dart';
import '/Supplementary/PageRouteWithAnimation.dart';
import 'ManagerSecondAllimPage.dart';
import '/NoticeModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';



class ManagerAllimPage extends StatefulWidget {
  @override
  ManagerAllimPageState createState() {
    return ManagerAllimPageState();
  }
}

class ManagerAllimPageState extends State<ManagerAllimPage> {
  //late Map<String, dynamic> _notices;
  List<Map<String, dynamic>> _notices = []; // 수정된 부분



  @override
  void initState() {
    super.initState();
    _fetchNotices();
  }

  Future<void> _fetchNotices() async {
    // final response = await http.get(
    //     Uri.parse('http://43.201.27.95:8080/v1/notices/1'),
    //     headers: {'Accept-Charset': 'utf-8'});
    List<Map<String, dynamic>> allimList = [
      {
        'noticeId': 1,
        'protect': '삼족오 보호자님',
        'create_date': '2023-04-25',
        'content': '안녕하세용',
        'imageUrl': 'assets/images/tree.jpg'
      },
      {
        'noticeId': 2,
        'protect': '스쿨존 보호자님',
        'create_date': '2023-04-26',
        'content': '오늘은 교통안전 교육을 진행합니다.',
        'imageUrl': 'assets/images/cake.jpg'
      },
      {
        'noticeId': 3,
        'protect': '동네 친구들 보호자님',
        'create_date': '2023-04-27',
        'content': '어린이집 미술교육 결과물을 전달합니다.',
        'imageUrl': 'assets/images/cake.jpg'
      },
    ];
    String jsonString = json.encode(allimList);
    dynamic decodedJson = json.decode(jsonString);
    List<Map<String, dynamic>> parsedJson = List<Map<String, dynamic>>.from(decodedJson);
    //final data = json.decode(utf8.decode(response.bodyBytes));

    setState(() {
      _notices = parsedJson;
    });
  }

  static List<String> noticeWho = [
    '삼족오 보호자님',
    '사족오 보호자님',
    '오족오 보호자님',
    '육족오 보호자님',
    '칠족오 보호자님'
  ];
  static List<String> noticeDate = [
    '2023.03.20',
    '2023.03.21',
    '2023.03.22',
    '2023.03.23',
    '2023.03.24'
  ];
  static List<String> noticeDetail = [
    '오늘은 날씨가 좋아서 걷기 운동을 하였습니다.',
    '오늘은 미세먼지가 많아서 걷기 운동을 안 하려고 하였으나 많은 분들이 걷기를 원하셔서 간단하게 걸어보았습니다.오늘은 미세먼지가 많아서 걷기 운동을 안 하려고 하였으나 많은 분들이 걷기를 원하셔서 간단하게 걸어보았습니다.오늘은 미세먼지가 많아서 걷기 운동을 안 하려고 하였으나 많은 분들이 걷기를 원하셔서 간단하게 걸어보았습니다.',
    '오늘은 요양원 행사를 하였습니다. 무슨 행사인지 아시나요? 바로 초콜릿 만들기랍니다.',
    '오늘도 요양원 행사를 하였습니다. 어제 만든 초콜릿이 너무 맛있어서 이 초콜릿으로 케이크를 만들었답니다.',
    '어제 너무 많이 먹어서 산책을 하였습니다.'
  ];
  static List<String> noticeimgPath = [
    'assets/images/tree.jpg',
    'assets/images/tree.jpg',
    'assets/images/cake.jpg',
    'assets/images/cake.jpg',
    'assets/images/tree.jpg'
  ];

  final List<Notice> noticeData = List.generate(
      noticeDetail.length,
      (index) =>
          Notice(noticeDate[index], noticeDetail[index], noticeimgPath[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림장'),
      ),
      body: managerlist(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //글쓰기 화면으로 이동
          pageAnimation(context, WriteAllimPage());
        },
        child: const Icon(Icons.create),
      ),
    );
  }

//시설장 및 직원 알림장 목록
  Container managerlist() {
    return Container(
      //padding: EdgeInsets.all(10),
      child: ListView.separated(
        itemCount: _notices.length,

        shrinkWrap: true,
        itemBuilder: (context, index) {
          final parsedJson = _notices[index];

          return InkWell(
              onTap: () {
                pageAnimation(
                    context,
                    ManagerSecondAllimPage(
                        noticeId: _notices[index]['noticeId'] //TODO: 변경하기
                    )
                );
                print(index);
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    width: double.infinity,
                    height: 130,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //어떤 보호자에게 썼는지
                              Container(
                                child: Text(
                                  parsedJson['protect'],
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              //언제 썼는지
                              Container(
                                child: Text(
                                  parsedJson['create_date'],
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                  //noticeData[index].date, //더미
                                ),
                              ),
                              Spacer(),
                              //세부내용(너무 길면 ...로 표시)
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                                  child: Text(
                                    parsedJson['content'],
                                    // json.decode(jsonString)['content'],
                                    //noticeData[index].detail,  //더미
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  )),
                              Spacer(),
                            ],
                          ),
                        ),
                        //이미지
                        Container(
                            width: 100,
                            height: 100,
                            child: Container(
                              child: Image.asset(
                                parsedJson['imageUrl'],
                                // json.decode(jsonString)['imageUrl'],
                                fit: BoxFit.fill,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 9,
          color: Color(0xfff8f8f8),
        ), //구분선(height로 상자 사이 간격을 조절)
      ),
    );
  }
}
