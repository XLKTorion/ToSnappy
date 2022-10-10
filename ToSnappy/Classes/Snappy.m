//
//  Snappy.m
//  TXSnappy
//
//  Created by xlk on 2022/10/9.
//

#import "Snappy.h"
#import "snappy-c.hpp"

@implementation Snappy

- (void)test{
    NSString *msg = @"msg";
    NSLog(@"%@",msg);
}

+ (NSData *)compressedSnappyData:(NSData *)data {
    char *buffer = (char *)[data bytes];
    NSUInteger dataLen = [data length];

    int error = 0;

    size_t compressLen = snappy_max_compressed_length(dataLen);
    char *compressBuffer = (char *)malloc(compressLen);
    error = snappy_compress(buffer, dataLen, compressBuffer, &compressLen);
    NSData *compressData;
    if (error == 0) {
        compressData = [[NSData alloc] initWithBytes:compressBuffer length:compressLen];
    }
    return compressData;
}

+ (NSData * __nullable)decompressedSnappyData:(NSData *)data {
    size_t uncompressLen;
    char *buffer = (char *)[data bytes];
    NSUInteger dataLen = [data length];

    int error = 0;
    snappy_uncompressed_length(buffer, dataLen, &uncompressLen);
    
    NSLog(@"-------------2:   %zu",uncompressLen);
    
    char *uncompressData = (char *)malloc(sizeof(char) * uncompressLen);
    error = snappy_uncompress(buffer, dataLen, uncompressData, &uncompressLen);
    if (error != 0) {
        free(uncompressData);
        uncompressData = NULL;
        return nil;
    }
    return [[NSData alloc] initWithBytes:uncompressData length:uncompressLen];
}

+ (NSString *)decompressedSnappyString:(NSData *)data {
    return [[NSString alloc] initWithData:[self decompressedSnappyData:data]
                                 encoding:NSUTF8StringEncoding];
}

@end
