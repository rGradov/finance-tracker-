import 'package:equatable/equatable.dart';

enum AttachmentsFile {
  local,
  network,
  unknown,
}

/// @example how it works: AttachmentsLink its main classes for assets
///FIXME: remade me
class AttachmentsLink extends Equatable {
  final String url;
  final String localPath;

  const AttachmentsLink(this.url, this.localPath);

  String? get link => url ?? localPath;

  AttachmentsFile get getType => _checkAttachment();

  /// FIXME: FIX THIS PART
  AttachmentsFile _checkAttachment() {
    if (url != null && localPath != null) {
      return AttachmentsFile.local;
    } else if (localPath != null) {
      return AttachmentsFile.local;
    } else if (url != null && localPath == null) {
      return AttachmentsFile.network;
    } else {
      return AttachmentsFile.unknown;
    }
  }

  @override
  List<Object?> get props => [url, localPath];

  @override
  bool get stringify => true;
}
