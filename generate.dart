import 'dart:io';

// Main function to run the project generator
void main() async {
  print('Starting project structure generation...');

  // Create the base project directory structure
  await createProjectStructure();

  // Read the source code file
  final sourceCode = await File('paste.txt').readAsString();

  // Split and distribute the code to appropriate files
  await distributeCode(sourceCode);

  print('Project structure generation completed successfully!');
}

// Create the basic project directory structure
Future<void> createProjectStructure() async {
  // Define the directories to create
  final directories = [
    'lib',
    'lib/enums',
    'lib/models',
    'lib/widgets',
    'lib/helpers',
    'lib/painters',
  ];

  // Create each directory
  for (final dir in directories) {
    final directory = Directory(dir);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      print('Created directory: $dir');
    }
  }
}

// Distribute the code into appropriate files
Future<void> distributeCode(String sourceCode) async {
  // Create enums file
  await writeEnumsFile(sourceCode);

  // Create models files
  await writeCardColorModelFile();
  await writeCardColorsFile();

  // Create confetti particle and painter
  await writeConfettiParticleFile(sourceCode);

  // Create helper
  await writeConfettiHelperFile(sourceCode);

  // Create dialog
  await writeConfettiDialogFile(sourceCode);

  // Create trigger button
  await writeConfettiTriggerButtonFile(sourceCode);

  // Create main app
  await writeMainAppFile(sourceCode);
}

// Write enums to a dedicated file
Future<void> writeEnumsFile(String sourceCode) async {
  final enumRegex =
      RegExp(r'enum ConfettiType[\s\S]*?(?=\n\n)', multiLine: true);
  final match =
      enumRegex.allMatches(sourceCode).map((m) => m.group(0)).join('\n\n');

  final enumFileContent = '''
/// File containing all enumerations for confetti functionality

$match
''';

  await File('lib/enums/confetti_enums.dart').writeAsString(enumFileContent);
  print('Created file: lib/enums/confetti_enums.dart');
}

// Write card color model (placeholder as it's imported)
Future<void> writeCardColorModelFile() async {
  final cardColorModelContent = '''
import 'package:flutter/material.dart';

/// Card color model that defines the color scheme for a card
class CardColorModel {
  final Color card;
  final Color shadow;
  final Color text;

  const CardColorModel({
    required this.card,
    required this.shadow,
    required this.text,
  });
}
''';

  await File('lib/models/card_color_model.dart')
      .writeAsString(cardColorModelContent);
  print('Created file: lib/models/card_color_model.dart');
}

// Write card colors (placeholder as it's imported)
Future<void> writeCardColorsFile() async {
  final cardColorsContent = '''
import 'package:flutter/material.dart';
import 'card_color_model.dart';

/// Collection of card color schemes
class CardColors {
  // Primary colors
  static const CardColorModel orangePrimary = CardColorModel(
    card: Color(0xFFF8A13F),
    shadow: Color(0xFFC77321),
    text: Color(0xFF4A2E0C),
  );
  
  static const CardColorModel tealPrimary = CardColorModel(
    card: Color(0xFF3FB8F8),
    shadow: Color(0xFF2189C7),
    text: Color(0xFF0C344A),
  );
  
  static const CardColorModel bluePrimary = CardColorModel(
    card: Color(0xFF3F7AF8),
    shadow: Color(0xFF214DC7),
    text: Color(0xFF0C1E4A),
  );
  
  static const CardColorModel purplePrimary = CardColorModel(
    card: Color(0xFF7A3FF8),
    shadow: Color(0xFF4D21C7),
    text: Color(0xFF1E0C4A),
  );
  
  static const CardColorModel pinkPrimary = CardColorModel(
    card: Color(0xFFF83FCC),
    shadow: Color(0xFFC721A5),
    text: Color(0xFF4A0C3F),
  );
  
  static const CardColorModel magentaPrimary = CardColorModel(
    card: Color(0xFFF83F7A),
    shadow: Color(0xFFC7214D),
    text: Color(0xFF4A0C1E),
  );
  
  static const CardColorModel redPrimary = CardColorModel(
    card: Color(0xFFF83F3F),
    shadow: Color(0xFFC72121),
    text: Color(0xFF4A0C0C),
  );
  
  static const CardColorModel yellowPrimary = CardColorModel(
    card: Color(0xFFF8DC3F),
    shadow: Color(0xFFC7B021),
    text: Color(0xFF4A420C),
  );
  
  static const CardColorModel limePrimary = CardColorModel(
    card: Color(0xFFCAF83F),
    shadow: Color(0xFF9FC721),
    text: Color(0xFF374A0C),
  );
  
  static const CardColorModel lightGreenPrimary = CardColorModel(
    card: Color(0xFF8AF83F),
    shadow: Color(0xFF64C721),
    text: Color(0xFF214A0C),
  );
  
  static const CardColorModel greenPrimary = CardColorModel(
    card: Color(0xFF3FF83F),
    shadow: Color(0xFF21C721),
    text: Color(0xFF0C4A0C),
  );
  
  static const CardColorModel grayPrimary = CardColorModel(
    card: Color(0xFFAAAAAA),
    shadow: Color(0xFF777777),
    text: Color(0xFF333333),
  );
}
''';

  await File('lib/models/card_colors.dart').writeAsString(cardColorsContent);
  print('Created file: lib/models/card_colors.dart');
}

