// swift-tools-version:4.0

import PackageDescription

let package = Package(
    
    name: "Sass",
    products: [
        
        .library( name: "Sass", targets: [ "Sass" ] )
        
    ],
    dependencies: [
        
        .package( url: "https://github.com/robinwalterfit/Swift-libsass.git", from: "1.0.0" )
        
    ],
    targets: [
        
        .target( name: "Sass", dependencies: [] ),
        .testTarget( name: "SassTests", dependencies: [ "Sass" ] )
        
    ]
    
)
