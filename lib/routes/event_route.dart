/// 事件数据交换通道

class EventRoute{
  static const String eventRootPath='/event';
  static const String eventListPath='$eventRootPath/getEventList';
  static const String eventCreatePath='$eventRootPath/createEvent';
  static const String eventDeletePath='$eventRootPath/deleteEvent';
  static const String eventAcceptPath='$eventRootPath/acceptEvent';
  static const String eventAcceptedPath='$eventRootPath/getAcceptedList';
  static const String eventPublishedPath='$eventRootPath/getPublishedList';
  static const String eventReportPath='$eventRootPath/updateEvent';
}