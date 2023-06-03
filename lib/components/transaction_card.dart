import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/personalTransactions.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import '../dataclass/user.dart';
import '../services/user_service.dart';
import '../size_config.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final PersonalTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.tid),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        await Provider.of<PersonalTransactionService>(context, listen: false)
            .deleteTransaction(
                transaction, Provider.of<UserService>(context, listen: false).user);
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text(
                  "Are you sure you wish to delete this transaction?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
              ],
            );
          },
        );
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  Image.asset(
                    "assets/DownRight.png",
                    width: SizeConfig.screenWidth * 0.075,
                  ),
                  Image.asset(
                    "assets/Food.png",
                    width: SizeConfig.screenWidth * 0.12,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 0,
                      left: 0
                    ),
                    child: Text(
                       "Group Name",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 0,
                      left: 15
                    ),
                    child: Text(
                      'Rs, ${transaction.amount}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 0,
                      left: 0,
                    ),
                    child: Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 0,
                      left: 0,
                      bottom: 10,
                    ),
                    child: Text(transaction.remarks,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                          bottom: 25,
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Text(
                                "Date  ",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                transaction.date.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        // visible: transItem.isGroup,
                        visible: true,
                        child: Row(
                          children: [
                            Text(
                              "Split Between  ",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "34",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        // visible: transItem.isGroup,
                        visible: true,
                        child: Row(
                          children: [
                            Text(
                              "Your Share  ",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "100",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
