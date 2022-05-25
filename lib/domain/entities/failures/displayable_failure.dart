class DisplayableFailure {
  DisplayableFailure({
    required this.title,
    required this.message,
  });

  DisplayableFailure.commonError([String? message])
      : title = 'Error',
  // TODO move this to strings file
        message = message ?? 'Something went wrong, please try again later'; // TODO move this to strings file

  String title;
  String message;
}
