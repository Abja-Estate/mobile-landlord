import 'package:awesome_notifications/awesome_notifications.dart';

import 'local_storage.dart';

notify(header,text,status) async {

  await saveWSSVerify(status);
    //show notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      //simgple notification
      id: 1234,
      channelKey: 'basic', //set configuration wuth key "basic"
      title: header,
      body: text,
    ));
  
}
