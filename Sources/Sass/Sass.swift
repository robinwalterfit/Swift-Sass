
///
/// Sass.swift
/// Sass
///
/// Compile Sass/Scss with a Swift wrapper around LibSass.
///
/// - SeeAlso: https://github.com/sass/libsass
///
///
/// - Author: Robin Walter
/// - Version: 1.0.0
///

#if os( Linux )
    
    import SwiftGlibc
    
#else
    
    import Darwin
    
#endif

import Foundation

import libsass

/**
 The wrapper around `libsass`
 
 - Author: Robin Walter
 - Since: 1.0.0
 - Version: 1.0.0
 */
public final class Sass {
    
    /**
     Holds the context. Either `.file` or `.data`
     
     - Since: 1.0.0
     */
    let context: Sass.Context
    
    /**
     If `self.context = .data`: value is the Sass/Scss String
     
     - Since: 1.0.0
     */
    let inputData: String?
    
    /**
     If `self.context = .file`: value is the path to the .sass/.scss file
     
     - Since: 1.0.0
     */
    let inputFile: String?
    
    /**
     Holds the options for the current compile session
     
     - Since: 1.0.0
     */
    public let options: Sass.Options?
    
    /**
     The location for the output file
     
     - Since: 1.0.0
     */
    let outputFile: String
    
    /**
     The location for the source map file
     
     - Since: 1.0.0
     */
    var sourceMapFile: String?
    
    /**
     Returns the version of the Sass/Scss language
     
     - Since: 1.0.0
     
     - Returns: Sass/Scss version.
     */
    public static var libsassLangVersion: String {
        
        return String( validatingUTF8: libsass_language_version() ) ?? ""
        
    }
    
    /**
     Returns the version of the Sass/Scss compiler
     
     - Since: 1.0.0
     
     - Returns: Sass/Scss compiler version.
     */
    public static var libsassVersion: String {
        
        return String( validatingUTF8: libsass_version() ) ?? ""
        
    }
    
    /**
     Returns the version of Sass-to-Scss
     
     - Since: 1.0.0
     
     - Returns: Sass-to-Scss version.
     */
    public static var sass2ScssVersion: String {
        
        return String( validatingUTF8: sass2scss_version() ) ?? ""
        
    }
    
    /**
     Initializes a new `Sass` object
     
     - Since: 1.0.0
     
     - Parameter context: Default `.file`. Whether to compile from a file or a `String`.
     - Parameter input: Either the path to the Sass/Scss file or the Sass/Scss String.
     - Parameter outputFile: The output file.
     */
    public init( context: Sass.Context = .file, input: String, outputFile: String ) {
        
        self.context = context
        
        switch self.context {
            
            case .data:
                
                self.inputData = input
                self.inputFile = nil
            
            case .file:
                
                self.inputData = nil
                self.inputFile = input
            
        }
        
        self.options = Sass.Options()
        
        self.outputFile = outputFile
        
    }
    
    /**
     Initializes a new `Sass` object
     
     - Since: 1.0.0
     
     - Parameter context: Default `.file`. Whether to compile from a file or a `String`.
     - Parameter input: Either the path to the Sass/Scss file or the Sass/Scss String.
     - Parameter options: Set `Sass.Options` instead of creating new.
     - Parameter outputFile: The output file.
     */
    public init( context: Sass.Context = .file, input: String, options: Sass.Options, outputFile: String ) {
        
        self.context = context
        
        switch self.context {
            
        case .data:
            
            self.inputData = input
            self.inputFile = nil
            
        case .file:
            
            self.inputData = nil
            self.inputFile = input
            
        }
        
        self.options = options
        
        self.outputFile = outputFile
        
    }
    
    /**
     Deinitializes the `Sass` object
     
     - Since: 1.0.0
     - SeeAlso: `Sass.Options`
     */
    deinit {
        
        // Nothing to do
        
    }
    
    /**
     Cleans the memory that was stored for the C String.
     
     - Since: 1.0.0
     
     - Parameter t: The C String Touple.
     */
    internal func cleanConvertedString( _ t: ( UnsafeMutablePointer< Int8 >?, Int ) ) {
        
        if let cs = t.0, t.1 > 1 {
            
            cs.deinitialize( count: t.1 )
            cs.deallocate( capacity: t.1 )
            
        }
        
    }
    
