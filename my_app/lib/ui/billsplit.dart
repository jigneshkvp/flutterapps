import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  BillSplit _billSplit;

  @override
  void initState() {
    super.initState();
    _billSplit = BillSplit();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("This");
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.grey.shade100,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.5),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: _getTotals(context),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.transparent,
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.blueGrey.shade100)),
                child: Column(
                  children: <Widget>[
                    _getAmountInputWidget(),
                    _getSplitPersonWidget(),
                    _getTipWidget(),
                    _getTipPercentageWidget(),
                    Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() => {_billSplit.reset()});
                          },
                          child: Text('Clear'),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _getTipPercentageWidget() {
    return Column(
      children: <Widget>[
        Text(
          "${_billSplit.tipPercentage}%",
          style: TextStyle(
              color: Colors.deepPurple.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        Slider(
          min: 0,
          max: 100,
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.grey,
          divisions: 20,
          value: _billSplit.tipPercentage.toDouble(),
          onChanged: (double newValue) => {
            setState(() => {_billSplit.tipPercentage = newValue.round()})
          },
        )
      ],
    );
  }

  Row _getTipWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Tip',
          style: TextStyle(fontSize: 17.0, color: Colors.grey.shade700),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "\$ ${_billSplit.totalTip.toStringAsFixed(2)}",
            style: TextStyle(
                color: Colors.deepPurple.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        )
      ],
    );
  }

  Row _getSplitPersonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Split",
          style: TextStyle(fontSize: 17.0, color: Colors.grey.shade700),
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  //debugPrint(_personCounter.toString());
                  if (_billSplit.personCount > 1) _billSplit.personCount--;
                });
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  "-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
            ),
            Text(
              "${_billSplit.personCount}",
              style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    //debugPrint(_personCounter.toString());
                    _billSplit.personCount++;
                  });
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    "+",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                ))
          ],
        )
      ],
    );
  }

  TextField _getAmountInputWidget() {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.attach_money), hintText: 'Amount'),
      onChanged: (String value) {
        try {
          _billSplit.totalAmount = double.parse(value);
        } catch (Exception) {
          _billSplit.totalAmount = 0.0;
        }
      },
    );
  }

  Container _getTotals(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: Colors.deepPurple.shade100.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Total Per Person',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          ),
          Text("\$ ${_billSplit.calculateTotalPerPerson()}",
              style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0)),
        ],
      ),
    );
  }
}

class BillSplit {
  double totalAmount = 0.0;
  int tipPercentage = 0;
  int personCount = 1;

  double get totalTip => _calculateTip();

  double _calculateTip() {
    if (totalAmount < 0 ||
        totalAmount.toString().isEmpty ||
        totalAmount == null) return 0.0;

    return (totalAmount * tipPercentage) / 100;
  }

  calculateTotalPerPerson() {
    var totalPerPerson = (totalTip + totalAmount) / personCount;

    return totalPerPerson.toStringAsFixed(2);
  }

  reset() {
    totalAmount = 0.0;
    tipPercentage = 0;
    personCount = 1;
  }
}
