import 'package:equatable/equatable.dart';



class AccessInfo extends Equatable {
  final String? country;
  final String? viewability;
  final bool? embeddable;
  final bool? publicDomain;
  final String? textToSpeechPermission;
  final String? webReaderLink;
  final String? accessViewStatus;
  final bool? quoteSharingAllowed;

  const AccessInfo({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
    country: json['country'] as String?,
    viewability: json['viewability'] as String?,
    embeddable: json['embeddable'] as bool?,
    publicDomain: json['publicDomain'] as bool?,
    textToSpeechPermission: json['textToSpeechPermission'] as String?,
    webReaderLink: json['webReaderLink'] as String?,
    accessViewStatus: json['accessViewStatus'] as String?,
    quoteSharingAllowed: json['quoteSharingAllowed'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'country': country,
    'viewability': viewability,
    'embeddable': embeddable,
    'publicDomain': publicDomain,
    'textToSpeechPermission': textToSpeechPermission,
    'webReaderLink': webReaderLink,
    'accessViewStatus': accessViewStatus,
    'quoteSharingAllowed': quoteSharingAllowed,
  };

  @override
  List<Object?> get props {
    return [
      country,
      viewability,
      embeddable,
      publicDomain,
      textToSpeechPermission,
      webReaderLink,
      accessViewStatus,
      quoteSharingAllowed,
    ];
  }
}