/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

// Original - Christopher Lloyd <cjwl@objc.net>
#import <AppKit/NSFont.h>
#import <AppKit/NSWindow.h>
#import <AppKit/NSGraphicsContextFunctions.h>
#import <AppKit/CoreGraphics.h>
#import <AppKit/NSDisplay.h>
#import <AppKit/NSNibKeyedUnarchiver.h>

FOUNDATION_EXPORT char *NSUnicodeToSymbol(const unichar *characters,unsigned length,
  BOOL lossy,unsigned *resultLength,NSZone *zone);


@implementation NSFont

+(float)systemFontSize {
   return 12.0;
}

+(float)smallSystemFontSize {
   NSUnimplementedMethod();
   return 0;
}

+(float)labelFontSize {
   return 12.0;
}

+(float)systemFontSizeForControlSize:(NSControlSize)size {
   NSUnimplementedMethod();
   return 0;
}

+(NSFont *)boldSystemFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial Bold" size:(size==0)?[self systemFontSize]:size];
}

+(NSFont *)controlContentFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)labelFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?[self labelFontSize]:size];
}

+(NSFont *)menuFontOfSize:(float)size {
   float     pointSize=0;
   NSString *name=[[NSDisplay currentDisplay] menuFontNameAndSize:&pointSize];

   return [NSFont fontWithName:name size:(size==0)?pointSize:size];
}

+(NSFont *)menuBarFontOfSize:(float)size {
   return [self menuFontOfSize:size];
}

+(NSFont *)messageFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)paletteFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)systemFontOfSize:(float)size {
   return [self messageFontOfSize:size];
}

+(NSFont *)titleBarFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)toolTipsFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)userFontOfSize:(float)size {
   return [NSFont fontWithName:@"Arial" size:(size==0)?12.0:size];
}

+(NSFont *)userFixedPitchFontOfSize:(float)size {
   return [NSFont fontWithName:@"Courier New" size:(size==0)?12.0:size];
}

+(void)setUserFont:(NSFont *)value {
   NSUnimplementedMethod();
}

+(void)setUserFixedPitchFont:(NSFont *)value {
   NSUnimplementedMethod();
}

-(void)encodeWithCoder:(NSCoder *)coder {
   NSUnimplementedMethod();
}

-(NSString *)_translateNibFontName:(NSString *)name {

   if([name isEqual:@"Helvetica"])
    return @"Arial";
   if([name isEqual:@"Helvetica-Bold"])
    return @"Arial Bold";
   if([name isEqual:@"Helvetica-Oblique"])
    return @"Arial Italic";
   if([name isEqual:@"Helvetica-BoldOblique"])
    return @"Arial Bold Italic";

   if([name isEqual:@"Times-Roman"])
    return @"Times New Roman";
   if([name isEqual:@"Ohlfs"])
    return @"Courier New";
   if([name isEqual:@"Courier"])
    return @"Courier New";

   if([name isEqual:@"Symbol"])
    return name;

   return name;
}

-initWithCoder:(NSCoder *)coder {
   if([coder isKindOfClass:[NSNibKeyedUnarchiver class]]){
    NSNibKeyedUnarchiver *keyed=(NSNibKeyedUnarchiver *)coder;
    NSString          *name=[self _translateNibFontName:[keyed decodeObjectForKey:@"NSName"]];
    float              size=[keyed decodeFloatForKey:@"NSSize"];
    // int                flags=[keyed decodeIntForKey:@"NSfFlags"]; // ?
    
    [self dealloc];
    
    return [[NSFont fontWithName:name size:size] retain];
   }
   else {
    [NSException raise:NSInvalidArgumentException format:@"%@ can not initWithCoder:%@",isa,[coder class]];
   }
   return nil;
}


-initWithName:(NSString *)name size:(float)size {
   _name=[name copy];
   _pointSize=size;
   _matrix[0]=_pointSize;
   _matrix[1]=0;
   _matrix[2]=0;
   _matrix[3]=_pointSize;
   _matrix[4]=0;
   _matrix[5]=0;

   if([_name isEqualToString:@"Symbol"])
    _encoding=NSSymbolStringEncoding;
   else
    _encoding=NSUnicodeStringEncoding;

   [[NSDisplay currentDisplay] addFontToCache:self];
   
   _kgFont=[[KGFont alloc] initWithName:_name size:_pointSize];

   return self;
}

-(void)dealloc {
   [[NSDisplay currentDisplay] removeFontFromCache:self];

   [_name release];
   [_kgFont release];
   [super dealloc];
}

+(NSFont *)fontWithName:(NSString *)name size:(float)size {
   NSFont *result;

   if(name==nil)
    [NSException raise:NSInvalidArgumentException format:@"-[%@ %s] name==nil",self,SELNAME(_cmd)];

   result=[[NSDisplay currentDisplay] cachedFontWithName:name size:size];

   if(result==nil)
    result=[[[NSFont alloc] initWithName:name size:size] autorelease];

   return result;
}

+(NSFont *)fontWithName:(NSString *)name matrix:(const float *)matrix {
   return [self fontWithName:name size:matrix[0]];
}

+(NSFont *)fontWithDescriptor:(NSFontDescriptor *)descriptor size:(float)size {
   NSUnimplementedMethod();
   return 0;
}

+(NSFont *)fontWithDescriptor:(NSFontDescriptor *)descriptor size:(float)size textTransform:(NSAffineTransform *)transform {
   NSUnimplementedMethod();
   return 0;
}

-copyWithZone:(NSZone *)zone {
   return [self retain];
}

-(float)pointSize {
   return _pointSize;
}

-(NSString *)fontName {
   return _name;
}

