import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {

  final _userController = BehaviorSubject<List>();

  Stream<List> get outUsers => _userController.stream;
  Map<String, Map<String, dynamic>> _users = {};

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserBloc() {
    _addUsersListener();
  }

  void _addUsersListener(){
    _firestore.collection("users").snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        String uid = change.doc.id;
        switch(change.type){
          case DocumentChangeType.added:
            _users[uid] = change.doc.data() as Map<String, dynamic>;
            _suscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.doc.data as Map<String, dynamic>);
            _userController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _userController.add(_users.values.toList());
            break;
        }
      }
    });
  }

  void onChangedSearch(String search){
      if(search.trim().isEmpty){
        _userController.add(_users.values.toList());
      } else {
        _userController.add(_filter(search.trim()));
      }
  }

  List <Map <String,dynamic>> _filter(String search){
    List <Map <String,dynamic>> filterUSers = List.from(_users.values.toList());
    filterUSers.retainWhere((user){
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filterUSers;
  }
  void _suscribeToOrders(String uid){
    _users[uid]["subscription"] = _firestore.collection("users").doc(uid)
        .collection("orders").snapshots()
        .listen((orders) async {
          int numOrders = orders.docs.length;
          double money = 0.0;
          for(DocumentSnapshot d in orders.docs){
            DocumentSnapshot order = await _firestore.collection("orders").doc(d.id).get();
            if(order.data == null) continue;
            //money += order["totalPrice"];
          }
          _users[uid].addAll(
              {"money": money, "orders": orders}
              );

          _userController.add(_users.values.toList());
        });
  }

  void _unsubscribeToOrders(String uid){
    _users[uid]["subscription"].cancel();
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
