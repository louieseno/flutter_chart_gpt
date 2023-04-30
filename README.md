# Flutter Chart GPT

A Flutter app that build charts based on text input using AI.

## Install dependencies by running:

```bash
cd <PROJECT_FOLDER>
flutter pub get
```

## Setup .env file:

- Copy .env.example into .env. Your .env file should be at the project root like this:

```
OPEN_API_KEY=""
```

- Then generate `env.g.dart` file by running:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

:bangbang: If you will encounter any problem like `env` is not updating, try troubleshooting by:

- Delete the env.g.dart file and re-run the command to generate.

- Cleaning all the generated files and purge the code-gen cache and re-run the command after to generate.

```
flutter pub run build_runner clean
```
