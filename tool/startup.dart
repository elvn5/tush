import 'dart:io';

// ignore_for_file: avoid_print

void main(List<String> args) async {
  // Parse CLI arguments
  String? cliStage;
  for (var i = 0; i < args.length; i++) {
    if ((args[i] == '--stage' || args[i] == '-s') && i + 1 < args.length) {
      cliStage = args[i + 1];
      break;
    }
  }

  String? appEnv = cliStage;

  if (appEnv == null) {
    final envFile = File('.env');
    if (envFile.existsSync()) {
      final lines = await envFile.readAsLines();
      for (final line in lines) {
        if (line.trim().startsWith('APP_ENV=')) {
          appEnv = line.split('=')[1].trim();
          break;
        }
      }
    }
  }

  if (appEnv == null || appEnv.isEmpty) {
    print(
      '❌ Error: APP_ENV not found in .env file and no --stage flag provided.',
    );
    exit(1);
  }

  print('🚀 Detected Environment: $appEnv');

  if (appEnv == 'prod') {
    print('⚠️  WARNING: You are about to deploy/run in PRODUCTION.');
    stdout.write('Are you sure you want to continue? (y/N): ');
    final input = stdin.readLineSync();
    if (input?.toLowerCase() != 'y') {
      print('🚫 Operation cancelled.');
      exit(0);
    }
  }

  // Run SST Dev
  print('Starting SST in $appEnv mode...');

  // We need to run this from the backend directory
  final backendDir = 'backend';

  final process = await Process.start(
    'npx',
    ['sst', 'dev', '--stage', appEnv],
    workingDirectory: backendDir,
    mode: ProcessStartMode.inheritStdio,
  );

  // Watch for changes in .sst/outputs.json
  final outputsFile = File('$backendDir/.sst/outputs.json');
  print('👀 Watching for changes in ${outputsFile.path}...');

  // Initial check if file exists and run update immediately if it does
  // (Optional, but good if restarting dev without redeploying)
  if (outputsFile.existsSync()) {
    _runUpdateConfig(backendDir);
  }

  // Poll for changes (FileSystemWatcher can be flaky on some systems, polling is safer for this specific use case)
  // Or use FileSystemWatcher
  final watcher = outputsFile.parent.watch(events: FileSystemEvent.modify);
  watcher.listen((event) {
    if (event.path.endsWith('outputs.json')) {
      print('🔄 Detected change in outputs.json. Updating Flutter config...');
      // Give a small delay for write to complete
      Future.delayed(Duration(milliseconds: 500), () {
        _runUpdateConfig(backendDir);
      });
    }
  });

  final exitCode = await process.exitCode;
  exit(exitCode);
}

void _runUpdateConfig(String workingDir) {
  Process.run('npm', [
    'run',
    'update-flutter-config',
  ], workingDirectory: workingDir).then((result) {
    if (result.exitCode == 0) {
      print('✅ Flutter config updated successfully.');
    } else {
      print('❌ Failed to update Flutter config:');
      print(result.stderr);
    }
  });
}
