#!/usr/bin/env sh

if [ ! -d ./scripts ]; then
  # PRs welcome to make this more flexible
  echo "Scripts must be run from the project root dir"
  exit 1
fi

echo "sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer"
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

echo "Running brew"
brew -v || {
  echo "Brew no installed. Downloading Brew now"
  # TODO Add linux brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
brew update
brew bundle --file=./scripts/brew/flutter
if [ ! -d "$HOME/.cocoapods" ]; then
  pod setup
fi

flutterHome="$HOME/Library/flutter"
if [ ! -d "$HOME/Library/flutter" ]; then
  printf "Default Flutter home not found.\n Installing lastest stable flutter."
  git clone git@github.com:flutter/flutter.git "$flutterHome"
fi

path="$PATH"
case ":$PATH:" in
  *:"$flutterHome/bin":*)
    echo "Flutter path is ready to go.";;
  *)
    echo "Installing Flutter and Dart SDK env PATH for bash and zsh"
    flutterPath="
# Flutter
export PATH=\"\$PATH:\$HOME/Library/flutter/bin:\$HOME/Library/flutter/bin/cache/dart-sdk/bin:\$HOME/.pub-cache/bin\"
"
    echo "$flutterPath" >> "$HOME/.zshrc"
    echo "$flutterPath" >> "$HOME/.bash_profile"
    path="$PATH:$flutterHome/bin";;
esac

export PATH="$path"

echo "Accept Android licenses"
flutter doctor --android-licenses
echo "Install Dart protoc plugin"
flutter pub global activate protoc_plugin
