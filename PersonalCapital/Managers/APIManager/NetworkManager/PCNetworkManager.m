//
//  PCNetworkManager.m
//  PersonalCapital
//
//  Created by Juan Balderas on 15/01/20.
//  Copyright © 2020 JuanCBalderas. All rights reserved.
//

#import "PCNetworkManager.h"
#import "APIConstants.h"

#import "PCHTMLParser.h"

@implementation PCNetworkManager

- (NSMutableURLRequest *)requestWithURLPath:(NSString*)path {
    NSURL *url = [NSURL URLWithString:baseURL];
    url = [url URLByAppendingPathComponent:path];

    NSMutableURLRequest *iRequest = [NSMutableURLRequest requestWithURL:url];

    return iRequest;
}

-(void)performRequest:(NSURLRequest *)request response:(APIResponseBlock)apiResponse {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

        if (error == nil && httpResponse.statusCode == HTTP_CODE_SUCCESS) {
            apiResponse(true, data, error);
        } else {
            apiResponse(false, data, error);

        }
    }];
    [task resume];

}

@end
