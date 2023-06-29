const listUsersQuery = '''
  query ListUser {
    listUserModels {
      items {
        id
        name
      }
    }
  }
''';

const createUserQuery = '''
  mutation CreateUser(\$input: CreateUserModelInput!) {
    createUserModel(input: \$input) {
      id
      name
    }
  }
''';
