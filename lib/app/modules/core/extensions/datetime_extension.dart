extension DateTimeExtension on DateTime {
String get toResouceFormatString => toString().replaceAll(".000", "").replaceAll(" ", "T");
}
