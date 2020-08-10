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
  /*
  This method will return the api key
   */
  Future<String> getApiKey() async {
    String data = await rootBundle.loadString('auth/apiKey.json');
    return jsonDecode(data)['api_key'];
  }

  /*
  This method will return the rate of crypto currency to normal currency
  @param String currency: Abbreviation of normal currency eg: USD
  @return Json Data
   */
  Future getRateData(String currency) async {
    String apiKey = await getApiKey();

    Map<String, String> exchangeRates = {};
    for (String cryptoCurrency in cryptoList) {
      NetworkHelper networkHelper =
          NetworkHelper('$url/$cryptoCurrency/$currency?apikey=$apiKey');
      String rate = (await networkHelper.getData() as num).toStringAsFixed(0);
      exchangeRates[cryptoCurrency] = rate;
    }

    return exchangeRates;
  }
}
