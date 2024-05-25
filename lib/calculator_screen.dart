import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // . 0-9
  String operand = ""; // +-*/
  String number2 = ""; // ..0-9

  @override
  Widget build(BuildContext context) {
    final ScreenSize =
        MediaQuery.of(context).size; // makes the buttons to fit to any screen
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// ouput
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '$number1$operand$number2'.isEmpty
                        ? '0'
                        : '$number1$operand$number2',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            // buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: value == Btn.n0
                          ? ScreenSize.width / 2
                          : ScreenSize.width / 4,
                      height: ScreenSize.width / 5,
                      child: buildButton(value),
                    ), // we call the buid button function to desplay buttons
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget buildButton(value) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Material(
      color: getBtnColor(value),
      clipBehavior: Clip.hardEdge,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      child: InkWell(
        //inkwell makes the buttons tappable
        onTap: () => onBtnTap(value),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    ),
  );
}

//######
void onBtnTap(String value) {
  if (value == Btn.del) {
    delete();
    return;
  }

  if (value == Btn.clr) {
    clearAll();
    return;
  }

  if (value == Btn.per) {
    convertToPercentage();
    return;
  }

  if (value == Btn.calculate) {
    calculate();
    return;
  }

  appendValue(value);
}

// calculate function
void calculate() {
  if (number1.isEmpty) return;
  if (operand.isEmpty) return;
  if (number2.isEmpty) return;

  double num1 = double.parse(number1);
  double num2 = double.parse(number2);

  var result = 0.0;
  switch (operand) {
    case Btn.add:
      result = num1 + num2;
      break;
    case Btn.subtract:
      result = num1 - num2;
      break;
    case Btn.multiply:
      result = num1 * num2;
      break;
    case Btn.divide:
      result = num1 / num2;
      break;
    default:
  }
  setState(() {
    number1 = '$result';

    if (number1.endsWith('.0')) {
      number1 = number1.substring(0, number1.length - 2);
    }

    operand = '';
    number2 = '';
  });
}

//convertToPercentage function
void convertToPercentage() {
  if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
    //calculate before converting to percentage
    calculate();
    //final res = nnumber1 operand number2
    //number1 = res
  }

  if (operand.isNotEmpty) {
    //cannot be converted
    return;
  }
  final number = double.parse(number1);
  setState(() {
    number1 = '${(number / 100)}';
    operand = '';
    number2 = '';
  });
}

//clear function
void clearAll() {
  setState(() {
    number1 = '';
    operand = '';
    number2 = '';
  });
}

// delete func
void delete() {
  if (number2.isNotEmpty) {
    number2 = number2.substring(0, number2.length - 1);
  } else if (operand.isNotEmpty) {
    operand = '';
  } else if (number1.isNotEmpty) {
    number1 = number1.substring(0, number1.length - 1);
  }
  setState(() {});
}

// the function appends values to the end
void appendValue(String value) {
  if (value != Btn.dot && int.tryParse(value) == null) {
    //
    if (operand.isNotEmpty && number2.isNotEmpty) {
      // calculate  the equation befores\assigning a anew one
      calculate();
    }
    operand = value;
  } else if (number1.isEmpty || operand.isEmpty) {
    //number1 = '1.2
    if (value == Btn.dot && number1.contains(Btn.dot)) return;
    if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
      //number1 = '0' or ''
      value = '0';
    }
    number1 += value;
  } else if (number2.isEmpty || operand.isNotEmpty) {
    //number2 = '1.2
    if (value == Btn.dot && number2.contains(Btn.dot)) return;
    if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
      //number2 = '0' or ''
      value = '0';
    }
    number2 += value;
  }
  setState(() {});
}

//############
Color getBtnColor(value) {
  return [Btn.del, Btn.clr].contains(value)
      ? Colors.blueGrey
      : [
          Btn.per,
          Btn.multiply,
          Btn.add,
          Btn.subtract,
          Btn.divide,
          Btn.calculate
        ].contains(value)
          ? Colors.orange
          : Colors.black87;
}
}


