import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _exchangeRate = '?';
  String _cryptoCurrency = 'BTC';
  String _normalCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    getCryptoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $_cryptoCurrency = $_exchangeRate $_normalCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: null,
          ),
        ],
      ),
    );
  }

//  void updateRate(dynamic cryptoData) {
//    setState(() {
//      if (cryptoData == null) {
//        _exchangeRate = 'ERROR';
//        return;
//      }
//      int rate = (cryptoData['rate'] as num).toInt();
//      String cryptoCurrency = cryptoData['asset_id_base'];
//      String normalCurrency = cryptoData['asset_id_quote'];
//      _exchangeRate = '1 $cryptoCurrency = $rate $normalCurrency';
//    });
//  }

  void getCryptoData() async {
    try {
      double rate =
          (await CoinData().getRateData('BTC', 'USD') as num).toDouble();
      setState(() {
        print(rate);
        _exchangeRate = rate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }
}
