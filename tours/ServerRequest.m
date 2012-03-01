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
        
#pragma mark - @Date Format
//        Date
//        
//        The date header is used to ensure that the same request cannot be used at a later point in time by comparing the date sent in the header with the current date. The date in the header must be within 180 seconds of the current GMT time or the request will fail.
//        
//        The date header must be formatted according to RFC 822 (updated by RFC 1123). An example date is as follows: Sat, 22 Oct 2011 04:50:43 +0000
        NSDate *date =   [NSDate date];
        NSLog(@"Date    ::      %@", date);
        
        
        
        
        
        

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
    
@end
