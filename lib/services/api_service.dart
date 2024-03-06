import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotto/models/lotto.dart';

class ApiService {
  final String lottoApiUrl =
      "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=";

  Future<LottoModel> getToDateNo() async {
    // 시작 날짜 2024년 3월 2일 1109회 / 매주 토요일 오후8시 35분 추첨
    DateTime startDate = DateTime(2024, 3, 2, 20, 40);

    // 현재 날짜 및 시간
    DateTime currentDate = DateTime.now();

    // 일주일은 7일이며, 1일은 24시간 * 60분 = 1440분입니다. 따라서 일주일은 총 7 * 1440 = 10080분
    // 현재시간과 시작일의 차이를 분으로 나눠 몫을 회차에 더해준다
    int additionalValue =
        (currentDate.difference(startDate).inMinutes / 10080).floor();
    int drwNo = 1109 + additionalValue;

    final url = Uri.parse("$lottoApiUrl$drwNo");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic jsonBody = jsonDecode(response.body);
      return LottoModel.fromJson(jsonBody);
    }
    throw Error();
  }
}
