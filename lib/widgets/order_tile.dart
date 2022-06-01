import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'order_header.dart';

class OrderTile extends StatelessWidget {

  final DocumentSnapshot order;

  final states = [
    "", "Em Preparação", "Em Transporte", "Aguardando Entrega", "Entregue"
  ];

  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#${order.id.substring(order.id.length - 7, order.id.length)} -" "${states[order["status"]]}",
            style: TextStyle(color: Colors.green),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderHeader(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order["products"].map((p){
                      return ListTile(
                        title: Text(p["products"]["title"] + " " + p["size"]),
                        subtitle: Text(p["category"] + "/" + p["pid"]),
                        trailing: Text(p["quantity"].toString(),
                        style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                        );
                      }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text("Excluir")),
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.grey[850],
                          ),
                          child: Text("Regredir")),
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text("Avançar")),
                    ],
                  )
                ],
              ),
            )],
        ),
      ),
    );
  }
}
