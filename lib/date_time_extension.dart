extension DateTimeExtension on DateTime {
  int compareDate(DateTime date) {
    if (year != date.year) {
      return year - date.year;
    }

    if (month != date.month) {
      return month - date.year;
    }

    return day - date.day;
  }

  String dateString({seperator = '/'}) {
    return "$year$seperator$month$seperator$day";
  }

  String timeOfDayString({seperator = ':'}) {
    return "${hour.toString().padLeft(2, "0")}$seperator${minute.toString().padLeft(2, "0")}";
  }
}