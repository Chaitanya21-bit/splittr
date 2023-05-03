import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/transactions.dart';
import '../dataclass/person.dart';

class NewTransactionItem extends StatelessWidget {
  const NewTransactionItem({super.key, required this.transItem});
  final Transactions transItem;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //
    //   child: Dismissible(
    //     key: Key(transItem.tid),
    //     background: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.transparent,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       padding: const EdgeInsets.only(right: 20.0),
    //       child: const Align(
    //         alignment: Alignment.centerRight,
    //         child: Icon(
    //           Icons.delete,
    //           color: Colors.white,
    //           size: 30.0,
    //         ),
    //       ),
    //     ),
    //     direction: DismissDirection.endToStart,
    //     onDismissed: (direction) async {
    //       await Provider.of<Person>(context, listen: false)
    //           .deleteTransaction(transItem);
    //     },
    //     confirmDismiss: (DismissDirection direction) async {
    //       return await showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             title: const Text("Confirm"),
    //             content: const Text(
    //                 "Are you sure you wish to delete this transaction?"),
    //             actions: <Widget>[
    //               TextButton(
    //                 onPressed: () => Navigator.of(context).pop(false),
    //                 child: const Text("CANCEL"),
    //               ),
    //               TextButton(
    //                   onPressed: () => Navigator.of(context).pop(true),
    //                   child: const Text("DELETE")),
    //             ],
    //           );
    //         },
    //       );
    //     },
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(15.0),
    //       onTap: () {},
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //               Container(
    //                 padding: const EdgeInsets.all(8),
    //                 margin: const EdgeInsets.symmetric(
    //                   horizontal: 15,
    //                   vertical: 15,
    //                 ),
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                     color: Theme.of(context).primaryColor,
    //                     width: 2,
    //                   ),
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //                 child: Text(
    //                   transItem.title,
    //                   style: const TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                     overflow: TextOverflow.ellipsis,
    //                   ),
    //                   maxLines: 2,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const Padding(padding: EdgeInsets.only(top: 4.0)),
    //                     Text(
    //                       '${transItem.amount}',
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                     Text(
    //                       transItem.date,
    //                       style: TextStyle(
    //                         color: Colors.black,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             children: [
    //               const Padding(
    //                   padding: EdgeInsets.only(left: 20.0, bottom: 25.0)),
    //               Text(transItem.remarks,
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.black,
    //                   )),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Card(
      child: ClipPath(
        child: Dismissible(
          key: Key(transItem.tid),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.only(right: 20.0),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await Provider.of<Person>(context, listen: false)
                .deleteTransaction(transItem);
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
          child: InkWell(
            onTap: () {},
            child: Container(

              child: Row(

                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/DownRight.png",
                            width: MediaQuery.of(context).size.width * 0.075,
                          ), // Logo,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset("assets/Food.png",
                            width: MediaQuery.of(context).size.width * 0.12,
                          ), // Logo,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 0,
                            left: 0,
                          ),
                          child: Text(transItem.isGroup? "Group Name" : "",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            right: 0,
                            left: 15,
                          ),
                          child: Text(
                            '${transItem.amount}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 0,
                            left: 0,
                          ),
                          child: Text(
                            transItem.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(
                            right: 0,
                            left: 0,
                            bottom: 10,
                          ),
                          child :Text(transItem.remarks,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                        padding:EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child:Align(alignment: Alignment.centerRight,
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  bottom: 25,
                                ),
                                child:
                                    Align(
                                      alignment: Alignment.topRight,
                                      child:Row(
                                        children: [
                                          Text("Date  ",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),

                                          Text(
                                            transItem.date,
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
                                  visible: transItem.isGroup,
                                  child: Row(
                                  children: [

                                    Text("Split Between  " ,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(transItem.split.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                              Visibility(
                                visible: transItem.isGroup,
                                child:Row(
                                  children: [

                                    Text("Your Share  ",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text("100" ,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),



                            ],
                          ),)
                    ),





                ],
              ),
            )
          )


            ),
          ),
    );
  }
}
