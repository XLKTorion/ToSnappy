//
//  Snappy.h
//  TXSnappy
//
//  Created by xlk on 2022/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Snappy : NSObject

- (void)test;
+ (NSData *)compressedSnappyData:(NSData *)data;
+ (NSData * __nullable)decompressedSnappyData:(NSData *)data;
+ (NSString *)decompressedSnappyString:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
