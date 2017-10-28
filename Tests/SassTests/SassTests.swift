
import Foundation
import XCTest
@testable import Sass

class SassTests: XCTestCase {
    
    let fm = FileManager.default
    
    let inputPath: String  = "/Users/you/yourProjectsFolder/Swift-Sass/res/scss/style.scss"
    let outputPath: String = "/Users/you/yourProjectsFolder/Swift-Sass/res/style"
    
    public func printVersions() {
        
        print( Sass.libsassVersion )
        print( Sass.libsassLangVersion )
        print( Sass.sass2ScssVersion )
        
    }
    
    public func proofVariables( options: Sass.Options ) {
        
        let indent              = options.indent
        let isIndentedSyntaxSrc = options.isIndentedSyntaxSrc
        let linefeed            = options.linefeed
        let omitSourceMapUrl    = options.omitSourceMapUrl
        let outputStyle         = options.outputStyle!
        let precision           = options.precision
        let sourceComments      = options.sourceComments
        let sourceMapContents   = options.sourceMapContents
        let sourceMapEmbed      = options.sourceMapEmbed
        let sourceMapFile       = options.sourceMapFile
        let sourceMapFileUrls   = options.sourceMapFileUrls
        let sourceMapRoot       = options.sourceMapRoot
        
        print( "Indent: '\( indent )'" )
        print( "Is indented syntax source: \( isIndentedSyntaxSrc )" )
        print( "Line feed: '\( linefeed )'" )
        print( "Omit source map url: \( omitSourceMapUrl )" )
        print( "Output style: \( outputStyle )" )
        print( "Precision: \( precision )" )
        print( "Source comments: \( sourceComments )" )
        print( "Source map contents: \( sourceMapContents )" )
        print( "Source map embed: \( sourceMapEmbed )" )
        print( "Source map file: \( sourceMapFile )" )
        print( "Source map file urls: \( sourceMapFileUrls )" )
        print( "Source map root: \( sourceMapRoot )" )
        
    }
    
    public func testCompactFile() {
        
        print( "Test compact file" )
        
        let output = self.outputPath + ".compact.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        sassOptions.setOutputStyle( .compact )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.compact )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( true )
        XCTAssertTrue( sassOptions.sourceComments )
        sass.setSourceMapFile()
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testCompressedFile() {
        
        print( "Test compressed file" )
        
        let output = self.outputPath + ".compressed.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        sassOptions.setOutputStyle( .compressed )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.compressed )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( true )
        XCTAssertTrue( sassOptions.sourceComments )
        sass.setSourceMapFile()
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testDataContext() {
        
        print( "Test data context" )
        
        let output = self.outputPath + ".data.css"
        let input: String = """
"""
        
        let sass = Sass( context: .data, input: input, outputFile: output )
        sass.setDefaultOptions()
        
        self.proofVariables( options: sass.options! )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testDefaultOptions() {
        
        print( "Test default options" )
        
        let output = self.outputPath + ".css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        sass.setDefaultOptions()
        
        self.proofVariables( options: sass.options! )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testExpandedFile() {
        
        print( "Test expanded file" )
        
        let output = self.outputPath + ".expanded.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        // sassOptions.setIndent( "\t" )
        // XCTAssertEqual( sassOptions.indent, "\t" )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        // sassOptions.setLinefeed( "\n" )
        // XCTAssertEqual( sassOptions.linefeed, "\n" )
        sassOptions.setOutputStyle( .expanded )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.expanded )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( true )
        XCTAssertTrue( sassOptions.sourceComments )
        sass.setSourceMapFile()
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testNestedFile() {
        
        print( "Test nested file" )
        
        let output = self.outputPath + ".nested.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        sassOptions.setOutputStyle( .nested )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.nested )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( true )
        XCTAssertTrue( sassOptions.sourceComments )
        sass.setSourceMapFile()
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testNoSourceComments() {
        
        print( "Test no source comments" )
        
        let output = self.outputPath + ".nosrccomments.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        sassOptions.setOutputStyle( .nested )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.nested )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( false )
        XCTAssertFalse( sassOptions.sourceComments )
        sass.setSourceMapFile()
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
    public func testNoSourceMapFile() {
        
        print( "Test no source map file" )
        
        let output = self.outputPath + ".nosrcmap.css"
        
        let sass = Sass( context: .file, input: self.inputPath, outputFile: output )
        
        let sassOptions = sass.options!
        XCTAssertNotNil( sassOptions )
        sassOptions.setIsIndentedSyntaxSrc( false )
        XCTAssertFalse( sassOptions.isIndentedSyntaxSrc )
        sassOptions.setOmitSourceMapUrl( true )
        XCTAssertTrue( sassOptions.omitSourceMapUrl )
        sassOptions.setOutputStyle( .nested )
        XCTAssertEqual( sassOptions.outputStyle, Sass.Options.Style.nested )
        sassOptions.setPrecision( 5 )
        XCTAssertEqual( sassOptions.precision, 5 )
        sassOptions.setSourceComments( true )
        XCTAssertTrue( sassOptions.sourceComments )
        
        self.proofVariables( options: sassOptions )
        
        do {
            
            try sass.compile()
            
        }
        catch {
            
            print( error )
            
        }
        
    }
    
}
