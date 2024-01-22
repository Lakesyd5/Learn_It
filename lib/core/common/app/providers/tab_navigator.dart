import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage); 

  final TabItem _initialPage;

  final List<TabItem> _navigationSTack = [];
}

class TabItem extends Equatable {
  TabItem({required this.child}) :id = const Uuid().v1(); 

  final Widget child;
  final String id;

  @override
  List<Object?> get props => [id];

}
