import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../core/enums/request_state.dart';
import 'home_repository.dart';
import 'models/coin.dart';

class HomeController extends Disposable {
  HomeController({required this.repository});

  final stateCoin = RxNotifier<RequestState>(RequestState.IDLE);
  final HomeRepository repository;
  final coinList = RxList<Coin>([]);

  void getCoins() async {
    stateCoin.value = RequestState.LOADING;
    var result = await repository.fetchCoins();
    if (result.isNotEmpty) {
      coinList.addAll(result);
      stateCoin.value = RequestState.SUCCESS;
    } else {
      stateCoin.value = RequestState.FAIL;
    }
  }

  @override
  void dispose() {}
}
