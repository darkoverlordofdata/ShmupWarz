#import <Foundation/Foundation.h>
  
int main(int argc, char *argv[]) 
{

    @autoreleasepool {
        NSLog(@"Hello World!");

        NSString* vertex_str = [[NSString alloc] 
            initWithData:[[NSData alloc] 
            initWithContentsOfFile:@"assets/shaders/sprite.vs"] encoding:NSUTF8StringEncoding];

        NSLog(@"%@", vertex_str);
    }
    return 0;
}
