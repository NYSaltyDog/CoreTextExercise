//
//  CTExercizeView.m
//  CTExersize
//
//  Created by Kevin Ives on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTExercizeView.h"


@implementation CTExercizeView


@synthesize space;
@synthesize location;



/*

//---------->>>>
//  CALLBACK FUNCTIONS
//---------->>>>
static void     deallocCallback (void* ref){ [(id)ref release]; }
static CGFloat  ascentCallback  (void *ref){ return 20.0;       }   // hight above baseline
static CGFloat  descentCallback (void *ref){ return 170.0;      }   // hight below baseline
static CGFloat  widthCallback   (void* ref){ return 160;        }   // image width


*/


//---------->>>>
//  INIT
//---------->>>>
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}





//---------->>>>
// DRAW
//---------->>>>
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //----->> content
    NSString *longText = @"When in the Course of human events, it becomes necessary for one people to dissolve the political bands which have connected them with another, and to assume among the powers of the earth, the separate and equal station to which the Laws of Nature and of Nature's God entitle them, a decent respect to the opinions of mankind requires that they should declare the causes which impel them to the separation. We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit of Happiness. That to secure these rights, Governments are instituted among Men, deriving their just Powers from the consent of the governed, — That whenever any Form of Government becomes destructive of these ends, it is the Right of the People to alter or to abolish it, and to institute new Government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their Safety and Happiness. Prudence, indeed, will dictate that Governments long established should not be changed for light and transient causes; and accordingly all experience hath shewn, that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same Object evinces a design to reduce them under absolute Despotism, it is their right, it is their duty, to throw off such Government,     and to provide new guards for their future security — Such has been the patient sufferance of these Colonies; and such is now the necessity which constrains them to alter their former Systems of Government. — The history of the present King of Great Britain is a history of repeated injuries and usurpations, all having in direct object the establishment of an absolute Tyranny over these States. To prove this, let facts be submitted to a candid world. He has refused his Assent to Laws, the most wholesome and necessary for the public good.He has forbidden his Governors to pass Laws of immediate and pressing importance, unless suspended in their operation till his Assent should be obtained; and when so suspended, he has utterly neglected to attend to them.He has refused to pass other Laws for the accommodation of large districts of people, unless those people would relinquish the right of Representation in the Legislature, a right inestimable to them and formidable to tyrants only.";
    
    
    ///////////////////////////////////////////
    // START---->>> CONVERT SYSTEM COORDINATES TO RANGE
    
    float xCoordinate =   (location.x) - 100.0;
    float yCoordinate =   1024 - (location.y) - 120;
    
    NSLog(@"Coordinate x = %f",xCoordinate);
    NSLog(@"Coordinate y = %f",yCoordinate);
    
    // END---->>> CONVERT SYSTEM COORDINATES TO RANGE
    //////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    // START---->>> FONT ATTRIBUTES BLOCK
    
    // build attributed string
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:longText];
    
    //----->>
    // font attributes
    CTFontRef arial     = CTFontCreateWithName(CFSTR("Arial"), 24.0, NULL);
    
    // [attrString addAttribute:(id)kCTFontAttributeName value:(id)arial range:NSMakeRange(0, 400)];
    // [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, 400)];
    
    // END---->>> FONT ATTRIBUTES BLOCK
    //////////////////////////////////////////
    
    
    /*
     ///////////////////////////////////////////
     // START---->>> CREATE DELEGATE
     
     //---------->>>>
     CTRunDelegateCallbacks callbacks;
     callbacks.version = kCTRunDelegateVersion1;
     callbacks.dealloc = deallocCallback;
     callbacks.getAscent = ascentCallback;
     callbacks.getDescent = descentCallback;
     callbacks.getWidth = widthCallback;
     CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, NULL);
     
     // set the delegate as an attribute
     CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attrString, CFRangeMake(500, 1), kCTRunDelegateAttributeName, delegate);
     
     // WRAPPING GOES HERE
     
     // END---->>> CREATE DELEGATE
     //////////////////////////////////////////
     */
    
    ///////////////////////////////////////////
    // START---->>> FONT ATTRIBUTES AFTER DELEGATE (IMAGE/GLYPH)
    
    [attrString addAttribute:(id)kCTFontAttributeName value:(id)arial range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, [attrString length])];
    
    // [attrString addAttribute:(id)kCTRunDelegateAttributeName value:(id)delegate range:NSMakeRange(0, [attrString length])];
    
    // END---->>> FONT ATTRIBUTES AFTER DELEGATE (IMAGE)
    //////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    // START---->>> STANDARD FRAME AND FRAMESET BLOCK
    
    // Create path and bounds of area
    CGMutablePathRef path           = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds );   
    
    //----->>
    // Set context
    CGContextRef context            = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetTextPosition(context, 0, 0);
    
    //----->> without wrapping
    // create a frame and frameset
    // CTFramesetterRef    framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    // CTFrameRef          frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, NULL);
	
    // END---->>> STANDARD FRAME AND FRAMESET BLOCK
    //////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    // START---->>> TEXT WRAPPING
    
	// Create a path to wrap around
	CGMutablePathRef clipPath = CGPathCreateMutable();
    
    if ( (location.x == 0.0) && (location.y == 0.0) ) {
        
        CGPathAddEllipseInRect(clipPath, NULL, CGRectMake(170, 610, 200, 240) );
    } else {
        CGPathAddEllipseInRect(clipPath, NULL, CGRectMake(xCoordinate, yCoordinate, 200, 240) );
    }
    
	// A CFDictionary containing the clipping path
	CFStringRef keys[]                  = { kCTFramePathClippingPathAttributeName };
	CFTypeRef values[]                  = { clipPath };
	CFDictionaryRef clippingPathDict    = CFDictionaryCreate(NULL, 
                                                             (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), 
                                                             &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	// An array of clipping paths 
	NSArray *clippingPaths              = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
	
	// Create an options dictionary, to pass in to CTFramesetter
	NSDictionary *optionsDict           = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
    
    // Finally create the framesetter with wrapping
    CTFramesetterRef framesetter        = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString); 
    CTFrameRef frame                    = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attrString length]), path, optionsDict);
	
    // END---->>> TEXT WRAPPING
    //////////////////////////////////////////
    
    
    // draw frame & text
    CTFrameDraw(frame, context); 
    
    
    
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);  
}




