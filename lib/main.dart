import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './models/transaction.dart';

import './widgets/page.dart';
import './widgets/new_transaction.dart';

void main() {
  // to force portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money manager',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple.shade200,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Quicksand',
              // fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            button:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime txDate, bool isIncome) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: txDate,
        id: txDate.toString(),
        income: isIncome);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(Transaction tx) {
    setState(() {
      _userTransactions.remove(tx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    // var _isPortrait = MediaQuery.of(ctx).orientation == Orientation.portrait;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(
            addTx: _addNewTransaction,
            padding: MediaQuery.of(context).padding.top,
          );
        });
  }

  double get _totalBalance {
    double total = 0;

    var _isIncome;
    _userTransactions.forEach((tx) {
      tx.income ? _isIncome = 1 : _isIncome = -1;
      total = total + tx.amount * _isIncome;
    });
    return total;
  }

  void _adjustBalance(double currentBalance) {
    bool isIncome;
    if (_totalBalance < currentBalance) {
      isIncome = true;
    } else if (_totalBalance > currentBalance) {
      isIncome = false;
    } else {
      return;
    }
    _addNewTransaction("Unknown transaction",
        (_totalBalance - currentBalance).abs(), DateTime.now(), isIncome);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build MyHomepage");
    var _theme = Theme.of(context);
    var _mediaQuery = MediaQuery.of(context);
    // var _screenHeight = _mediaQuery.size.height;
    // var _screenWidth = _mediaQuery.size.width;
    var _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    var _isAndroid = Platform.isAndroid;
    // var _isAndroid = false;
    final PreferredSizeWidget appBar = _isAndroid
        ? AppBar(
      backgroundColor: _theme.primaryColorLight,
      elevation: 0.0,
      title: const Text(
        "Money Manager",
        style: TextStyle(color: Colors.black),
      ),
      // actions: [
      //   IconButton(
      //       onPressed: () => _adjustBalance(-200.0),
      //       icon: Icon(Icons.edit))
      // ],
    )
        : CupertinoNavigationBar(
      backgroundColor: _theme.primaryColorLight,
      middle: const Text("Money Manager"),
      trailing: GestureDetector(
        child: const Icon(CupertinoIcons.add),
        onTap: () => _startAddNewTransaction(context),
      ),
    );
    // bool _addAppBar = _isAndroid ? false : true;
    bool _addAppBar = true;
    double appBarHeight = _addAppBar ? appBar.preferredSize.height : 0.0;
    print("appBar.preferredSize.height ${appBar.preferredSize.height}");
    print(
        "appBar.preferredSize.longestSide ${appBar.preferredSize.longestSide}");
    print(
        "appBar.preferredSize.shortestSide ${appBar.preferredSize.shortestSide}");
    Widget page = PageContent(
      appBarHeight: appBarHeight,
      theme: _theme,
      recentTransactions: _recentTransactions,
      totalBalance: _totalBalance,
      userTransactions: _userTransactions,
      deleteTransaction: _deleteTransaction,
    );
    if (_isAndroid) {
      return Scaffold(
        appBar: appBar,
        body: page,
        floatingActionButton: _isAndroid
            ? FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
        )
            : Container(),
        floatingActionButtonLocation: _isPortrait
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.endFloat,
      );
    } else {
      return CupertinoPageScaffold(
        child: page,
        navigationBar: appBar,
      );
    }
  }
}
