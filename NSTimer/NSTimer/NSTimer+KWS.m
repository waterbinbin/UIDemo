#import "NSTimer+KWS.h"

@implementation TimeoutInfo

@end

@implementation NSTimer (KWSBlock)

#pragma mark Public

+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)isRepeat timeout:(void(^)())timeout
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(onTimeoutBlockInvoked:)
                                       userInfo:[timeout copy]
                                        repeats:isRepeat];
}

+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval timeoutInfo:(TimeoutInfo *)info repeats:(BOOL)isRepeat
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(onTimeout:)
                                       userInfo:info
                                        repeats:isRepeat];
}

#pragma mark Private

+ (void)onTimeoutBlockInvoked:(NSTimer *)timer
{
    void (^timeoutBlock)() = timer.userInfo;
    if (timeoutBlock != nil) {
        timeoutBlock();
    }
}

+ (void)onTimeout:(NSTimer *)timer
{
    TimeoutInfo *info = timer.userInfo;
    if (info.block != nil) {
        info.block(info.tag);
    }
}

@end
