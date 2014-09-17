//
//  MPSAPI.h
//  SWAGLibrary
//
//  Created by matt on 9/7/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPSAPI : NSObject

+ (void)getSwagBookLibrary:(void (^)(NSArray *))completion;
//+ (void)addSwagBookToLibrary:(void (^)(NSDictionary *))completion;
//+ (void)deleteSwagBookFromLibrary:(void (^)(NSDictionary *))completion;
//+ (void)deleteAllSwagBookToLibrary:(void (^)(NSDictionary *))completion;
@end
