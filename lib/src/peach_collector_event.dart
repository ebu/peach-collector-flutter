part of '../peach_collector.dart';

class PeachCollectorEvent {
  final String type;
  final String eventID;
  final DateTime eventTimestamp;
  final Map<String, dynamic>? context;
  final Map<String, dynamic>? props;
  final Map<String, dynamic>? metadata;

  PeachCollectorEvent({
    required this.type,
    required this.eventID,
    required this.eventTimestamp,
    this.context,
    this.props,
    this.metadata,
  });

  PeachCollectorEvent.pageViewWithId(
    String pageId, {
    String? referrer,
    String? recommendationID,
  }) : this(
          type: 'page_view',
          eventID: pageId,
          eventTimestamp: DateTime.now(),
          context: referrer != null || recommendationID != null
              ? {
                  if (referrer != null) 'PCContextReferrerKey': referrer,
                  if (recommendationID != null) 'PCContextIDKey': recommendationID,
                }
              : null,
        );

  PeachCollectorEvent.pageView({
    required PageEvent pageEvent,
    required String eventId,
    PageType? articleType,
    String? organisation,
    String? pageURI,
  }) : this(
          type: pageEvent.value,
          eventID: eventId,
          eventTimestamp: DateTime.now(),
          context: pageEvent == PageEvent.articleStart
              ? {
                  "article_type": articleType?.value,
                  "organisation": organisation,
                  "url": pageURI,
                }
              : null,
        );

  PeachCollectorEvent.shareContent({
    required ShareTarget target,
    required String eventTitle,
    required String eventId,
    required String shareLink,
    required String version,
    required String organisation,
    required String type,
  }) : this(
          type: 'user_action',
          eventID: eventId,
          eventTimestamp: DateTime.now(),
          props: {
            "action": "share",
            "target": target.name,
          },
          context: {
            "id": eventId,
            "organisation": organisation,
            "type": type,
            "version": version,
            "shared_link": shareLink,
          },
          metadata: {
            "title": eventTitle,
          },
        );

  PeachCollectorEvent.appInit()
      : this(
          type: PageEvent.pageView.value,
          eventID: 'init',
          props: null,
          context: null,
          eventTimestamp: DateTime.now(),
        );

  PeachCollectorEvent.search({
    required String searchText,
    required PageType page,
    required String language,
  }) : this(
          type: 'search',
          eventID: 'search_${page.value}',
          context: {
            "language": language,
          },
          props: {
            "search": searchText,
            "language": language,
          },
          eventTimestamp: DateTime.now(),
        );

  PeachCollectorEvent.media({
    required MediaEvent mediaEvent,
    required String eventId,
    required PeachCollectorMediaDataModel data,
  }) : this(
          type: mediaEvent.value,
          eventID: eventId,
          metadata: {
            "duration": data.duration,
            "format": data.format,
            "original_language": data.originalLanguage,
            "publication_date": data.publicationDate,
            "type": data.type,
          },
          props: {
            if (data.previousPlaybackPosition != null) "previous_playback_position_s": data.previousPlaybackPosition,
            "playback_position_s": data.playbackPosition,
            "playback_rate": data.playbackRate,
            "start_mode": data.startMode,
            "video_mode": data.videoMode,
            "volume": data.volume,
            "subtitles_language": data.subtitlesLanguage,
          },
          context: {
            "id": data.id,
            "organisation": data.organisation,
            "page_uri": data.pageUri,
            "source": data.source,
            "version_id": data.versionId,
          },
          eventTimestamp: DateTime.now(),
        );

  Map<String, dynamic> toJson(PeachCollectorDataModel data) {
    var defaultContext = <String, dynamic>{
      "codops": data.ops,
      "language": data.language,
    };
    defaultContext.addAll(context ?? {});

    Map<String, dynamic> result = {
      "type": type,
      "id": eventID,
      "event_timestamp": eventTimestamp.millisecondsSinceEpoch,
      "context": defaultContext,
      if (props != null) "props": props,
      if (metadata != null) "metadata": metadata,
    };

    return result;
  }
}
