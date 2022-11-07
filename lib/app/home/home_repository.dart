import 'package:dio/dio.dart';

import 'models/coin.dart';

class HomeRepository {
  HomeRepository();

  Future<List<Coin>> fetchCoins() async {
    var coinList = <Coin>[];
    var response = await Dio().get('https://api.coinlore.net/api/tickers/');

    if (response.statusCode == 200) {
      print(response.data['data'].toString());
      response.data['data']
          .forEach((coin) => coinList.add(Coin.fromJson(coin)));
      return coinList;
    } else {
      return [];
    }
  }
}