    /**
     Compile the Sass/Scss source.
     
     - Since: 1.0.0
     */
    public func compile() throws {
        
        typealias Context = OpaquePointer
        
        var ctx: Context
        var ctxOut: Context
        
        self.options!.setOutputPath( self.outputFile )
        
        switch self.context {
            
            case .data:
                
                var data = self.convertString( self.inputData )
                defer {
                    
                    self.cleanConvertedString( data )
                    
                }
                ctx = sass_make_data_context( data.0! )
                defer {
                    
                    sass_delete_data_context( ctx )
                    
                }
                ctxOut = sass_data_context_get_context( ctx )
            
                sass_data_context_set_options( ctx, self.options!.options )
            
                sass_compile_data_context( ctx )
                
                let errorStatus: Int32? = sass_context_get_error_status( ctxOut )
                let errorMessage: String? = ( errorStatus != 0 ) ? String( validatingUTF8: sass_context_get_error_message( ctxOut ) ) : nil
                let outputString: String? = ( errorStatus == 0 ) ? String( validatingUTF8: sass_context_get_output_string( ctxOut ) ) : nil
                
                try self.output( errorStatus, errorMessage, outputString, self.outputFile )
            
            case .file:
                
                let srcMapFile: String? = self.options!.sourceMapFile
                
                ctx = sass_make_file_context( self.inputFile! )
                defer {
                    
                    sass_delete_file_context( ctx )
                    
                }
                ctxOut = sass_file_context_get_context( ctx )
                
                self.options!.setInputPath( self.inputFile! )
                
                sass_file_context_set_options( ctx, self.options!.options )
                
                sass_compile_file_context( ctx )
                
                let errorStatus: Int32? = sass_context_get_error_status( ctxOut )
                let errorMessage: String? = ( errorStatus != 0 ) ? String( validatingUTF8: sass_context_get_error_message( ctxOut ) ) : nil
                let outputString: String? = ( errorStatus == 0 ) ? String( validatingUTF8: sass_context_get_output_string( ctxOut ) ) : nil
                
                try self.output( errorStatus, errorMessage, outputString, self.outputFile )
                
                if srcMapFile != nil && !( srcMapFile?.isEmpty )! {
                    
                    let outputSourceMap: String? = String( validatingUTF8: sass_context_get_source_map_string( ctxOut ) )
                    
                    try self.output( errorStatus, errorMessage, outputSourceMap, srcMapFile! )
                    
                }
            
        }
        
    }
    
    /**
     Convert the String to a C String
     
     - Since: 1.0.0
     
     - Parameter s: The String to convert.
     - Returns: A Touple with the C String and the memory that was allocated.
     */
    internal func convertString( _ s: String? ) -> ( UnsafeMutablePointer< Int8 >?, Int ) {
        
        var cs: ( UnsafeMutablePointer< Int8 >?, Int ) = ( UnsafeMutablePointer< Int8 >( nil as OpaquePointer? ), 0 )
        guard let notNil = s else {
            
            return self.convertString( "" )
            
        }
        
        notNil.withCString { s in
            
            var i = 0
            
            while s[ i ] != 0 {
                
                i += 1
                
            }
            i += 1
            
            let allocated = UnsafeMutablePointer< Int8 >.allocate( capacity: i )
            allocated.initialize( to: 0 )
            
            for c in 0..<i {
                
                allocated[ c ] = s[ c ]
                
            }
            
            allocated[ i - 1 ] = 0
            
            cs = ( allocated, i )
            
        }
        
        return cs
        
    }
    
    /**
     Store the output as a file.
     
     - Since: 1.0.0
     
     - Parameter errorStatus: Optional. The error code.
     - Parameter errorMessage: Optional. The error message.
     - Parameter outputString: Optional. The String to print in the file.
     - Parameter outputFile: The file to store.
     */
    internal func output( _ errorStatus: Int32? = nil, _ errorMessage: String? = nil, _ outputString: String? = nil, _ outputFile: String ) throws {
        
        guard !outputFile.isEmpty else {
            
            throw Sass.Error( code: .unknown, reason: "The output file must not empty!" )
            
        }
        
        if errorStatus != 0 {
            
            if errorMessage != nil {
                
                throw Sass.Error( code: errorStatus!, reason: errorMessage! )
                
            }
            else {
                
                throw Sass.Error( code: errorStatus!, reason: "No available error message." )
                
            }
            
        }
        else if outputString != nil {
            
            let fm = FileManager.default
            let data = ( outputString! as NSString ).data( using: String.Encoding.utf8.rawValue )
            
            if fm.fileExists( atPath: outputFile ) {
                
                if fm.isWritableFile( atPath: outputFile ) {
                    
                    fm.createFile( atPath: outputFile, contents: data, attributes: nil )
                    
                }
                else {
                    
                    throw Sass.Error( code: .unknown, reason: "File isn't writable!" )
                    
                }
                
            }
            else {
                
                fm.createFile( atPath: outputFile, contents: data, attributes: nil )
                
            }
            
        }
        else {
            
            throw Sass.Error( code: .unknown, reason: "Unknown internal error." )
            
        }
        
    }
    
