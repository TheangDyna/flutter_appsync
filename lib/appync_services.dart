import 'package:amplify_flutter/amplify_flutter.dart';

Future<dynamic> listItems(String request) async {
  try {
    final response = await Amplify.API
        .query(
          request: GraphQLRequest(
            document: request,
          ),
        )
        .response;
    final responseData = response.data;
    if (responseData == null) {
      safePrint('Response errors: ${response.errors}');
    }
    return responseData;
  } on ApiException catch (e) {
    safePrint('Query failed: $e');
    return;
  }
}

Future<dynamic> createItem(String request, dynamic variables) async {
  try {
    final response = await Amplify.API
        .mutate(
          request: GraphQLRequest(
            document: request,
            variables: variables,
          ),
        )
        .response;

    final responseData = response.data;
    if (responseData == null) {
      safePrint('Response errors: ${response.errors}');
    }
    return responseData;
  } on ApiException catch (e) {
    safePrint('Mutate failed: $e');
    return;
  }
}
