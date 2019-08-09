#!/usr/bin/env sh
# This script generates the protobuf implementations for iOS and Dart
# Android uses the Gradle Protoc plugin and will auto generate when needed
# Recently Flutter master merged a feature to auto run code gen.
# Until that feature is made GA this script must be called after updating
# any Proto files or pulling code with updates.

if [ ! -d ./lib ]; then
    echo "Script must be called from project package directory"
    exit 1
fi

if [ ! -d ./lib/gen ]; then
  mkdir -p ./lib/gen
fi

if [ "$(uname)" = "Darwin" ]; then
  echo "Geneating Swift protobuf's"

  if [ ! -d ./iOS/Classes ]; then
    mkdir -p ./iOS/Classes
  fi

  find ./protos -type f -name '**.proto' | tee /dev/tty | \
    xargs protoc --swift_out=./ios/Classes
else
  echo "Skipping Swift protobuf's generation on Linux for now."
fi

echo "Geneating Dart protobuf's"
find ./protos -type f -name '**.proto' | tee /dev/tty | \
  xargs protoc --dart_out=./lib/gen
