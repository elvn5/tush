import 'dart:io';

// ignore_for_file: avoid_print

void main() {
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('Error: pubspec.yaml not found');
    exit(1);
  }

  final lines = pubspecFile.readAsLinesSync();
  final newLines = <String>[];
  bool versionUpdated = false;

  for (final line in lines) {
    if (line.trim().startsWith('version:') && !versionUpdated) {
      final parts = line.split(':');
      if (parts.length > 1) {
        final versionString = parts[1].trim();
        final versionParts = versionString.split('+');
        if (versionParts.length == 2) {
          final versionNumber = versionParts[0];
          final buildNumber = int.tryParse(versionParts[1]);
          if (buildNumber != null) {
            final newBuildNumber = buildNumber + 1;
            final newVersion = '$versionNumber+$newBuildNumber';
            newLines.add('version: $newVersion');
            print('Updated version to: $newVersion');
            versionUpdated = true;
            continue;
          }
        }
      }
    }
    newLines.add(line);
  }

  if (versionUpdated) {
    pubspecFile.writeAsStringSync('${newLines.join('\n')}\n');
  } else {
    print('Error: Could not find or parse version in pubspec.yaml');
    exit(1);
  }
}
