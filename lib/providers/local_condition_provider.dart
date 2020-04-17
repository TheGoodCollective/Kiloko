import 'package:flutter/material.dart';
import 'package:kiloko/models/condition.dart';
import 'package:kiloko/services/local_condition_service.dart';


class LocalConditionProvider extends ChangeNotifier {
  List<Condition> _conditions = [];
  bool _isLoading = false;
  LocalConditionService _localConditionService;

  LocalConditionProvider() {
    _localConditionService = LocalConditionService();
    this.all();
  }


  // getters
  List<Condition> get conditions => this._conditions;
  bool get isLoading => this._isLoading; 

  

  // add 
  void add({ Condition condition }) async {
    this._isLoading = true;
    notifyListeners();

    int id = await _localConditionService.add(
      condition: Condition.toMap(condition: condition)
    );
    
    condition.id = id;
    this._isLoading = false;
    this._conditions.add(condition);
    
    notifyListeners();
  }// void add({ Condition condition }) async { .. }


  // get all
  void all() async {
    this._isLoading = true;
    notifyListeners();

    List<Condition> conditns = await _localConditionService.all();
    
    this._isLoading = false;
    this._conditions = conditns;
    
    notifyListeners();
  }// void all() async { .. }


  // delete 
  void delete({ Condition condition }) async {
    this._isLoading = true;
    notifyListeners();

    _localConditionService.delete( condition: condition, );
    
    this._isLoading = false;
    this._conditions = this._conditions.where((Condition cond) {
       return cond.id != condition.id;
    }).toList();
    
    notifyListeners();
  }// void delete() async { .. }

}