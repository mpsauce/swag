//
//  MPSBook.h
//  SWAGLibrary
//
//  Created by matt on 9/8/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPSBook : NSObject

@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *author;
@property (strong, nonatomic)NSString *categories;
@property (strong, nonatomic)NSString *id;
@property (strong, nonatomic)NSString *lastCheckedOut;
@property (strong, nonatomic)NSString *lastCheckedOutBy;
@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *publisher;


@end
