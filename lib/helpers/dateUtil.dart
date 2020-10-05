class DateUtil{
  DateTime convertData(String s){
    var split = s.split('/');
    DateTime data = DateTime.parse(split[2] + '-' + split[1] + '-' + split[0]);

    return data;
  }

  bool verifyYears(DateTime data){
    DateTime now = DateTime.now();
    if(now.year - data.year > 12){
      return true;
    } else {
      return false;
    }
  }
}