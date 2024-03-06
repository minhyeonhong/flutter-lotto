class LottoModel {
  final String returnValue, drwNoDate;
  final int totSellamnt,
      firstWinamnt,
      firstPrzwnerCo,
      firstAccumamnt,
      drwNo,
      drwtNo1,
      drwtNo2,
      drwtNo3,
      drwtNo4,
      drwtNo5,
      drwtNo6,
      bnusNo;

  LottoModel.fromJson(dynamic json)
      : returnValue = json['returnValue'],
        drwNoDate = json['drwNoDate'],
        totSellamnt = json['totSellamnt'],
        firstWinamnt = json['firstWinamnt'],
        firstPrzwnerCo = json['firstPrzwnerCo'],
        firstAccumamnt = json['firstAccumamnt'],
        drwNo = json['drwNo'],
        drwtNo1 = json['drwtNo1'],
        drwtNo2 = json['drwtNo2'],
        drwtNo3 = json['drwtNo3'],
        drwtNo4 = json['drwtNo4'],
        drwtNo5 = json['drwtNo5'],
        drwtNo6 = json['drwtNo6'],
        bnusNo = json['bnusNo'];
}
