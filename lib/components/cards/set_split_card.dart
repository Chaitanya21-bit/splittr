import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitter/components/custom_text_field.dart';

class SetSplitCard extends StatefulWidget {
  String memberName;
  late double amount;
  late int length;

  SetSplitCard({super.key, required this.memberName, required this.amount, required this.length});
  //Length ko Provider se bhi le sakta

  @override
  State<SetSplitCard> createState() => _SetSplitCardState();
}

class _SetSplitCardState extends State<SetSplitCard> {

  late final TextEditingController _individualamountController;
  late final TextEditingController _percentageController;
  bool check = false;

  @override
  void initState() {
    _individualamountController = TextEditingController(text: (widget.amount/widget.length).toString());
    _percentageController = TextEditingController(text: (((double.parse(_individualamountController.text))/(widget.amount)*100).toString())+'%');
  }


  void _updatePercentValue(String t) {
    setState(() {
      _percentageController.text = ((double.parse(_individualamountController.text))/(widget.amount)*100).toString()+'%';
    });
  }

  void _updateAmountValue(String t) {
    setState(() {
      _individualamountController.text = (double.parse(_percentageController.text.substring(0,_percentageController.text.length -1))*(widget.amount)/100).toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(
            value: this.check,
            onChanged: (bool? value) {
            setState(() {
              this.check = value!;
            });
          },
          ),
          Text('${widget.memberName}'),
          SizedBox(
            width: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _individualamountController,
              onChanged: _updatePercentValue,
              decoration: const InputDecoration(
                  // icon: Icon(Icons.currency_rupee),
                  // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 0
                  )
              ),
              enabled: check,
            ),
          ),
          SizedBox(
            width: 55,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _percentageController,
              onChanged: _updateAmountValue,
              decoration: InputDecoration(
                  // border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 0
                  )
              ),
              enabled: check,
            ),
          ),

        ],
      ),
    );
  }
}
