import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T value, Widget? child)? builder;
  final T controller;
  const BaseView({Key? key, this.builder, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ChangeNotifierProvider<T>(
        create: (_) => controller,
        child: Consumer<T>(
          builder: builder!,
        ),
      ),
    );
  }
}