class MessageModel {
  String displayType;
  Map<String, dynamic> extra;
  MessageBodyModel body;
  String msgId;

  MessageModel.fromJson(Map<String, dynamic> json)
      : displayType = json["display_type"],
        extra = json["extra"],
        body = MessageBodyModel.fromJson(json["body"]),
        msgId = json["msg_id"];

  Map<String, dynamic> toJson() => {
        'display_type': displayType,
        'extra': extra,
        'body': body.toJson(),
        'msg_id': msgId,
      };
}

class MessageBodyModel {
  String afterOpen;
  String ticker;
  String custom;
  String url;
  String activity;
  String title;
  String playSound;
  String playLights;
  String playVibrate;
  String text;

  MessageBodyModel.fromJson(Map<String, dynamic> json)
      : afterOpen = json["after_open"],
        ticker = json["ticker"],
        custom = json["custom"],
        url = json["url"],
        activity = json["activity"],
        title = json["title"],
        playSound = json["play_sound"],
        playLights = json["play_lights"],
        playVibrate = json["play_vibrate"],
        text = json["text"];

  Map<String, dynamic> toJson() => {
        'after_open': afterOpen,
        'ticker': ticker,
        'custom': custom,
        'url': url,
        'activity': activity,
        'title': title,
        'play_sound': playSound,
        'play_lights': playLights,
        'play_vibrate': playVibrate,
        'text': text,
      };
}
