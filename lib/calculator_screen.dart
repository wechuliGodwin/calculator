import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ''; // . 0-9
  String operand = ''; // +-*/
  String number2 = ''; // ..0-9

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
