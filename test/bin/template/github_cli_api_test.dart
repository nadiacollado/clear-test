import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../bin/template/github_cli_api.dart';
import '../../../bin/utils/cli_utils.dart';

class MockCliUtils extends Mock implements CliUtils {}

void main() {
  late GithubCliApi githubApi;
  late CliUtils cliUtils;

  setUp(() {
    cliUtils = MockCliUtils();
    githubApi = GithubCliApi(cliUtils: cliUtils);
  });

  group('GithubCliApi', () {
    test('runGithubCli calls cliUtils.runCommand with correct arguments',
        () async {
      const List<String> arguments = <String>['arg1', 'arg2'];
      when(() => cliUtils.runCommand('gh', arguments: arguments))
          .thenAnswer((_) async => 'test result');

      final String result = await githubApi.runGithubCli(arguments);
      expect(result, 'test result');
      verify(() => cliUtils.runCommand('gh', arguments: arguments)).called(1);
    });

    test('accessGithubApi calls runGithubCli with correct arguments', () async {
      const List<String> arguments = <String>['api', 'arg1', 'arg2'];
      when(() => cliUtils.runCommand('gh', arguments: arguments))
          .thenAnswer((_) async => 'test result');

      final String result =
          await githubApi.accessGithubApi(arguments.sublist(1));
      expect(result, 'test result');
      verify(() => cliUtils.runCommand('gh', arguments: arguments)).called(1);
    });

    test('createEnvironmentConfigJson returns correct JSON string', () async {
      final String result = await githubApi.createEnvironmentConfigJson();
      final Map<String, dynamic> decodedResult =
          jsonDecode(result) as Map<String, dynamic>;

      expect(decodedResult, <String, Map<String, bool>>{
        'deployment_branch_policy': <String, bool>{
          'protected_branches': false,
          'custom_branch_policies': true,
        },
      });
    });

    test(
        'sendJsonToGithubApiEndpoint calls accessGithubApi with correct arguments',
        () async {
      const String endpoint = '/repos/test/repo/environments/dev';
      const String jsonString = '{"key": "value"}';
      when(
        () => cliUtils.runCommand(
          'gh',
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((Invocation invocation) async => 'test result');

      final String result =
          await githubApi.sendJsonToGithubApiEndpoint(endpoint, jsonString);

      expect(result, 'test result');

      final List<String> capturedArguments = verify(
        () => cliUtils.runCommand(
          'gh',
          arguments: captureAny(named: 'arguments'),
        ),
      ).captured.single as List<String>;

      expect(capturedArguments, contains('api'));
      expect(capturedArguments, containsAll(GithubCliApi.acceptJsonHeader));
      expect(capturedArguments, containsAll(GithubCliApi.contentJsonHeader));
      expect(capturedArguments, contains('-X'));
      expect(capturedArguments, contains('PUT'));
      expect(capturedArguments, contains(endpoint));
      expect(capturedArguments, contains('--input'));
      expect(
        capturedArguments.last,
        endsWith('temp_json_data.json'),
      );
    });

    test(
        'createEnvironment calls sendJsonToGithubApiEndpoint with correct arguments',
        () async {
      const String repoFullName = 'test/repo';
      const String environmentName = 'dev';
      when(
        () => cliUtils.runCommand(
          'gh',
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((Invocation invocation) async => 'test result');

      final String result =
          await githubApi.createEnvironment(repoFullName, environmentName);

      expect(result, 'test result');

      final List<String> capturedArguments = verify(
        () => cliUtils.runCommand(
          'gh',
          arguments: captureAny(named: 'arguments'),
        ),
      ).captured.single as List<String>;

      expect(capturedArguments, contains('api'));
      expect(capturedArguments, containsAll(GithubCliApi.acceptJsonHeader));
      expect(capturedArguments, containsAll(GithubCliApi.contentJsonHeader));
      expect(capturedArguments, contains('-X'));
      expect(capturedArguments, contains('PUT'));
      expect(
        capturedArguments,
        contains('/repos/$repoFullName/environments/$environmentName'),
      );
      expect(capturedArguments, contains('--input'));
      expect(capturedArguments.last, endsWith('temp_json_data.json'));
    });

    test(
        'createDevQaProdEnvironments calls createEnvironment for each environment',
        () async {
      const String repoFullName = 'test/repo';
      when(
        () => cliUtils.runCommand(
          'gh',
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((Invocation invocation) async => 'test result');

      final String result =
          await githubApi.createDevQaProdEnvironments(repoFullName);

      expect(result, 'test result\ntest result\ntest result');

      verify(
        () => cliUtils.runCommand(
          'gh',
          arguments: any(named: 'arguments'),
        ),
      ).called(3);
    });
  });
}
