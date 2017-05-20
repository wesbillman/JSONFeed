[![Build Status](https://travis-ci.org/wesbillman/JSONFeed.svg?branch=master)](https://travis-ci.org/wesbillman/JSONFeed)
[![Codecov](https://img.shields.io/codecov/c/github/wesbillman/JSONFeed.svg)](https://codecov.io/gh/wesbillman/JSONFeed)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)

# JSONFeed

Swift parsing for [JSON Feed](https://jsonfeed.org/) [Spec](https://jsonfeed.org/version/1)

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

## Usage

> See [JSONFeedTests](https://github.com/wesbillman/JSONFeed/blob/master/JSONFeedTests/JSONFeedTests.swift) for detailed usage examples

#### Load a feed from a dictionary

```swift
let dictionary = <some feed dictionary>
let feed = try? JSONFeed(json: dictionary)
```

#### Load a feed from data

```swift
let data = <some feed data>
let feed = try? JSONFeed(data: data)
```

#### Load a feed from a json ut8f string

```swift
let string = <some utf8 json string>
let feed = try? JSONFeed(string: string)
```
### Reading from a feed via URLSession

Using default configuration and URLSession
```swift
let reader = JSONFeedReader()
reader.read(string: "https://jsonfeed.org/feed.json") { (feed, error) in
    if let error = error {
        //bad things happened
    }

    if let feed = feed {
        //good things happened
    }
}
```

Using custom implemenation of URLSession (example: for unit testing)
```swift
let reader = JSONFeedReader(session: SomeCustomURLSession)
reader.read(string: "https://jsonfeed.org/feed.json") { (feed, error) in
    if let error = error {
        //bad things happened
    }

    if let feed = feed {
        //good things happened
    }
}
```
