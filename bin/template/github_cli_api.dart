import 'dart:convert';

import '../utils/cli_utils.dart';
import '../utils/io_utils.dart';

enum Method {
  post,
  put;

  String get value => name.toUpperCase();
}

class GithubCliApi {
  GithubCliApi({CliUtils? cliUtils}) : _cli = cliUtils ?? CliUtils();

  final CliUtils _cli;

  static const List<String> acceptJsonHeader = <String>[
    '-H',
    'Accept: application/vnd.github+json',
  ];
  static const List<String> contentJsonHeader = <String>[
    '-H',
    'Content-Type: application/json',
  ];

  Future<String> runGithubCli(List<String> arguments) async {
    return _cli.runCommand('gh', arguments: arguments);
  }

  Future<String> accessGithubApi(List<String> arguments) async {
    return runGithubCli(<String>['api', ...arguments]);
  }

  Future<String> createEnvironmentConfigJson() async {
    final Map<String, Map<String, bool>> config = <String, Map<String, bool>>{
      'deployment_branch_policy': <String, bool>{
        'protected_branches': false,
        'custom_branch_policies': true,
      },
    };
    return jsonEncode(config);
  }

  Future<String> sendJsonToGithubApiEndpoint(
    String endpoint,
    String jsonString, [
    Method? method,
  ]) async {
    method ??= Method.put;

    final File tempFile =
        await File('temp_json_data.json').writeAsString(jsonString);
    final String result = await accessGithubApi(<String>[
      ...acceptJsonHeader,
      ...contentJsonHeader,
      '-X',
      method.value,
      endpoint,
      '--input',
      tempFile.path,
    ]);
    tempFile.deleteSync();
    return result;
  }

  Future<String> createEnvironment(
    String repoFullName,
    String environmentName,
  ) async {
    final String configJson = await createEnvironmentConfigJson();
    return sendJsonToGithubApiEndpoint(
      '/repos/$repoFullName/environments/$environmentName',
      configJson,
    );
  }

  Future<String> createDevQaProdEnvironments(String repoFullName) async {
    final String devEnvironment = await createEnvironment(repoFullName, 'dev');
    final String qaEnvironment = await createEnvironment(repoFullName, 'qa');
    final String prodEnvironment =
        await createEnvironment(repoFullName, 'prod');
    return '$devEnvironment\n$qaEnvironment\n$prodEnvironment';
  }
}
