import 'dart:convert';

import 'package:bitcoin_ticker/network_helper.dart';
import 'package:flutter/services.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const url = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<String> getApiKey() async {
    String data = await rootBundle.loadString('auth/apiKey.json');
    return jsonDecode(data)['api_key'];
  }

  Future<dynamic> getRateData(String crypto, String currency) async {
    String apiKey = await getApiKey();
    NetworkHelper networkHelper =
        NetworkHelper('$url/$crypto/$currency?apikey=$apiKey');
    return networkHelper.getData();
  }
}
