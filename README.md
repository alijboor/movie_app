Movie Explorer App

Overview

The Movie Explorer App is a Flutter-based application that allows users to browse, search, and explore movies. It utilizes the TMDB API to fetch movie data, enabling users to view detailed information about movies and manage a favorites list.

Features

Display movies with pagination.

Real-time search functionality.

View detailed movie information including poster, title, description, release date, and rating.

Favorites management using local storage.

Responsive design for phones and tablets.

Usage
Discover Screen: Browse movies and TV shows. Use the search bar to find specific titles.

Favorites Screen: View and manage your list of favorite movies.

Top-Rated Movies Screen: Explore a list of top-rated movies.

Movie Details Screen: Click on any movie to view detailed information, add it to favorites, or rate it.


Setup Instructions

1. Clone the Repository

Clone this repository to your local machine:

git clone https://github.com/alijboor/movie_app
cd movie-explorer-app

2. Install Dependencies

Ensure you have Flutter installed on your system. Then, install the required dependencies by running:

flutter pub get

3. Obtain an API Key

The app uses the TMDB API to fetch movie data. Follow these steps to get an API key:

Create an account on The Movie Database (TMDB).

Navigate to your account settings and generate an API key.

Open the file lib/core/constant/api_routes.dart and replace c9496b30a9a46289893ee73bfe6c2ad2 with your TMDB API key in line 2:

const String _apiKey = 'c9496b30a9a46289893ee73bfe6c2ad2';

4. Run the App

To run the app on an emulator or connected device:

flutter run

5. Optional: Build for Release

To generate a release APK for distribution:

flutter build apk --release

Dependencies

The app uses the following dependencies:

provider for state management

http for API communication

shared_preferences for local storage

Ensure these dependencies are installed via pubspec.yaml.

Third-Party Packages
The app uses the following third-party packages:

flutter_bloc: For state management using the BLoC pattern.

http: For making API requests to TMDb.

cached_network_image: For caching and displaying images from the network.

flutter_rating_bar: For implementing the rating feature.

equatable: For simplifying equality comparisons in BLoC.



Contact

For questions or contributions, please contact:

Name: Ali jboor

Email: alijboor.1992@gmail.com

GitHub: [Ali Jboor](https://github.com/alijboor)

