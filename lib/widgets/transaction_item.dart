import 'package:flutter/material.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({required this.transItem, required this.deleteTransaction});
  final Transactions transItem;
  final Function deleteTransaction;

  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 12.0),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10),
  //       child: Container(
  //         padding: EdgeInsets.all(15),
  //         color: Colors.grey[100],
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Container(
  //                       padding: EdgeInsets.all(5),
  //                       decoration: BoxDecoration(
  //                           shape: BoxShape.circle, color: Colors.grey[500]),
  //                       child: Center(
  //                         child: Icon(
  //                           Icons.attach_money_outlined,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(transactionName,
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           color: Colors.grey[700],
  //                         )),
  //                   ],
  //                 ),
  //                 Text(
  //                   (expenseOrIncome == 'expense' ? '-' : '+') + '\$' + money,
  //                   style: TextStyle(
  //                     //fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                     color: expenseOrIncome == 'expense'
  //                         ? Colors.red
  //                         : Colors.green,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Text(remarks,
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey[500],
  //                     )),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 240, 190),
      margin: EdgeInsets.all(6),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Dismissible(
        key: Key(transItem.tid),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          deleteTransaction(context, transItem);
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm"),
                content:
                    Text("Are you sure you wish to delete this transaction?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("CANCEL"),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("DELETE")),
                ],
              );
            },
          );
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailsPage(transaction: _transaction),
            //   ),
            // );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      transItem.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          '${transItem.amount}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          transItem.date,
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20.0, bottom: 25.0)),
                  Text(transItem.remarks,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
