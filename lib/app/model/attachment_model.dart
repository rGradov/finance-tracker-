import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/utils/app_lattachment_link.dart';

///[AttachmentType] basically use if for defined which
///type of attachment we use
///@example [AttachmentType.audio] = for audio, [AttachmentType.document] = for
///document[PDF only] and e.t.c
///[AttachmentType.unknown] use for unknown type of file, if type is unknown just
///send this type to analytics for analysing most loaded unknown types
enum AttachmentType {
  audio,
  video,
  photo,
  document,
  unknown,
}
/// [Attachment] main model which used for Attachment in Expense or Income
/// basically creationTime should pasted [AttachmentsLink] this is the main
/// for defined path how it work in nutshell: we customise Image widget and e.t.c
/// wich can easily load file wherever he was [Network] || [local]
///
class Attachment extends Equatable {
  final DateTime creationTime;
  final AttachmentType type;
  final AttachmentsLink path;

  const Attachment({
    required this.creationTime,
    required this.type,
    required this.path,
  });

  @override
  List<Object?> get props => [creationTime, type, path];

  @override
  bool get stringify => true;
}