-(const float *)matrix {
   return _matrix;
}

-(NSAffineTransform *)textTransform {
   NSAffineTransform      *result=[NSAffineTransform transform];
   NSAffineTransformStruct fields={
    _matrix[0],_matrix[1],_matrix[2],
    _matrix[3],_matrix[4],_matrix[5],
   };
   
   [result setTransformStruct:fields];

   return result;
}

-(NSFontRenderingMode)renderingMode {
   NSUnimplementedMethod();
   return 0;
}

-(NSCharacterSet *)coveredCharacterSet {
   NSUnimplementedMethod();
   return nil;
}

-(NSStringEncoding)mostCompatibleStringEncoding {
   return _encoding;
}

-(NSString *)familyName {
   NSUnimplementedMethod();
   return nil;
}

-(NSString *)displayName {
   NSUnimplementedMethod();
   return nil;
}

-(NSFontDescriptor *)fontDescriptor {
   NSUnimplementedMethod();
   return nil;
}

-(NSFont *)printerFont {
   NSUnimplementedMethod();
   return nil;
}

-(NSFont *)screenFont {
   return self;
}

-(NSFont *)screenFontWithRenderingMode:(NSFontRenderingMode)mode {
   NSUnimplementedMethod();
   return nil;
}

-(NSRect)boundingRectForFont {
   return [_kgFont boundingRect];
}

-(NSRect)boundingRectForGlyph:(NSGlyph)glyph {
   NSUnimplementedMethod();
   return NSMakeRect(0,0,0,0);
}

-(NSMultibyteGlyphPacking)glyphPacking {
   return NSNativeShortGlyphPacking;
}

-(unsigned)numberOfGlyphs {
   return [_kgFont numberOfGlyphs];
}

-(NSGlyph)glyphWithName:(NSString *)name {
   NSUnimplementedMethod();
   return 0;
}

-(BOOL)glyphIsEncoded:(NSGlyph)glyph {
   return [_kgFont glyphIsEncoded:glyph];
}

-(NSSize)advancementForGlyph:(NSGlyph)glyph {
   return [_kgFont advancementForGlyph:glyph];
}

-(NSSize)maximumAdvancement {
   return [_kgFont maximumAdvancement];
}

-(float)underlinePosition {
   return [_kgFont underlinePosition];
}

-(float)underlineThickness {
   return [_kgFont underlineThickness];
}

-(float)ascender {
   return [_kgFont ascender];
}

-(float)descender {
   return [_kgFont descender];
}

-(float)leading {
   return [_kgFont leading];
}

-(float)defaultLineHeightForFont {
   return [_kgFont ascender]-[_kgFont descender]+[_kgFont leading];
}

-(BOOL)isFixedPitch {
   return [_kgFont isFixedPitch];
}

-(float)italicAngle {
   return [_kgFont italicAngle];
}

-(float)xHeight {
   return [_kgFont xHeight];
}

-(float)capHeight {
   return [_kgFont capHeight];
}

-(void)setInContext:(NSGraphicsContext *)context {
   CGContextRef cgContext=[context graphicsPort];
   
   CGContextSetFont(cgContext,_kgFont);

// FIX, should check the focusView in the context instead of NSView's
   if([[NSView focusView] isFlipped]){
    CGAffineTransform flip={1,0,0,-1,0,0};
    
    CGContextSetTextMatrix(cgContext,flip);
   }
}

-(void)set {
   [self setInContext:[NSGraphicsContext currentContext]];
}

-(NSPoint)positionOfGlyph:(NSGlyph)current precededByGlyph:(NSGlyph)previous isNominal:(BOOL *)isNominalp {
   return [_kgFont positionOfGlyph:current precededByGlyph:previous isNominal:isNominalp];
}

-(void)getAdvancements:(NSSize *)advancements forGlyphs:(const NSGlyph *)glyphs count:(unsigned)count {
   CGGlyph cgGlyphs[count];
   int     i;
   
   for(i=0;i<count;i++)
    cgGlyphs[i]=glyphs[i];
    
   [_kgFont getAdvancements:advancements forGlyphs:cgGlyphs count:count];
}

-(void)getAdvancements:(NSSize *)advancements forPackedGlyphs:(const void *)packed length:(unsigned)length {
   [_kgFont getAdvancements:advancements forGlyphs:packed count:length];
}

-(void)getBoundingRects:(NSRect *)rects forGlyphs:(const NSGlyph *)glyphs count:(unsigned)count {
   NSUnimplementedMethod();
}

-(unsigned)getGlyphs:(NSGlyph *)glyphs forCharacters:(unichar *)characters length:(unsigned)length {
   CGGlyph  cgGlyphs[length];
   int      i;
   
   [_kgFont getGlyphs:cgGlyphs forCharacters:characters length:length];
   
   for(i=0;i<length;i++){
    unichar check=characters[i];

    if(check<' ' || (check>=0x7F && check<=0x9F) || check==0x200B)
     glyphs[i]=NSControlGlyph;
    else
     glyphs[i]=cgGlyphs[i];
   }

   return length;
}

-(NSString *)description {
   return [NSString stringWithFormat:@"<%@ %@ %f>",isa,_name,_pointSize];
}

int NSConvertGlyphsToPackedGlyphs(NSGlyph *glyphs,int length,NSMultibyteGlyphPacking packing,char *outputX) {
   int      i,result=0;
   CGGlyph *output=(CGGlyph *)outputX;

   for(i=0;i<length;i++){
    NSGlyph check=glyphs[i];

    if(check!=NSNullGlyph && check!=NSControlGlyph)
     output[result++]=check;
   }

   return result*2;
}

@end

