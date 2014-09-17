//
//  MPSAPI.m
//  SWAGLibrary
//
//  Created by matt on 9/7/14.
//  Copyright (c) 2014 MPSurowiec. All rights reserved.
//


#import "MPSAPI.h"
#import "MPSConstants.h"

@implementation MPSAPI

+ (void)getSwagBookLibrary:(void (^)(NSArray *))completion {
    
    NSOperationQueue *backgroundqueue =[NSOperationQueue new];
    NSString *getURL = [NSString stringWithFormat:@"%@", kMAIN_API_URL];
    NSLog(@"%@", getURL);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:getURL parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSLog(@"%@", responseObject);
        [backgroundqueue addOperationWithBlock:^{
            completion(responseObject);
        }];
        
    }failure:^(AFHTTPRequestOperation *task, NSError *error) {
        NSLog(@"Failed: %@", error.localizedDescription);
    }];
    
}

//
//+ (void)addSwagBookToLibrary:(void (^)(NSDictionary *))completion {
//    
//}
//
//
//+ (void)deleteSwagBookFromLibrary:(void (^)(NSDictionary *))completion {
//    
//}
//
//
//+ (void)deleteAllSwagBookToLibrary:(void (^)(NSDictionary *))completion {
//    
//}
//

@end
