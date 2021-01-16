import 'package:crypto_font_icons/crypto_font_icons.dart';

const kApiKey =
    '5721B304-7E3A-4822-940E-19A6A338465E'; //'E3C71556-4F92-4956-8F95-EAD7B5B704A4';
const String kUrl = 'https://rest.coinapi.io/v1/exchangerate/';
const Map<String, String> kHeader = {'X-CoinAPI-Key': kApiKey};
const Map<String, String> currenciesList = {
  'AUD': 'A\$',
  'BRL': 'R\$',
  'CAD': 'C\$',
  'CNY': '¥',
  'EUR': '€',
  'GBP': '£',
  'HKD': 'HK\$',
  'IDR': 'Rp ',
  'ILS': '₪',
  'INR': '₹',
  'JPY': '¥',
  'MXN': 'Mex\$',
  'NOK': 'kr',
  'NZD': 'NZ\$',
  'PLN': 'zł',
  'RON': 'lei',
  'RUB': '₽',
  'SEK': 'kr',
  'SGD': 'S\$',
  'USD': '\$',
  'ZAR': 'R'
};

const Map<String, List<dynamic>> cryptoList = {
  'BTC': [CryptoFontIcons.BTC_ALT, 'BitCoin'],
  'ETH': [CryptoFontIcons.ETH, 'Etherium'],
  'LTC': [CryptoFontIcons.LTC, 'Lite Coin'],
};
