//
//  ServerRequest.m
//  tours
//
//  Created by eq2-mac on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerRequest.h"

@implementation ServerRequest



- (id)init
{
    self = [super init];
    if (self) {
        dataToBeLoaded = [[NSMutableData alloc] init];
        urlString = @"http://tourtoise.cems.uvm.edu/api/tour/1";
        url = [NSURL URLWithString:urlString];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        //Need to add Date and Authorization headers to request
        
// Date Header        
        NSString *date = [self formatDateString];
        [request addValue:date forHTTPHeaderField:@"Date"];




//Authorization Header
        //private string is PrivateKey + \n + date
        NSString *privateString = [NSString stringWithFormat:@"%@\n%@",PRIVATE_KEY,date];
        NSLog(@"Before SHA1 %@",privateString);
        
//        unsigned char digest[CC_SHA1_DIGEST_LENGTH];
//        NSData *stringBytes = [privateString dataUsingEncoding: NSUTF8StringEncoding];

//        if(CC_SHA1([stringBytes bytes], [stringBytes length], digest)){     //if sha1 does work, hash stored in digest array
//
//            NSData *hashdata = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//            NSLog(@"After SHA1 %@",[hashdata description]);
//
//            NSString *encodedPrivateString = [hashdata base64EncodedString];
//
//            //                  PublicKey:PrivateString:UserID:Password
//            NSString *authString = [NSString stringWithFormat:@"%@:%@:%@:%@",PUBLIC_KEY,encodedPrivateString,USER_ID,PASSWORD];
//            [request addValue:authString forHTTPHeaderField:@"Authorization"];
//        }
        
        NSString *sha1String = [privateString sha1];
        NSData *hashData = [sha1String dataUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedPrivateString = [hashData base64EncodedString];
        
        NSString *authString = [NSString stringWithFormat:@"%@:%@:%@:%@",PUBLIC_KEY,encodedPrivateString,USER_ID,PASSWORD];
        [request addValue:authString forHTTPHeaderField:@"Authorization"];
        
        
//        [self test];
//        Authorization
//        
//        The Authorization header is a custom header used to authenticate the client and the user requesting access to the API. The authorization header must be formatted as follows:
//        
//    PublicKey:PrivateString:UserID:Password
//        where PublicKey is the public key of the client, UserID is the base64 encoded user ID of the user requesting access (usually their email address) and Password is the user's base64 encoded password. PrivateString must be formatted as follows:
//        
//        base64_encode(sha1(PrivateKey + "\n" + Date))
        
        
        
        
        
        

        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }
    
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"received data");
    NSLog(@"Data    ::      %@", data);
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];  
    NSLog(@"String  ::  %@", string);
    
}




-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
    
}




-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  
    
    
}


//        Date
//        
//        The date header is used to ensure that the same request cannot be used at a later point in time by comparing the date sent in the header with the current date. The date in the header must be within 180 seconds of the current GMT time or the request will fail.
//        
//        The date header must be formatted according to RFC 822 (updated by RFC 1123). An example date is as follows: Sat, 22 Oct 2011 04:50:43 +0000
#pragma mark - date format
- (NSString *) formatDateString
{
    NSDate *date  = [[[NSDate alloc] init] autorelease];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    
    [formatter setDateFormat: @"EEE, dd MMM yyyy kk:mm:ss ZZZ"];
    NSString *dateString = [formatter stringFromDate:date];        
    NSLog(@"formatted date: %@",dateString);
    return dateString;
}




- (void) test
{
    NSLog(@"Test Function -- Begin          :::::");
    NSString *testString    = @"Hello World!";
    
    NSData *testData        = [testString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Base64 encoded test string :: %@",[testData base64EncodedString]);
    
    
//    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
//    NSData *stringBytes = [testString dataUsingEncoding: NSUTF8StringEncoding];
//    if(CC_SHA1([stringBytes bytes], [stringBytes length], digest)){     //if sha1 does work, hash stored in digest array
//        
//        NSData *hashdata = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//        NSLog(@"After SHA1 %@",[hashdata description]);
//        
//    }
    
    
    NSData *data = [testString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    NSLog(@"After SHA1 %@",output);
    
    NSLog(@"Test Function -- End            :::::");
    NSLog(@"Test Function -- End            :::::");
    NSLog(@"Test Function -- End            :::::");
    NSLog(@"Test Function -- End            :::::");
    NSLog(@"Test Function -- End            :::::");
}
    
@end





















