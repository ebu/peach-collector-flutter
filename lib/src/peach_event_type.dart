enum PageEvent {
  articleStart,
  articleEnd,
  readMore,
  pageView,
}

enum MediaEvent {
  mediaPlay,
  mediaPause,
  mediaSeek,
  mediaStop,
  mediaEnd,
  mediaHeartbeat,
  mediaVideoModeChanged,
  mediaAudioModeChanged,
  mediaAudioChanged,
  mediaLike,
  mediaShare,
  mediaDownload,
}

enum PageType {
  news,
  videos,
  events,
  myLibrary,
}

enum ShareTarget {
  email,
  copy,
}

extension PageEventValue on PageEvent {
  String get value {
    switch (this) {
      case PageEvent.articleStart:
        return "article_start";
      case PageEvent.articleEnd:
        return "article_end";
      case PageEvent.readMore:
        return "read_more";
      case PageEvent.pageView:
        return "page_view";
    }
  }
}

extension PageTypeValue on PageType {
  String get value {
    switch (this) {
      case PageType.news:
        return "news";
      case PageType.events:
        return "events";
      case PageType.videos:
        return "videos";
      case PageType.myLibrary:
        return "myLibrary";
    }
  }
}

extension MediaEventValue on MediaEvent {
  String get value {
    switch (this) {
      case MediaEvent.mediaPlay:
        return "media_play";
      case MediaEvent.mediaPause:
        return "media_pause";
      case MediaEvent.mediaSeek:
        return "media_seek";
      case MediaEvent.mediaStop:
        return "media_stop";
      case MediaEvent.mediaEnd:
        return "media_end";
      case MediaEvent.mediaHeartbeat:
        return "media_heartbeat";
      case MediaEvent.mediaVideoModeChanged:
        return "media_video_mode_changed";
      case MediaEvent.mediaAudioModeChanged:
        return "media_audio_mode_changed";
      case MediaEvent.mediaAudioChanged:
        return "media_audio_changed";
      case MediaEvent.mediaLike:
        return "media_like";
      case MediaEvent.mediaShare:
        return "media_share";
      case MediaEvent.mediaDownload:
        return "media_download";
    }
  }
}
