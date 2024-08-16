import 'package:flutter/material.dart';
import 'package:ui/Repository/web_socket_service.dart';

class WebSocketProvider with ChangeNotifier {
  late WebSocketService _webSocketService;

  List _cryptoDataList = [];
  List _filteredCryptoDataList = [];
  bool _loading = true;

  final TextEditingController _searchController = TextEditingController();

  List get filteredCryptoDataList => _filteredCryptoDataList;
  bool get loading => _loading;
  TextEditingController get searchController => _searchController;

  WebSocketProvider() {
    _webSocketService = WebSocketService(
      onDataReceived: (cryptoDataList) {
        _cryptoDataList = cryptoDataList;
        applyFilter(_searchController.text);
        _loading = false;
        notifyListeners();
      },
      onError: (error) {
        print('WebSocket error: $error');
        _loading = false;
        notifyListeners();
      },
    );
  }

  void applyFilter(String query) {
    if (query.isEmpty) {
      _filteredCryptoDataList = List.from(_cryptoDataList);
    } else {
      _filteredCryptoDataList = _cryptoDataList
          .where((crypto) =>
              crypto.symbol.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearFilter() {
    _searchController.clear();
    applyFilter('');
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}
