import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#12234 - Entregue",
            style: TextStyle(color: Colors.green),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Camiseta Preta P"),
                        subtitle: Text("Camisetas/129182981"),
                        trailing: Text(
                          "2",
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
