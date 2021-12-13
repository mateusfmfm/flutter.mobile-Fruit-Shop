import 'package:cloud_firestore/cloud_firestore.dart';

class DateFormatUtil {
  transformTimeStampToDate(Timestamp timestamp) {
    var day = timestamp.toDate().day;
    var month = timestamp.toDate().month;
    var year = timestamp.toDate().year;

    String completeDate = day.toString() + " de " + getShortMonth(month) + " de " + year.toString();

    return completeDate;
  }

  getShortMonth(int month) {
    switch (month) {
      case 1:
        return "Janeiro";

      case 2:
        return "Fevereiro";

      case 3:
        return "Março";

      case 4:
        return "Abril";

      case 5:
        return "Maio";

      case 6:
        return "Junho";

      case 7:
        return "Julio";

      case 8:
        return "Agosto";

      case 9:
        return "Setembro";

      case 10:
        return "Outubro";

      case 11:
        return "Novembro";

      case 12:
        return "Dezembro";
    }
  }
}
