//
//  CTExercizeView.h
//  CTExersize
//
//  Created by Kevin Ives on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTExercizeView : UIView {
    
    IBOutlet    UIImageView             *space;
                CGPoint                 location;
}


@property (nonatomic, strong)   IBOutlet   UIImageView  *space;
@property                                  CGPoint      location;      

-(void)myCTDrawMethod;

@end
