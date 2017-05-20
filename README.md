[![Build Status](https://travis-ci.org/wesbillman/JSONFeed.svg?branch=master)](https://travis-ci.org/wesbillman/JSONFeed)
[![Codecov](https://img.shields.io/codecov/c/github/wesbillman/JSONFeed.svg)](https://codecov.io/gh/wesbillman/JSONFeed)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)

### JSONFeed

Swift parsing for [JSON Feed](https://jsonfeed.org/)

## Installation

### Carthage

You can install [Carthage](https://github.com/Carthage/Carthage) with [Homebrew](http://brew.sh/) using the following command:

```bash
brew update
brew install carthage
```
To integrate JSONFeed into your Xcode project using Carthage, specify it in your `Cartfile` where `"x.x.x"` is the current release:

```ogdl
github "wesbillman/JSONFeed" "x.x.x"
```

### Swift Package Manager

To install using [Swift Package Manager](https://swift.org/package-manager/) have your Swift package set up, and add JSONFeed as a dependency to your `Package.swift`.

```swift
dependencies: [
    .Package(url: "https://github.com/wesbillman/JSONFeed.git", majorVersion: 0)
]
```

### Manually
Add all the files from `JSONFeed/JSONFeed` to your project
