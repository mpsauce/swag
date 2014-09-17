//
//  MPSTemplateCell.h
//  SWAGLibrary
//
//  Created by matt on 9/8/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPSLabelLayout.h"

@interface MPSTemplateCell : UITableViewCell

@property (nonatomic, weak) IBOutlet MPSLabelLayout *titleLabelOutlet;
@property (nonatomic, weak) IBOutlet MPSLabelLayout *authorLabelOutlet;

@end
