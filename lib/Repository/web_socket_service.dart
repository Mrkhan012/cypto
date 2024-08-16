import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:ui/model/crypto_data.dart';

class WebSocketService {
  late IOWebSocketChannel _channel;
  late StreamSubscription _subscription;

  final Function(List) onDataReceived;
  final Function(Object) onError;

  WebSocketService({required this.onDataReceived, required this.onError}) {
    _initWebSocket();
  }

  void _initWebSocket() {
    _channel =
        IOWebSocketChannel.connect('ws://prereg.ex.api.ampiy.com/prices');

    _subscription = _channel.stream.listen(
      (message) {
        try {
          Map data = jsonDecode(message);
          if (data.containsKey('data') && data['data'] is List) {
            var tickerDataList = data['data'] as List;
            List cryptoDataList = tickerDataList
                .map((tickerData) => CryptoData.fromJson(tickerData))
                .toList();
            onDataReceived(cryptoDataList);
          }
        } catch (e) {
          onError(e);
        }
      },
      onError: (error) {
        onError(error);
      },
      cancelOnError: true,
    );

    _sendSubscriptionMessage();
  }

  void _sendSubscriptionMessage() {
    var subscribeMessage = {
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1
    };
    _channel.sink.add(jsonEncode(subscribeMessage));
  }

  void dispose() {
    _channel.sink.close();
    _subscription.cancel();
  }
}
