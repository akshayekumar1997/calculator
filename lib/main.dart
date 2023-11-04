import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = '0';

  // Button Widget
  Widget calcButton(String btnText, Color ? btnColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btnText);
        },
        child: Text(
          '$btnText',
          style: TextStyle(
            fontSize: 35,
            color: txtColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btnColor,
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$displaytxt',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.grey[850], Colors.white),
                calcButton('8', Colors.grey[850], Colors.white),
                calcButton('9', Colors.grey[850], Colors.white),
                calcButton('x', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.grey[850], Colors.white),
                calcButton('5', Colors.grey[850], Colors.white),
                calcButton('6', Colors.grey[850], Colors.white),
                calcButton('-', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.grey[850], Colors.white),
                calcButton('2', Colors.grey[850], Colors.white),
                calcButton('3', Colors.grey[850], Colors.white),
                calcButton('+', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.grey[850],
                    padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
                calcButton('.', Colors.grey[850], Colors.white),
                calcButton('=', Colors.amber[700], Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

void calculation(btnText) {
  if (btnText == 'AC') {
    setState(() {
      displaytxt = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    });
  } else if (btnText == '=') {
    if (numOne != 0 && opr.isNotEmpty) {
      numTwo = double.parse(result);
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      setState(() {
        displaytxt = finalResult;
        result = finalResult;
        preOpr = opr;
        opr = '';
      });
    }
  } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/') {
    if (numOne == 0) {
      numOne = double.parse(result);
    } else {
      numTwo = double.parse(result);
    }
    if (opr != '') {
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      setState(() {
        numOne = double.parse(finalResult);
      });
    }
    preOpr = opr;
    opr = btnText;
    result = '';
    setState(() {
      displaytxt = displaytxt + btnText;
    });
  } else if (btnText == '%') {
    result = (numOne / 100).toString();
    finalResult = doesContainDecimal(result);
    setState(() {
      displaytxt = finalResult;
      result = finalResult;
    });
  } else if (btnText == '.') {
    if (!result.toString().contains('.')) {
      result = result.toString() + '.';
      setState(() {
        displaytxt = displaytxt + btnText;
      });
    }
  } else if (btnText == '+/-') {
    if (result != '0') {
      if (result.toString().startsWith('-')) {
        result = result.toString().substring(1);
      } else {
        result = '-' + result.toString();
      }
      setState(() {
        displaytxt = result;
      });
    }
  } else {
    setState(() {
      if (displaytxt == '0') {
        displaytxt = btnText;
      } else {
        displaytxt = displaytxt + btnText;
      }
      result = result + btnText;
    });
  }
}


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    
   if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}