import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/provider/webSocketProvider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WebSocketProvider(),
      child: Consumer<WebSocketProvider>(
        builder: (context, provider, _) {
          var theme = Theme.of(context); // Correct way to access theme
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: provider.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "COINS",
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: provider.searchController,
                            onChanged: (value) {
                              provider.applyFilter(value);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Search',
                              suffixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.filteredCryptoDataList.length,
                            itemBuilder: (context, index) {
                              var cryptoData =
                                  provider.filteredCryptoDataList[index];
                              IconData arrowIcon =
                                  cryptoData.priceChange.startsWith('-')
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward;
                              final List imagePaths = [
                                'assets/images/bitcoin.png',
                                'assets/images/crypto.png',
                                'assets/images/ethereum.png',
                              ];
                              return Container(
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Image.asset(
                                        imagePaths[index % imagePaths.length],
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${cryptoData.symbol.substring(0, 3).toUpperCase()}',
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            '${cryptoData.symbol}',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Text(
                                        '₹${cryptoData.currentPrice}',
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              arrowIcon,
                                              color: _getColorForPriceChange(
                                                  cryptoData.priceChange),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${cryptoData.priceChange}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: _getColorForPriceChange(
                                                    cryptoData.priceChange),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorForPriceChange(String priceChange) {
    double change = double.tryParse(priceChange.replaceAll(',', '')) ?? 0.0;
    return change < 0 ? Colors.red : Colors.green;
  }
}
