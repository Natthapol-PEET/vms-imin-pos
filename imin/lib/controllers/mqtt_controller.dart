import 'package:get/get.dart';
import 'package:imin/controllers/entrance_project_controller.dart';
import 'package:imin/controllers/exit_project_controller.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttController extends GetxController {
  MqttServerClient client = MqttServerClient.withPort(
      'broker.hivemq.com', 'flutter_client_vms_test', 1883);

  Future<MqttServerClient> connect() async {
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier("client-flutter-vms-imin")
        .authenticateAs('vms-user@lifestyle.co.th', 'P@ssW0rd@lifestyle.co.th')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    return client;
  }

  // connection succeeded
  void onConnected() {
    print('Connected');

    client.subscribe('app-to-web', MqttQos.atMostOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      MqttPublishMessage message = c[0].payload as MqttPublishMessage;

      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message:$payload from topic: ${c[0].topic}>');

      // if (payload == 'RESIDENT_STAMP' || payload == 'CHECKOUT') {
      //   final exitController = Get.put(ExitProjectController());
      //   exitController.getExitData();
      // }
      final entranceController = Get.put(EntranceProjectController());
      entranceController.getEntranceData();

      final exitController = Get.put(ExitProjectController());
      exitController.getExitData();
    });
  }

  publishMessage(String topic, String message) {
    try {
      final builder1 = MqttClientPayloadBuilder();
      builder1.addString(message);
      print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
      client.publishMessage(topic, MqttQos.atLeastOnce, builder1.payload!);
    } catch (e) {
      print("publishMessage: $e");
    }
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }
}
