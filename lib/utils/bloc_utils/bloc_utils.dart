import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

B getBloc<B extends BaseBloc>(
  BuildContext context,
) =>
    BlocProvider.of<B>(context);
