//
//  CPUAndMemoryUsage.h
//  HotWidget
//
//  Created by weijie.zhou on 2023/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPUAndMemoryUsage : NSObject
- (double)applicationCPU;
- (double)applicationMemory;
- (double)systemCPU;
- (double)systemMemory;
- (double)systemMemoryUsage;
- (double)systemMemoryTotal;
- (NSUInteger)cpuNumber;//cpu核心数
- (NSUInteger)cpuFrequency;//cpu频率
- (NSUInteger)cpuMaxFrequency;
@end

NS_ASSUME_NONNULL_END
