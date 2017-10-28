
///
/// Sass+Options.swift
/// Sass
///
/// Compile Sass/Scss with a Swift wrapper around libsass.
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
 The `Sass.Options` object holds the the compiling options.
 
 - Since: 1.0.0
 */
extension Sass.Options {
        
    /**
     Returns the indent of the `Sass.Options` object
     
     - Since: 1.0.0
     
     - Returns: `indent` String.
     */
    public var indent: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_indent( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Returns true for Sass and false for Scss
     
     - Since: 1.0.0
     
     - Returns: True Sass; false Scss
     */
    public var isIndentedSyntaxSrc: Bool {
        
        return sass_option_get_is_indented_syntax_src( self.options )
        
    }
    
    /**
     Returns the path of the source file
     
     - Since: 1.0.0
     
     - Returns: Path of the source file.
     */
    internal var inputPath: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_input_path( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Returns the linefeed
     
     - Since: 1.0.0
     
     - Returns: Linefeed.
     */
    public var linefeed: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_linefeed( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Returns whether the source map url comment should be omitted
     
     - Since: 1.0.0
     
     - Returns: True if source map url should be omitted.
     */
    public var omitSourceMapUrl: Bool {
        
        return sass_option_get_omit_source_map_url( self.options )
        
    }
    
    /**
     Returns the path of the output file
     
     - Since: 1.0.0
     
     - Returns: Path of the compiled file.
     */
    internal var outputPath: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_output_path( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Returns the output style of the compiled file
     
     - Since: 1.0.0
     - SeeAlso: `Sass.Options.Style`
     
     - Returns: The output style.
     */
    public var outputStyle: Sass.Options.Style? {
        
        let outputStyle = sass_option_get_output_style( self.options )
        
        switch outputStyle {
            
            case SASS_STYLE_COMPACT:
                
                return .compact
            
            case SASS_STYLE_COMPRESSED:
                
                return .compressed
            
            case SASS_STYLE_EXPANDED:
                
                return .expanded
            
            case SASS_STYLE_NESTED:
                
                return .nested
            
            default:
                
                return nil
            
        }
        
    }
    
    /**
     Returns the precision of numbers
     
     - Since: 1.0.0
     
     - Returns: Precision of numbers.
     */
    public var precision: Int32 {
        
        return Int32( sass_option_get_precision( self.options ) )
        
    }
    
    /**
     Returns true if source comments should be added
     
     - Since: 1.0.0
     
     - Returns: True if source comments should be added.
     */
    public var sourceComments: Bool {
        
        return sass_option_get_source_comments( self.options )
        
    }
    
    /**
     Returns true if source map contents should be added
     
     - Since: 1.0.0
     
     - Returns: True if source map contents should be added.
     */
    public var sourceMapContents: Bool {
        
        return sass_option_get_source_map_contents( self.options )
        
    }
    
    /**
     Returns true if the source map file should be embedded
     
     - Since: 1.0.0
     
     - Returns: True if source map file should be embedded.
     */
    public var sourceMapEmbed: Bool {
        
        return sass_option_get_source_map_embed( self.options )
        
    }
    
    /**
     Returns the source map file
     
     - Since: 1.0.0
     
     - Returns: Source map file.
     */
    public var sourceMapFile: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_source_map_file( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Returns true if source map file urls should be added
     
     - Since: 1.0.0
     
     - Returns: True if source map file urls should be added.
     */
    public var sourceMapFileUrls: Bool {
        
        return sass_option_get_source_map_file_urls( self.options )
        
    }
    
    /**
     Returns the source map root
     
     - Since: 1.0.0
     
     - Returns: Source map root.
     */
    public var sourceMapRoot: String {
        
        let cString: UnsafePointer< Int8 >? = sass_option_get_source_map_root( self.options )
        
        guard cString != nil else {
            
            return ""
            
        }
        
        return String( validatingUTF8: cString! ) ?? ""
        
    }
    
    /**
     Frees the memory used for C `Sass_Options`
     
     - Since: 1.0.0
     */
    public func delete() {
        
        sass_delete_options( self.options )
        
    }
    
    /**
     Push the include path
     
     - Since: 1.0.0
     
     - Parameter path: The path to push.
     */
    public func pushIncludePath( _ path: String ) {
        
        sass_option_push_include_path( self.options, path )
        
    }
    
    /**
     Push the plugin path
     
     - Since: 1.0.0
     
     - Parameter path: The plugin path.
     */
    public func pushPluginPath( _ path: String ) {
        
        sass_option_push_plugin_path( self.options, path )
        
    }
    
    /**
     Set the indent
     
     - Since: 1.0.0
     
     - Parameter string: The indent.
     */
    public func setIndent( _ indent: String ) {
        
        sass_option_set_indent( self.options, indent )
        
    }
    
    /**
     Set the input path
     
     - Since: 1.0.0
     
     - Parameter path: The path to set.
     */
    internal func setInputPath( _ path: String ) {
        
        sass_option_set_input_path( self.options, path )
        
    }
    
    /**
     Declare Sass/Scss
     
     - Since: 1.0.0
     
     - Parameter bool: True = Sass; false = Scss
     */
    public func setIsIndentedSyntaxSrc( _ sass: Bool ) {
        
        sass_option_set_is_indented_syntax_src( self.options, sass )
        
    }
    
    /**
     Sets the linefeed
     
     - Since: 1.0.0
     
     - Parameter string: The linefeed.
     */
    public func setLinefeed( _ string: String ) {
        
        sass_option_set_linefeed( self.options, string )
        
    }
    
    /**
     Set to true to omit the source map url comment
     
     - Since: 1.0.0
     
     - Parameter bool: True to omit source map url.
     */
    public func setOmitSourceMapUrl( _ bool: Bool ) {
        
        sass_option_set_omit_source_map_url( self.options, bool )
        
    }
    
    /**
     Sets the output path
     
     - Since: 1.0.0
     
     - Parameter path: The output path.
     */
    internal func setOutputPath( _ path: String ) {
        
        sass_option_set_output_path( self.options, path )
        
    }
    
    /**
     Sets the output style
     
     - Since: 1.0.0
     - SeeAlso: `Sass.Options.Style`
     
     - Parameter style: The output style.
     */
    public func setOutputStyle( _ style: Sass.Options.Style ) {
        
        var outputStyle: Sass_Output_Style
        
        switch style {
            
            case .compact:
                
                outputStyle = SASS_STYLE_COMPACT
            
            case .compressed:
                
                outputStyle = SASS_STYLE_COMPRESSED
            
            case .expanded:
                
                outputStyle = SASS_STYLE_EXPANDED
            
            case .nested:
                
                outputStyle = SASS_STYLE_NESTED
            
        }
        
        sass_option_set_output_style( self.options, outputStyle )
        
    }
    
    /**
     Sets the precision of numbers
     
     - Since: 1.0.0
     
     - Parameter i: The precision of numbers.
     */
    public func setPrecision( _ i: Int32 ) {
        
        sass_option_set_precision( self.options, i )
        
    }
    
    /**
     Set to true to add source comments
     
     - Since: 1.0.0
     
     - Parameter bool: True to add source comments.
     */
    public func setSourceComments( _ bool: Bool ) {
        
        sass_option_set_source_comments( self.options, bool )
        
    }
    
    /**
     Set to true to add source map contents
     
     - Since: 1.0.0
     
     - Parameter bool: True to add source map comments.
     */
    public func setSourceMapContents( _ bool: Bool ) {
        
        sass_option_set_source_map_contents( self.options, bool )
        
    }
    
    /**
     Set to true to embed the source map
     
     - Since: 1.0.0
     
     - Parameter bool: True to embed source map.
     */
    public func setSourceMapEmbed( _ bool: Bool ) {
        
        sass_option_set_source_map_embed( self.options, bool )
        
    }
    
    /**
     Set the source map file
     
     - Since: 1.0.0
     
     - Parameter file: The source map file.
     */
    internal func setSourceMapFile( _ file: String ) {
        
        sass_option_set_source_map_file( self.options, file )
        
    }
    
    /**
     Set to true to add source map file urls
     
     - Since: 1.0.0
     
     - Parameter bool: True to add source map file urls.
     */
    public func setSourceMapFileUrls( _ bool: Bool ) {
        
        sass_option_set_source_map_file_urls( self.options, bool )
        
    }
    
    /**
     Set the source map root
     
     - Since: 1.0.0
     
     - Parameter path: The source map root.
     */
    public func setSourceMapRoot( _ path: String ) {
        
        sass_option_set_source_map_root( self.options, path )
        
    }
    
    /**
     The `Sass.Options` object holds the the compiling options.
     
     - Since: 1.0.0
     */
    public enum Style {
        
        case compact
        case compressed
        case expanded
        case nested
        
    }
    
}
