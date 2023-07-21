# GitHub Public Repositories Finder

This application is designed to have a single endpoint that receives a GitHub username and, in the background, searches the user's public repositories using [GitHub's REST API](https://docs.github.com/en/rest/overview/resources-in-the-rest-api). It then saves the repository name and the number of stars it has in a database.

## Features

- Exposes an endpoint to find public repositories of a GitHub user.
- Utilizes Sidekiq for background job processing.
- Includes comprehensive test coverage using RSpec.

## Getting Started

Follow the steps below to set up and run the application on your local machine:

### Prerequisites

- Ruby (v3.2.2)
- Rails (v7.0.6)
- Redis (for Sidekiq background processing)

### Installation

1. Clone this repository to your local machine.

2. Install the required gems:

```
$ bundle install
```

3. Set up the database:

```
$ rails db:setup
```

4. Start the Sidekiq worker:

```
$ bundle exec sidekiq
```

5. Start the Rails server:

```
$ rails server
```

## Usage

To find the public repositories of a GitHub user, make a POST request to the following endpoint:

```
POST /github/repositories
```

Include the GitHub username as a parameter in the request body. The application will enqueue a background job using Sidekiq to search for the user's public repositories on GitHub. The repository names and the number of stars will be saved in the database.

## Testing

This application includes comprehensive test coverage using RSpec. To run the tests, execute the following command:

```
$ bundle exec rspec
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

---
