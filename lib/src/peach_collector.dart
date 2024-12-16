part of '../peach_collector.dart';

class PeachCollector {
  static const _prodSiteKey = 'zzebu00000000132';
  static const _debugSiteKey = 'zzebu00000000131';
  static const _serviceUrl = 'https://pipe-collect.ebu.io/v3/collect?s=';
  final PeachCollectorDataModel data;
  final String siteKey;

  PeachCollector({
    required this.data,
    required String environment,
  }) : siteKey = environment == 'development' ? _debugSiteKey : _prodSiteKey;

  void sendPageViewWithID(
    String pageId, {
    String? referrer,
    String? recommendationID,
  }) =>
      _send(
        PeachCollectorEvent.pageViewWithId(
          pageId,
          recommendationID: recommendationID,
          referrer: referrer,
        ),
      );

  void sendPageEvent({
    required PageEvent pageEvent,
    required String eventId,
    PageType? articleType,
    String? organisation,
    String? pageURI,
  }) =>
      _send(
        PeachCollectorEvent.pageView(
          pageEvent: pageEvent,
          eventId: eventId,
          articleType: articleType,
          pageURI: pageURI,
          organisation: organisation,
        ),
      );

  void sendShare({
    required ShareTarget target,
    required String eventTitle,
    required String eventId,
    required String shareLink,
    required String version,
    required String organisation,
    required String type,
  }) =>
      _send(
        PeachCollectorEvent.shareContent(
          target: target,
          eventTitle: eventTitle,
          eventId: eventId,
          shareLink: shareLink,
          version: version,
          organisation: organisation,
          type: type,
        ),
      );

  void sendAppInit() => _send(PeachCollectorEvent.appInit());

  void sendSearchEvent({
    required String searchText,
    required PageType page,
    required String language,
  }) =>
      _send(
        PeachCollectorEvent.search(
          searchText: searchText,
          page: page,
          language: language,
        ),
      );

  void sendMediaEvent({
    required MediaEvent mediaEvent,
    required String eventId,
    required PeachCollectorMediaDataModel data,
  }) =>
      _send(
        PeachCollectorEvent.media(
          mediaEvent: mediaEvent,
          eventId: eventId,
          data: data,
        ),
      );

  Future<void> _send(PeachCollectorEvent event) async {
    var dataMap = data.toJson(
      siteKey: siteKey,
      event: event.toJson(data),
    );

    if (data.showLogs) {
      debugPrint('Peach collector | ${event.type} | (${kDebugMode ? 'Cancel' : 'Send'}) | ${event.eventID} | $dataMap');
    }

    if (kDebugMode) {
      return;
    }

    PeachCollectorPublisher.sendEventsToPublisherNamed(
      serviceUrl: _serviceUrl + siteKey,
      data: dataMap,
    );
  }
}
