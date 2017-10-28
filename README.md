# Swift-Sass

The Swift-Sass repository is a wrapper around the LibSass C/C++ port of the Sass engine.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

**Note**: The following methods aren't working yet (see also [this](https://stackoverflow.com/questions/46990608/how-to-pass-a-swift-string-that-just-contains-white-spaces-to-a-c-method)):

```swift
func setIndent(_:String)
func setLinefeed(_:String)
```

### Prerequisites

To use this repository you need to install the LibSass Library first.

See [this](https://github.com/sass/libsass/blob/master/docs/build.md) instructions for building/installing LibSass.

### Installing

If you want to use Swift-Sass for example in your server-side Swift projects, all you have to do is add the dependency to your `Package.swift`:

```swift
.package( url: "https://github.com/robinwalterfit/Swift-Sass.git", from: "1.0.0" )
```

## Running the tests

The test are available for macOS through Xcode and haven't been optimized for Linux, yet.

All you have to do is edit the following lines according to your needs:

```swift
let inputPath: String  = "/Users/you/yourProjectsFolder/Swift-Sass/res/scss/style.scss"
let outputPath: String = "/Users/you/yourProjectsFolder/Swift-Sass/res/style"
```
Lines: 10 & 11 in ./Tests/SassTests/SassTests.swift

Just run the tests in Xcode or navigate to the project root folder in Terminal and execute:

```
$ swift test
```

### Break down into end to end tests

These tests uses some Scss files of your choice – *e.g. I chose [Bootstrap](https://github.com/twbs/bootstrap)* – and compile them with different options.

## Deployment

There should be nothing else to do for deployment :open_mouth:

## Built With

* [LibSass](https://github.com/sass/libsass) – The C/C++ port of the Sass engine
* [Swift-libsass](https://github.com/robinwalterfit/Swift-libsass) – The C library link
* [Swift PM](https://github.com/apple/swift-package-manager) – Dependency Management

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on my code of conduct, and the process for submitting pull requests to me.

## Versioning

I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/robinwalterfit/Swift-Sass/tags).

## Authors

* **Robin Walter** - *Initial work* - [robinwalterfit](https://github.com/robinwalterfit)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Checkout these amazing cheat sheets: [README-Template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2), [CONTRIBUTING-Template](https://gist.github.com/PurpleBooth/b24679402957c63ec426) & [GitHub Emojis](https://gist.github.com/rxaviers/7360908)
* Server-side Swift with **[Vapor](https://github.com/vapor/vapor)**, **[Perfect](https://github.com/PerfectlySoft/Perfect)**, **[Kitura](https://github.com/IBM-Swift/Kitura)** or **[Zewo](https://github.com/Zewo/Zewo)**
