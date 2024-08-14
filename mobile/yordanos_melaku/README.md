eCommerce App
This is a simple eCommerce UI built with Flutter. The UI allows users to search products, view product details, add products to a cart, update product and delete product.

Setup

Prerequisites:
   Flutter SDK
   Dart SDK

After cloning the project:
   1. go to the ecommerce directory:
            git clone <repository-url>
            cd ecommerce
   2. flutter pub get
   3. flutter run

Project Structure:

Domain Layer
The domain layer contains the core business logic and entities of the application. It defines the entities, use cases, and repository interfaces. The goal is to encapsulate the business logic separately from the data source.

Entities: Represent the core data models of the application.
Use Cases: Implement the business logic by interacting with repository interfaces.
Repositories: Define the contract that data sources must implement.
Data Layer
The data layer manages data operations and implements repository interfaces defined in the domain layer. It handles data retrieval, transformation, and storage.

Models: Data models used for JSON serialization and deserialization.
Repositories: Concrete implementations of repository interfaces.
Data Sources: Manage data input and output operations, e.g., API calls or local storage.
Testing
The project uses unit testing to ensure the correctness of the domain and data layers. Tests validate that the business logic, data models, and repository implementations work as expected.

Unit Tests: Verify individual components, such as use cases, data models, and repository methods.
Fixtures: Provide sample JSON data for testing purposes.