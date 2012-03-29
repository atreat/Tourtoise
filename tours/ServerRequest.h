
//  ServerRequest.h
//  tours
//
//  Created by eq2-mac on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>       //needed for sha1
#import "NSData+Base64.h"                   //needed for Base64
#import "NSString+SHA1.h"



#define PUBLIC_KEY @"JMoEudX2ESn5ZNiUcMbFd25ynBErffCF7l4ezRWRe959PENv6XVYNckiImF7P34Q"
#define PRIVATE_KEY @"kT8ME0kDJaxhfjgjd2CAQvBSkBB7WzDYQSNgVQI491YeW0RLUT1gTB8WDOhgCvjR"
#define USER_ID @"primehunter326@gmail.com"
#define PASSWORD @"chupacabra"

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
- (NSString *) formatDateString;



-(void) test;

@end
