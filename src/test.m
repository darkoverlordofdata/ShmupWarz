#import <Foundation/Foundation.h>

  
#ifdef RELEASE
@interface MyFirstApp: OFObject <OFApplicationDelegate>
@end

OF_APPLICATION_DELEGATE(MyFirstApp)

@implementation MyFirstApp
- (void)applicationDidFinishLaunching
#else
int main(int argc, char *argv[]) 
#endif
{

    // @autoreleasepool {
        OFLog("Hello World!");


        // OFData *vertex_data = [[OFData alloc] initWithContentsOfFile:@"assets/shaders/sprite.vs"];
        // OFString* vertex_str = [[OFString alloc] initWithData:vertex_data encoding:OF_STRING_ENCODING_UTF_8];

        // OFString* 
        let vertex_str = [[OFString alloc] 
            initWithData:[[OFData alloc] 
            initWithContentsOfFile:@"assets/shaders/sprite.vs"] encoding:OF_STRING_ENCODING_UTF_8];

        OFLog(vertex_str);
    // }
    return 0;
}
#ifdef RELEASE
@end
#endif