-(void)myCTDrawMethod{
    
    // [self setNeedsDisplay];
    
    //----->> content
    NSString *longText = @"When in the Course of human events, it becomes necessary for one people to dissolve the political bands which have connected them with another, and to assume among the powers of the earth, the separate and equal station to which the Laws of Nature and of Nature's God entitle them, a decent respect to the opinions of mankind requires that they should declare the causes which impel them to the separation. We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit of Happiness. That to secure these rights, Governments are instituted among Men, deriving their just Powers from the consent of the governed, — That whenever any Form of Government becomes destructive of these ends, it is the Right of the People to alter or to abolish it, and to institute new Government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their Safety and Happiness. Prudence, indeed, will dictate that Governments long established should not be changed for light and transient causes; and accordingly all experience hath shewn, that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same Object evinces a design to reduce them under absolute Despotism, it is their right, it is their duty, to throw off such Government,     and to provide new guards for their future security — Such has been the patient sufferance of these Colonies; and such is now the necessity which constrains them to alter their former Systems of Government. — The history of the present King of Great Britain is a history of repeated injuries and usurpations, all having in direct object the establishment of an absolute Tyranny over these States. To prove this, let facts be submitted to a candid world. He has refused his Assent to Laws, the most wholesome and necessary for the public good.He has forbidden his Governors to pass Laws of immediate and pressing importance, unless suspended in their operation till his Assent should be obtained; and when so suspended, he has utterly neglected to attend to them.He has refused to pass other Laws for the accommodation of large districts of people, unless those people would relinquish the right of Representation in the Legislature, a right inestimable to them and formidable to tyrants only.";
    
    
     ///////////////////////////////////////////
    // START---->>> CONVERT SYSTEM COORDINATES TO RANGE
    
    float xCoordinate =   (location.x) - 100.0;
    float yCoordinate =   1024 - (location.y) - 120;
    
    NSLog(@"Coordinate x = %f",xCoordinate);
    NSLog(@"Coordinate y = %f",yCoordinate);
    
     // END---->>> CONVERT SYSTEM COORDINATES TO RANGE
    //////////////////////////////////////////
    
    
    
     ///////////////////////////////////////////
     // START---->>> FONT ATTRIBUTES BLOCK
     
     // build attributed string
     NSMutableAttributedString *attrString  = [[NSMutableAttributedString alloc] initWithString:longText];
     
     // font attributes
     CTFontRef arial                        = CTFontCreateWithName(CFSTR("Arial"), 24.0, NULL);
     
    [attrString addAttribute:(id)kCTFontAttributeName value:(id)arial range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor blackColor].CGColor range:NSMakeRange(0, [attrString length])];
    
    // END---->>> FONT ATTRIBUTES BLOCK
    //////////////////////////////////////////
    
    
     ///////////////////////////////////////////
    // START---->>> STANDARD FRAME AND FRAMESET BLOCK
    
    // Create path and bounds of area
    CGMutablePathRef path           = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds );   
    
    // Set context
    CGContextRef context            = UIGraphicsGetCurrentContext();
    
    // END---->>> STANDARD FRAME AND FRAMESET BLOCK
    //////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    // START---->>> TEXT WRAPPING
    
	// Create a path to wrap around
	CGMutablePathRef clipPath = CGPathCreateMutable();
    CGPathAddEllipseInRect(clipPath, NULL, CGRectMake(xCoordinate, yCoordinate, 200, 240) );

	// A CFDictionary containing the clipping path
	CFStringRef keys[]                  = { kCTFramePathClippingPathAttributeName };
	CFTypeRef values[]                  = { clipPath };
	CFDictionaryRef clippingPathDict    = CFDictionaryCreate(NULL, 
                                                             (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), 
                                                             &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	// An array of clipping paths 
	NSArray *clippingPaths              = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
	
	// Create an options dictionary, to pass in to CTFramesetter
	NSDictionary *optionsDict           = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
    
    // Finally create the framesetter with wrapping
    CTFramesetterRef framesetter        = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString); 
    CTFrameRef frame                    = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attrString length]), path, optionsDict);
	
    // END---->>> TEXT WRAPPING
    //////////////////////////////////////////
    
    
    // draw frame & text
    CTFrameDraw(frame, context); 
    
    // CLEAN UP
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);    
    
}






//---------->>>>
// TOUCHES METHODS
//---------->>>>
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [[event allTouches] anyObject];
	location = [touch locationInView:touch.view];
	space.center = location;
    
    // NSLog(@"Location x = %f",location.x);
    // NSLog(@"Location y = %f",location.y);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	[self touchesBegan:touches withEvent:event];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Set Image here x = %f",location.x);
    NSLog(@"Set Image here y = %f",location.y);
    
    //----->> REFRESH VIEW and Re-DRAW CoreText Frames
    [self setNeedsDisplay];
    [self myCTDrawMethod];
}


@end
