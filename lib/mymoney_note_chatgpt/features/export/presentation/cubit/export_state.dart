import 'dart:io';

abstract class ExportState {}

class ExportInitial extends ExportState {}

class ExportLoading extends ExportState {}

class ExportSuccess extends ExportState {
  final File file;
  ExportSuccess(this.file);
}

class ExportError extends ExportState {
  final String message;
  ExportError(this.message);
}
