import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

T getProvider<T>(BuildContext context, {bool listen = false}){
  return Provider.of<T>(context,listen: listen);
}