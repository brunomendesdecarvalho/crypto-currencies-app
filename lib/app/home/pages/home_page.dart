import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../core/enums/request_state.dart';
import '../home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Modular.get<HomeController>();
  var scrollController = new ScrollController();

  @override
  void initState() {
    controller.getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
        child: RxBuilder(builder: (context) {
          if (controller.stateCoin.value == RequestState.LOADING) {
            return Container(
                height: height,
                width: width,
                child: Center(child: CircularProgressIndicator()));
          } else {
            return Column(
              children: [
                SizedBox(
                  height: height * .05,
                ),
                Text(
                  'Cryptocurrencies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                          width: width * .1,
                          child: Text(
                            'Rank',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 12),
                          )),
                      Container(
                          width: width * .2,
                          child: Text(
                            'Name',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 12),
                          )),
                      Text(
                        'Symbol',
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                      Spacer(),
                      Container(
                        width: width * .2,
                        child: Text(
                          'Price',
                          style: TextStyle(color: Colors.black45, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '24h Variation (\%)',
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    controller: scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.coinList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height * .08,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                    width: width * .1,
                                    child: Text(
                                        '# ${controller.coinList[index].rank}')),
                                Container(
                                    width: width * .2,
                                    child: Text(
                                      '${controller.coinList[index].name}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                // SizedBox(width: width * .1),
                                Text('${controller.coinList[index].symbol}'),
                                Spacer(),
                                Container(
                                  child: Text(
                                    'US\$ ${_currencyFormat(double.parse(controller.coinList[index].price_usd ?? '0'))}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      _percentageIcon(double.parse(controller
                                              .coinList[index]
                                              .percent_change_24h ??
                                          '0')),
                                      color: _percentageColor(double.parse(
                                          controller.coinList[index]
                                                  .percent_change_24h ??
                                              '0')),
                                    ),
                                    Text(
                                      '${_currencyFormat(double.parse(controller.coinList[index].percent_change_24h ?? '0'))}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _percentageColor(double.parse(
                                              controller.coinList[index]
                                                      .percent_change_24h ??
                                                  '0'))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
          }
        }),
      ),
    ));
  }
}

String _currencyFormat(double value) {
  var usdCurrency = new NumberFormat("#,##0.00", "en_US");
  return usdCurrency.format(value);
}

Color _percentageColor(double value) {
  if (value < 0) {
    return Colors.red;
  }
  return Colors.green;
}

IconData _percentageIcon(double value) {
  if (value < 0) {
    return Icons.arrow_downward_rounded;
  }
  return Icons.arrow_upward_rounded;
}
