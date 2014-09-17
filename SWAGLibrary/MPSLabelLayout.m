//
//  MPSLabelLayout.m
//  SWAGLibrary
//
//  Created by matt on 9/15/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//

#import "MPSLabelLayout.h"

@implementation MPSLabelLayout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.numberOfLines == 0) {
        if (self.preferredMaxLayoutWidth != self.frame.size.width) {
            self.preferredMaxLayoutWidth = self.frame.size.width;
            [self setNeedsUpdateConstraints];
        }
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    if (self.numberOfLines == 0) {
        size.height += 1;
    }
    
    return size;
}

@end
