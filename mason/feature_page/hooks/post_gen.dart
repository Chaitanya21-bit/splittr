import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runBuildRunner(context);
  await _runDartFormat(context);
  context.logger.info('${context.vars['feature_name']} folder created!');
}

Future<void> _runBuildRunner(HookContext context) async {
  final formatProgress = context.logger.progress('Running build runner');
  final buildRunnerProcess = await Process.run(
    'dart',
    [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ],
    workingDirectory: '../../',
  );
  formatProgress.complete();

  if (buildRunnerProcess.stderr.toString().isNotEmpty) {
    context.logger.info('ERROR: ${buildRunnerProcess.stderr}');
  }

  if (buildRunnerProcess.stdout.toString().isNotEmpty) {
    context.logger.info(buildRunnerProcess.stdout.toString());
  }
}

Future<void> _runDartFormat(HookContext context) async {
  final formatProgress = context.logger.progress('Running dart format');
  final buildRunnerProcess = await Process.run(
    'dart',
    [
      'format',
      'lib/',
    ],
    workingDirectory: '../../',
  );
  formatProgress.complete();

  if (buildRunnerProcess.stderr.toString().isNotEmpty) {
    context.logger.info('ERROR: ${buildRunnerProcess.stderr}');
  }

  if (buildRunnerProcess.stdout.toString().isNotEmpty) {
    context.logger.info(buildRunnerProcess.stdout.toString());
  }
}