// Write confetti particle and painter code
Future<void> writeConfettiParticleFile(String sourceCode) async {
  final particleRegex =
      RegExp(r'class ConfettiParticle[\s\S]*?^}', multiLine: true);
  final painterRegex =
      RegExp(r'class ConfettiPainter[\s\S]*?^}', multiLine: true);

  final particleMatch = particleRegex.firstMatch(sourceCode)?.group(0) ?? '';
  final painterMatch = painterRegex.firstMatch(sourceCode)?.group(0) ?? '';

  final particleFileContent = '''
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../enums/confetti_enums.dart';

/// Confetti particle and painter classes

$particleMatch

$painterMatch
''';

  await File('lib/painters/confetti_painter.dart')
      .writeAsString(particleFileContent);
  print('Created file: lib/painters/confetti_painter.dart');
}

// Write confetti helper code
Future<void> writeConfettiHelperFile(String sourceCode) async {
  final helperRegex =
      RegExp(r'class ConfettiHelper[\s\S]*?^}', multiLine: true);
  final helperMatch = helperRegex.firstMatch(sourceCode)?.group(0) ?? '';

  final helperFileContent = '''
import 'package:flutter/material.dart';
import '../enums/confetti_enums.dart';
import '../widgets/confetti_dialog.dart';

/// Helper class to show confetti dialogs

$helperMatch
''';

  await File('lib/helpers/confetti_helper.dart')
      .writeAsString(helperFileContent);
  print('Created file: lib/helpers/confetti_helper.dart');
}

// Write confetti dialog code
Future<void> writeConfettiDialogFile(String sourceCode) async {
  final dialogRegex = RegExp(
      r'class ConfettiDialog[\s\S]*?(?=class ConfettiParticle)',
      multiLine: true);
  final dialogMatch = dialogRegex.firstMatch(sourceCode)?.group(0) ?? '';

  // Remove final } that was captured in the regex if needed
  final cleanedContent =
      dialogMatch.endsWith('}') ? dialogMatch : dialogMatch + '}';

  final dialogFileContent = '''
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../enums/confetti_enums.dart';
import '../models/card_color_model.dart';
import '../models/card_colors.dart';
import '../painters/confetti_painter.dart';

/// Widget that renders the confetti animation dialog

$cleanedContent
''';

  await File('lib/widgets/confetti_dialog.dart')
      .writeAsString(dialogFileContent);
  print('Created file: lib/widgets/confetti_dialog.dart');
}

// Write confetti trigger button code
Future<void> writeConfettiTriggerButtonFile(String sourceCode) async {
  final triggerRegex =
      RegExp(r'class ConfettiTriggerButton[\s\S]*?^}', multiLine: true);
  final triggerMatch = triggerRegex.firstMatch(sourceCode)?.group(0) ?? '';

  final triggerFileContent = '''
import 'package:flutter/material.dart';
import '../enums/confetti_enums.dart';
import '../helpers/confetti_helper.dart';

/// Example trigger button widget

$triggerMatch
''';

  await File('lib/widgets/confetti_trigger_button.dart')
      .writeAsString(triggerFileContent);
  print('Created file: lib/widgets/confetti_trigger_button.dart');
}

// Write main app code
Future<void> writeMainAppFile(String sourceCode) async {
  final mainAppRegex =
      RegExp(r'void main\(\)[\s\S]*?(?=\/\/)', multiLine: true);
  final mainAppMatch = mainAppRegex.firstMatch(sourceCode)?.group(0) ?? '';

  // Extract MainApp class
  final mainAppClassRegex = RegExp(r'class MainApp[\s\S]*?^}', multiLine: true);
  final mainAppClassMatch =
      mainAppClassRegex.firstMatch(sourceCode)?.group(0) ?? '';

  // Extract ConfettiTestPage
  final testPageRegex =
      RegExp(r'class ConfettiTestPage[\s\S]*?^}', multiLine: true);
  final testPageMatch = testPageRegex.firstMatch(sourceCode)?.group(0) ?? '';

  final mainFileContent = '''
import 'package:flutter/material.dart';
import 'enums/confetti_enums.dart';
import 'helpers/confetti_helper.dart';

/// Main application and example test page

$mainAppMatch

$testPageMatch

$mainAppClassMatch
''';

  await File('lib/main.dart').writeAsString(mainFileContent);
  print('Created file: lib/main.dart');
}
