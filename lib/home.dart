import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  calcTotalPerPerson(double totalTip, double billAmount, int splitBy) {
    var totalPerPerson = (totalTip + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calcTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      // do nothing
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Tip Calculator")),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person",
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "\$${calcTotalPerPerson(calcTotalTip(_billAmount, _personCounter, _tipPercentage), _billAmount, _personCounter)}",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                    decoration: InputDecoration(
                        prefixText: "Amount: ",
                        
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          _billAmount = double.parse(value);
                        });
                      } catch (exeption) {
                        setState(() {
                          _billAmount = 0.0;
                        });
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  // do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.blue[50],
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.blue[50],
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Text(
                            "\$${(calcTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercentage %",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        // activeColor: Colors.blueAccent,
                        // inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double sliderValue) {
                          setState(() {
                            _tipPercentage = sliderValue.round();
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
