import 'dart:io';

import 'package:args/args.dart';
import 'package:template_automation/template_automation_commands.dart';

bool generateOnlyFeatureFolder = false;

const List<String> coreFolders = [
  '/config/theme',
  '/config/routes',
  '/core/constants',
  '/core/error',
  '/core/util'
];

List<String> featureFolders(String featureFolderName) => [
 '/features/$featureFolderName/data/data_sources',
  '/features/$featureFolderName/data/models',
  '/features/$featureFolderName/data/repositories',
  '/features/$featureFolderName/presentation/pages',
  '/features/$featureFolderName/presentation/widgets',
  '/features/$featureFolderName/presentation/bloc',
  '/features/$featureFolderName/domain/entities',
  '/features/$featureFolderName/domain/repositories',
  '/features/$featureFolderName/domain/usecases',
];

void createFolderStructure(ArgResults args) async {
  if(args.flag(onlyFeature)) {
    generateOnlyFeatureFolder = true;
  }

  if(args.option(targetDirectory) == null) {
    throw Exception('Target directory cannot be empty');
  }
  
  if (!generateOnlyFeatureFolder) {
    for (String folder in coreFolders) {
      await Directory('${args.option(targetDirectory)}$folder').create(recursive: true);
    }
  }

  if(args.option(featureFolderName) == null) {
    throw Exception('Name for feature folder cannot be empty');
  }

  for (String folder in featureFolders(args.option(featureFolderName)!)) {
    await Directory('${args.option(targetDirectory)}$folder').create(recursive: true);
  }

  print('Folder structure create successfully');
}

void help() {
  print('Create clean architecture folder structure \n Usage: \n template_automation [arguments] \n -h, --help Prints this help info \n -t Specifies the target directory \n -f Specifies the feature folder name \n -o, --only-feature If set, only the feature directory will be create, useful if you already have /core and /config in your project');
}
