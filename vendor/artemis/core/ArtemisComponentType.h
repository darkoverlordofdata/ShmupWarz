/**
 http://code.google.com/p/artemis-framework/source/browse/src/com/artemis/ComponentType.java
 */
#import <Foundation/Foundation.h>


@interface ArtemisComponentType : OFObject

@property(nonatomic,readonly) OFUInteger index;

+(OFUInteger) getIndexFor:(Class) componentClass;
+(ArtemisComponentType*) getTypeFor:(Class) c;

@end
