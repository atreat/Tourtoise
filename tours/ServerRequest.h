
//  ServerRequest.h
//  tours
//
//  Created by eq2-mac on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>       //needed for sha1
#import "NSData+Base64.h"                   //needed for Base64

@interface ServerRequest : NSURLConnection {
    NSMutableData       *dataToBeLoaded;
    NSString            *urlString;
    NSURL               *url;
    NSURLConnection     *connection;
    NSMutableURLRequest *request;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
