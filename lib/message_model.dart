class MessageModel {
  String display_type;
  Map<String, dynamic> extra;
  MessageBodyModel body;
  String msg_id;

  MessageModel.fromJson(Map<String, dynamic> json)
      : display_type = json["display_type"],
        extra = json["extra"],
        body = MessageBodyModel.fromJson(json["body"]),
        msg_id = json["msg_id"];

  Map<String, dynamic> toJson() => {
        'display_type': display_type,
        'extra': extra,
        'body': body.toJson(),
        'msg_id': msg_id,
      };
}

class MessageBodyModel {
  String after_open;
  String ticker;
  String custom;
  String title;
  String play_sound;
  String play_lights;
  String play_vibrate;
  String text;

  MessageBodyModel.fromJson(Map<String, dynamic> json)
      : after_open = json["after_open"],
        ticker = json["ticker"],
        custom = json["custom"],
        title = json["title"],
        play_sound = json["play_sound"],
        play_lights = json["play_lights"],
        play_vibrate = json["play_vibrate"],
        text = json["text"];

  Map<String, dynamic> toJson() => {
    'after_open': after_open,
    'ticker': ticker,
    'custom': custom,
    'title': title,
    'play_sound': play_sound,
    'play_lights': play_lights,
    'play_vibrate': play_vibrate,
    'text': text,
  };
}
