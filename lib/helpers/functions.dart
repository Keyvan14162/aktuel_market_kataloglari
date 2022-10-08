class Functions {
  String convertDateToText(String date) {
    String myDate = "";
    String month = date.substring(3, 5);
    if (month == "01") {
      myDate = "${date.substring(0, 2)} Ocak";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "02") {
      myDate = "${date.substring(0, 2)} Şubat";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "03") {
      myDate = "${date.substring(0, 2)} Mart";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "04") {
      myDate = "${date.substring(0, 2)} Nisan";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "05") {
      myDate = "${date.substring(0, 2)} Mayıs";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "06") {
      myDate = "${date.substring(0, 2)} Haziran";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "07") {
      myDate = "${date.substring(0, 2)} Temmuz";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "08") {
      myDate = "${date.substring(0, 2)} Ağustos";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "09") {
      myDate = "${date.substring(0, 2)} Eylül";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "10") {
      myDate = "${date.substring(0, 2)} Ekim";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "11") {
      myDate = "${date.substring(0, 2)} Kasım";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    } else if (month == "12") {
      myDate = "${date.substring(0, 2)} Aralık";
      if (date.startsWith("0")) {
        myDate = myDate.substring(1, myDate.length);
      }
    }
    return myDate;
  }
}
