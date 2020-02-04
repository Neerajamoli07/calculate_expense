import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx,constraints){
          return Column(
            children: <Widget>[
              Text("No Transaction added yet!",
                  style: Theme.of(context).textTheme.title),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ))
            ],
          );  
        },)
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('\$${transaction[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(transaction[index].title,
                      style: Theme.of(context).textTheme.title),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction[index].dateTime),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                  ? FlatButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text("Delete"),
                      textColor: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transaction[index].id),
                  )
                  
                  : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transaction[index].id),
                  ),
                ),
              );
            },
            itemCount: transaction.length,
            // children: transaction.map((tx) {

            // }).toList(),
          );
  }
}
