import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {

  final _ordersController = BehaviorSubject<List>();

  Stream<List> get outOrders => _ordersController.stream;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List <DocumentSnapshot> _orders = [];

  OrdersBloc(){
    _addOrdersListener();
  }

  void _addOrdersListener(){
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        String uid = change.doc.id;

        switch(change.type){
          case DocumentChangeType.added:
            _orders.add(change.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.id == uid);
            _orders.add(change.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.id ==uid );
            break;
        }
      });
      _ordersController.add(_orders);
    });
  }
  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
}
