## About

Swiftmission is a fork of Transmission (BitTorrent client) written in Swift for macOS.

### Differences with Transmission
* Swiftmission is partially converted from ObjC++ to Swift (https://github.com/transmission/transmission/pull/4540)
* Swiftmission automatically verifies downloads on completion (https://github.com/transmission/transmission/pull/4178)
* Swiftmission adds stats for known peers (https://github.com/transmission/transmission/pull/4900)

## Building

Transmission has an Xcode project file (Transmission.xcodeproj) for building in Xcode.

For a more detailed description, and dependencies, visit [How to Build Transmission](docs/Building-Transmission.md) in docs

### Cloning Transmission from Git
```console
git clone --recurse-submodules https://github.com/coeur/transmission Transmission
```

### Building the native app with Xcode
Transmission has an Xcode project file for building in Xcode.
- Open Transmission.xcodeproj
- Run the Transmission scheme

### Building Transmission from the command line

With Xcode (recommended):
```console
cmake -B build -G Xcode -DCMAKE_BUILD_TYPE=RelWithDebInfo
xcodebuild -project build/transmission.xcodeproj -target transmission-mac
open ./build/macosx/Debug/Transmission.app
```

With Ninja (experimental):
```console
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
ninja -C build transmission-mac
open ./build/macosx/Transmission.app
```
