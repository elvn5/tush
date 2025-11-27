---
trigger: always_on
---

Flutter Expert Developer - Project Rules

You are an expert Flutter Engineer with deep knowledge of Clean Architecture, SOLID principles, and the specific tech stack defined below.

Tech Stack & Libraries

Language: Dart (Latest version)

Framework: Flutter (Latest version)

State Management: flutter_bloc

Data Classes/Unions: freezed (+ json_serializable)

Value Equality: equatable

Navigation: auto_route

Dependency Injection: get_it (with injectable assumed for generation)

Networking: dio (HTTP client) & graphql (API)

Backend: AWS (Amplify/Lambda integration)

1. Architectural Standards

Feature-First Structure: Organize code by features, not by layer.

Example: lib/features/auth/ containing presentation/, domain/, data/.

Clean Architecture Layers:

Data: DTOs (Data Transfer Objects), Data Sources (API calls), Repositories Implementation.

Domain: Entities, Repositories Interfaces, UseCases.

Presentation: BLoCs, Pages, Widgets.

Repository Pattern: Always use Repositories to abstract data fetching. BLoCs strictly talk to Repositories/UseCases, never directly to Dio or GraphQL.

2. Library-Specific Implementation Rules

A. State Management (flutter_bloc + freezed)

Unions for State: ALWAYS use freezed unions for BLoC States.

Standard pattern: \_Initial, \_Loading, \_Success(Data data), \_Failure(String message).

Events: Use freezed unions for Events as well.

BLoC Logic:

Use on<Event> handlers.

Never perform business logic inside the UI.

Use BlocConsumer or BlocBuilder in the UI.

Example:

@freezed
class AuthState with \_$AuthState {
const factory AuthState.initial() = \_Initial;
const factory AuthState.loading() = \_Loading;
const factory AuthState.authenticated(User user) = \_Authenticated;
}

B. Navigation (auto_route)

Annotations: ALWAYS use @RoutePage() for screens/pages.

Navigation Calls: Use context.router.push(RouteName()) or context.router.replace(...).

Arguments: Pass arguments strictly via the generated Route classes.

Setup: Do not use Navigator 1.0 or 2.0 directly. Rely on StackRouter.

C. Dependency Injection (get_it + injectable)

Registration: Use @injectable, @singleton, or @lazySingleton annotations on classes.

Injection:

Use constructor injection for BLoCs, Repositories, and UseCases.

Example: AuthBloc(this.\_authRepository) : super(const \_Initial());

Retrieval: In the UI, use GetIt.I<T>() or context.read<T>() (if provided via BlocProvider).

D. Networking (Dio + GraphQL)

Client: Configure a single Dio instance with interceptors (logging, auth token injection) and register it via GetIt.

GraphQL:

If using dio as the transport for GraphQL, ensure requests are typed correctly.

Handle GraphQLError exceptions specifically within the Data layer and map them to domain Failures.

AWS:

Abstract AWS SDK calls behind a DataSource interface. Do not call AWS SDKs directly from the Domain layer.

E. Data Models (freezed & equatable)

Immutability: All domain entities and data models must be immutable.

Equality Choice:

Use freezed for DTOs, Unions, and Complex State (where copyWith or JSON serialization is heavily used).

Use equatable for Simple Domain Entities if you prefer to avoid code generation for pure business objects.

Serialization: Use @freezed with fromJson for API responses.

Examples:

Freezed (DTOs):

@freezed
class UserDTO with \_$UserDTO {
const factory UserDTO({
required String id,
required String email,
}) = \_UserDTO;

factory UserDTO.fromJson(Map<String, dynamic> json) => \_$UserDTOFromJson(json);
}

Equatable (Simple Entity):

class User extends Equatable {
final String id;
final String name;

const User({required this.id, required this.name});

@override
List<Object?> get props => [id, name];
}

3. Coding Style & Formatting

Null Safety: Strict null safety. Avoid ! (bang operator) unless absolutely certain. Use ?. and ??.

Async: Use async/await syntax instead of .then().

Widgets:

Extract complex widgets into smaller, private classes or separate files.

Use const constructors for Widgets whenever possible.

Typing: Explicitly type variables when the type is not immediately obvious. return types for functions are mandatory.

4. Code Generation Handling

Build Runner: Acknowledge that this stack relies heavily on code generation.

When creating files for bloc, models, or routes, always immediately add the part directives:

part 'filename.freezed.dart';

part 'filename.g.dart'; (if json serialization is needed)

part 'filename.gr.dart'; (for routes)

5. Error Handling

Result Type: (Optional but recommended) Use Either<Failure, Success> (using fpdart or dartz) for Repository return types to handle errors functionally.

Catching: Catch exceptions in the Data layer (DataSource/RepositoryImp) and map them to Domain Failures. Never let a raw Dio error reach the UI.

Notification: user should be notified about errors coming from API via flutter toast

6. Testing

Write tests using bloc_test for BLoCs.

Mock dependencies using mocktail or mockito.

CRITICAL INSTRUCTION:
When generating code, always verify imports. If a class relies on freezed or auto*route generation, assume the generated file exists or will be generated, and write the code accordingly (using the *$ClassName mixins).

7. Theme

Use colors only from Theme