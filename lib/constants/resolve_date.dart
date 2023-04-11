String toRevolveDate(String dateTime) {
  List<String> splitList = dateTime.split('.');
  if (splitList.length <= 1) return '---';
  if (splitList[0].startsWith("0")) {
    splitList[0] = splitList[0].replaceFirst(RegExp("0"), "");
  }
  String month = splitList[1];
  String changeMonth = "";
  switch (month) {
    case "01":
      changeMonth = "Ocak";
      break;
    case "02":
      changeMonth = "Şubat";
      break;
    case "03":
      changeMonth = "Mart";
      break;
    case "04":
      changeMonth = "Nisan";
      break;
    case "05":
      changeMonth = "Mayıs";
      break;
    case "06":
      changeMonth = "Haziran";
      break;
    case "07":
      changeMonth = "Temmuz";
      break;
    case "08":
      changeMonth = "Ağustos";
      break;
    case "09":
      changeMonth = "Eylül";
      break;
    case "10":
      changeMonth = "Ekim";
      break;
    case "11":
      changeMonth = "Kasım";
      break;
    case "12":
      changeMonth = "Aralık";
      break;
    default:
  }

  return "${splitList[0]} $changeMonth";
}
