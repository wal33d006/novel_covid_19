import 'package:flutter/material.dart';
import 'package:novel_covid_19/domain/entities/failures/displayable_failure.dart';

mixin ErrorDialogRoute<T> {
  BuildContext get context;

  Future<void> showError(DisplayableFailure failure) => showDialog(
        context: context,
        builder: (context) => ErrorDialog(failure: failure),
      );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.failure,
    Key? key,
  }) : super(key: key);

  final DisplayableFailure failure;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(failure.title),
      content: Text(failure.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'),
        )
      ],
    );
  }
}
