import 'package:bitcoin_ticker/exchange_rate_card.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> _exchangeRateMap = {};
  String _currentCurrency = 'AUD';
  bool _isWaiting = true;

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
          createExchangeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }

  Column createExchangeCards() {
    List<ExchangeRateCard> list = [];

    for (String cryptoCurrency in cryptoList) {
      list.add(
        ExchangeRateCard(
          cryptoCurrency: cryptoCurrency,
          currentCurrency: _currentCurrency,
          exchangeRate: _isWaiting ? '?' : _exchangeRateMap[cryptoCurrency],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: list,
    );
  }

  /*
  This method will get the exchange rate of selected crypto currency and normal currency
  and add it to _exchangeRateMap
   */
  void getCryptoData() async {
    _isWaiting = true;
    try {
      Map<String, String> rate = await CoinData().getRateData(_currentCurrency);

      setState(() {
        _isWaiting = false;
        _exchangeRateMap = rate;
      });
    } catch (e) {
      print(e);
    }
  }

  /*
  This method will return androidDropDown menu
   */
  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> itemList = [];

    for (String currency in currenciesList) {
      itemList.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      items: itemList,
      value: _currentCurrency,
      onChanged: (value) {
        setState(() {
          _currentCurrency = value;
          getCryptoData();
        });
      },
    );
  }

  /*
  This method will return Cupertino picker
   */
  CupertinoPicker iosPicker() {
    List<Text> itemList = [];

    for (String currency in currenciesList) {
      itemList.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      children: itemList,
      onSelectedItemChanged: (index) {
        setState(() {
          _currentCurrency = currenciesList[index];
          getCryptoData();
        });
      },
    );
  }
}
