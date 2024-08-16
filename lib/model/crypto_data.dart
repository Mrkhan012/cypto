class CryptoData {
  String symbol;
  String currentPrice;
  String priceChange;

  CryptoData({
    required this.symbol,
    required this.currentPrice,
    required this.priceChange,
  });

  factory CryptoData.fromJson(Map json) {
    return CryptoData(
      symbol: json['s'],
      currentPrice: json['c'],
      priceChange: json['p'],
    );
  }
}
