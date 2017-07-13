#import <Foundation/Foundation.h>

// --------- TimeoutInfo -----------

typedef void (^TimeoutBlock)(NSInteger tag);

@interface TimeoutInfo : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy) TimeoutBlock block;

@end

// ------------ NSTimer ------------

@interface NSTimer (KWSBlock)

+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)isRepeat timeout:(void(^)())timeout;
+ (NSTimer *)startWithTimeInterval:(NSTimeInterval)interval timeoutInfo:(TimeoutInfo *)info repeats:(BOOL)isRepeat;

@end
