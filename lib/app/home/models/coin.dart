// {
//       "id": "90",
//       "symbol": "BTC",
//       "name": "Bitcoin",
//       "nameid": "bitcoin",
//       "rank": 1,
//       "price_usd": "6456.52",
//       "percent_change_24h": "-1.47",
//       "percent_change_1h": "0.05",
//       "percent_change_7d": "-1.07",
//       "price_btc": "1.00",
//       "market_cap_usd": "111586042785.56",
//       "volume24": 3997655362.9586277,
//       "volume24a": 3657294860.710187,
//       "csupply": "17282687.00",
//       "tsupply": "17282687",
//       "msupply": "21000000"
//     },

class Coin {
  String? id;
  String? rank;
  String? name;
  String? price_usd;
  String? symbol;
  String? percent_change_24h;

  Coin({
    this.id,
    this.rank,
    this.name,
    this.price_usd,
    this.symbol,
    this.percent_change_24h,
  });

  Coin.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '-';
    rank = (json['rank'] ?? '-').toString();
    name = json['name'] ?? '-';
    price_usd = json['price_usd'] ?? '-';
    symbol = json['symbol'] ?? '-';
    percent_change_24h = json['percent_change_24h'] ?? '-';
  }
}
