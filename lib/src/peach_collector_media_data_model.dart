// ignore: use_string_in_part_of_directives
part of peach_collector;

class PeachCollectorMediaDataModel {
  final String? id;
  final String? organisation;
  final String? pageUri;
  final String? source;
  final String? versionId;
  final int? duration;
  final String? format;
  final String? originalLanguage;
  final String? subtitlesLanguage;
  final String? publicationDate;
  final String? type;
  final double? playbackPosition;
  final double? previousPlaybackPosition;
  final double? playbackRate;
  final String? startMode;
  final String? videoMode;
  final int? volume;

  PeachCollectorMediaDataModel({
    required this.id,
    required this.organisation,
    required this.pageUri,
    required this.source,
    required this.versionId,
    required this.duration,
    required this.format,
    required this.originalLanguage,
    required this.subtitlesLanguage,
    required this.publicationDate,
    required this.type,
    required this.playbackPosition,
    required this.previousPlaybackPosition,
    required this.playbackRate,
    required this.startMode,
    required this.videoMode,
    required this.volume,
  });
}
