import 'package:args/args.dart';
import 'package:template_automation/template_automation.dart' as template_automation;
import 'package:template_automation/template_automation_commands.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(targetDirectory, defaultsTo: '.', abbr: 't')
    ..addOption(featureFolderName, defaultsTo: 'example', abbr: 'f')
    ..addFlag(onlyFeature, negatable: false, abbr: 'o')
    ..addFlag(help, negatable: false, abbr: 'h');

  ArgResults argResults = parser.parse(arguments);

  if (argResults.flag(help)) {
    template_automation.help();
  } else {
    template_automation.createFolderStructure(argResults);
  }
}


