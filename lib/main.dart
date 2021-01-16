import 'dart:convert';
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/constants.dart';
import 'package:bitcoin_ticker/service/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//
void main() {
  runApp(BitCoin());
}

class BitCoin extends StatefulWidget {
  @override
  _BitCoinState createState() => _BitCoinState();
}

class _BitCoinState extends State<BitCoin> {
  Map<String, String> prices = {};
  String sign = '\$';
  String currency = 'USD';
  List<String> _cupertinoList = [];

  List<CoinWidget> getCoins() {
    List<CoinWidget> result = [];

    for (String s in cryptoList.keys) {
      CoinWidget c = CoinWidget(
        icon: cryptoList[s][0],
        name: cryptoList[s][1],
        price: '$sign${prices[s] ?? '?'}',
      );

      result.add(c);
    }

    return result;
  }

  void setValues() async {
    setState(() {
      prices.clear();
    });
    for (String cryptocurrency in cryptoList.keys) {
      String url = '$kUrl$cryptocurrency/$currency';
      dynamic jsonData = await NetworkStats.getStats(url);

      //print(url);
      if (jsonData != null) {
        jsonData = jsonDecode(jsonData);
        print(jsonData);
        double cost = jsonData['rate'] + 0.0;
        String rate = cost.toStringAsFixed(2);
        setState(() {
          prices.putIfAbsent(cryptocurrency, () => rate);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  Widget getIOSPicker() {
    List<Text> list = [];
    _cupertinoList.clear();
    for (String s in currenciesList.keys) {
      Text t = Text(
        s,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
      _cupertinoList.add(s);
      list.add(t);
    }
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          print(currency);
          setValues();
          return true;
        }
        return false;
      },
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: 19),
        itemExtent: 32,
        onSelectedItemChanged: (value) {
          setState(() {
            currency = _cupertinoList[value];
            sign = currenciesList[currency];
            //print(currency);

            //setValues();
          });
        },
        children: list,
      ),
    );
  }

  DropdownButton getAndroidDropDownMenu() {
    List<DropdownMenuItem<String>> list = [];

    for (String s in currenciesList.keys) {
      DropdownMenuItem<String> d = DropdownMenuItem(
        child: Text(
          s,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: s,
      );

      list.add(d);
    }

    return DropdownButton<String>(
        dropdownColor: Colors.blue,
        onChanged: (value) {
          print(value);
          setState(() {
            currency = value;
            sign = currenciesList[currency];
            setValues();
          });
        },
        items: list,
        value: currency);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Coin Ticker',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: getCoins(),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Platform.isIOS
                        ? getIOSPicker()
                        : getAndroidDropDownMenu(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CoinWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final String price;

  CoinWidget({this.name, this.icon, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFEBF3FE),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color: Colors.blue,
                    size: 50,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF61B4E0),
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    price.toString(),
                    style: TextStyle(
                        color: Color(0xFF1B9ACF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
