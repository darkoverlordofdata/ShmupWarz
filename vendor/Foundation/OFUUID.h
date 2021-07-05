#import <Foundation/Foundation.h>

@interface OFUUID : OFObject {
    uchar mData[16];
}
@property (class, nonatomic, readonly, assign) uchar* Data;

@end
