part of '../peach_collector.dart';

class PeachCollectorPublisher {
  final String siteKey;

  PeachCollectorPublisher({required this.siteKey});

  static Future<void> sendEventsToPublisherNamed({
    required String serviceUrl,
    required Map<String, dynamic> data,
  }) async {
    String jsonData = jsonEncode(data);

    try {
      await http.post(
        Uri.parse(serviceUrl),
        body: jsonData,
      );
    } catch (error) {
      log(
        name: 'Peach collector',
        'Something went wrong',
      );
    }
  }
}
