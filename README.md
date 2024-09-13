## About

Swiftmission is a collection of bugfixes for Transmission (a BitTorrent client).

### Differences with Transmission 4.0.6
Current fixes in Swiftmission 4.0.7-beta.1 included in the coeur/4.0.x_ALL_FIXES branch:
* 4.0.x backport of [fix: crash in `tr_torrent::VerifyMediator::on_verify_done()` #6918](https://github.com/transmission/transmission/pull/6918)
* 4.0.x backport of [fix: loading `2.20-3.00` progress from resume #6896](https://github.com/transmission/transmission/pull/6896)
* 4.0.x backport of [fix: don't process http announce error if already succeeded #7086](https://github.com/transmission/transmission/pull/7086)

### Differences with Transmission 4.1.0
See the readme from the coeur/ALL_FIXES branch.

## Building

### Cloning Transmission from Git
For the 4.0.x bugfixes:
```console
git clone --recurse-submodules https://github.com/coeur/transmission --branch coeur/4.0.x_ALL_FIXES Transmission
```

For the 4.1.x bugfixes:
```console
git clone --recurse-submodules https://github.com/coeur/transmission --branch coeur/ALL_FIXES Transmission
```

### Building for macOS

Multiple solutions.

From an IDE with the Xcode project:
- Open Transmission.xcodeproj
- Run the Transmission scheme

From the command line with xcodebuild:
```console
cmake -B build -G Xcode -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -t transmission-mac # uses xcodebuild under the hood
open ./build/macosx/Debug/Transmission.app
```

From the command line with ninja:
```console
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -t transmission-mac # uses ninja under the hood
open ./build/macosx/Transmission.app
```

### Building for other platforms

With GTK:
```
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DENABLE_GTK=ON -DENABLE_MAC=OFF
cmake --build build -t transmission-gtk
./build/gtk/transmission-gtk
```

With Qt:
```
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DENABLE_QT=ON -DENABLE_MAC=OFF
cmake --build build -t transmission-qt
./build/qt/transmission-qt
```