    /**
     Set some default options
     
     - Since: 1.0.0
     - Warning: You have to call this before `compile()`!
     
     - Parameter isSass: Default: false. True = Sass; false = Scss
     - Parameter development: Default: false. True if the compiled file is used for development.
     */
    public func setDefaultOptions( isSass: Bool = false, development: Bool = false ) {
        
        self.options!.setIsIndentedSyntaxSrc( isSass )
        self.options!.setOmitSourceMapUrl( !development )
        self.options!.setOutputStyle( development ? .nested : .compressed )
        self.options!.setPrecision( 5 )
        self.options!.setSourceComments( development )
        self.options!.setSourceMapContents( false )
        self.options!.setSourceMapEmbed( false )
        if development {
            
            self.setSourceMapFile()
            
        }
        self.options!.setSourceMapFileUrls( false )
        
    }
    
    /**
     Sets the source map file.
     
     - Since: 1.0.0
     - Warning: You have to call this before `compile()`!
     */
    public func setSourceMapFile() {
        
        self.sourceMapFile = self.outputFile + ".map"
        
        self.options!.setSourceMapFile( self.sourceMapFile! )
        
    }
    
    /**
     An `enum` with the Sass compiling context
     
     - Since: 1.0.0
     - SeeAlso: https://github.com/sass/libsass/blob/master/docs/api-doc.md#compiling-your-code
     */
    public enum Context {
        
        case data
        case file
        
    }
    
    /**
     A list of all error messages that can be thrown.
     
     All Error objects contain a `String` which contains the last error message.
     
     - Since: 1.0.0
     */
    public struct Error: Swift.Error {
        
        /**
         Inherits the error code
         
         - Since: 1.0.0
         */
        public let code: Sass.Error.Code
        
        /**
         Inherits error message
         
         - Since: 1.0.0
         */
        public let reason: String
        
        /**
         Initializes a new `Sass.Error`
         
         - Since: 1.0.0
         - SeeAlso: `Sass.Error.Code`
         
         - Parameter code: The error code.
         - Parameter reason: The error message.
         */
        public init( code: Sass.Error.Code, reason: String ) {
            
            self.code   = code
            self.reason = reason
            
        }
        
        /**
         Initializes a new `Sass.Error`
         
         - Since: 1.0.0
         - SeeAlso: `Sass.Error.Code`
         
         - Parameter code: The error code as `Int`.
         - Parameter reason: The error message.
         */
        public init( code: Int32, reason: String ) {
            
            self.code   = Sass.Error.Code( rawValue: code ) ?? .unknown
            self.reason = reason
            
        }
        
        /**
         An `enum` with the Sass error codes
         
         - Since: 1.0.0
         - SeeAlso: https://github.com/sass/libsass/blob/master/docs/api-doc.md#error-codes
         */
        public enum Code: Int32 {
            
            case normal         = 1 // normal errors like parsing or `eval` errors
            case badAllocation  = 2 // bad allocation error (memory error)
            case untranslated   = 3 // "untranslated" C++ exception (`throw std::exception`)
            case legacyString   = 4 // legacy string exceptions (`throw const char*` or `std::string`)
            case unknown        = 5 // Some other unknown exception
            
        }
        
    }
    
    /**
     The `Sass.Options` object holds the the compiling options.
     
     - Since: 1.0.0
     */
    public final class Options {
        
        public typealias SassOptions = OpaquePointer
        
        /**
         The C Wrapper around `Sass_Options`
         
         - Since: 1.0.0
         */
        public let options: SassOptions
        
        /**
         Initializes a new `Sass.Options` object
         
         - Since: 1.0.0
         */
        public init() {
            
            self.options = sass_make_options()
            
        }
        
        /**
         Deinitializes the `Sass.Options` object
         
         - Since: 1.0.0
         */
        deinit {
            
            self.delete()
            
        }
        
    }
    
}
