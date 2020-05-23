/* ******************************************************************************
 * 
 * Copyright (c) 2019, Dark Overlord of Data
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *    * Neither the name of the <organization> nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
******************************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>

#ifdef OBJFW 
#include <ObjFW/ObjFW.h>

typedef unsigned int uint;
typedef unsigned char uchar;
typedef long OFInteger;
typedef unsigned long OFUInteger;

#define NSObject OFObject
#define NSNull OFNull
#define NSMutableArray OFMutableArray
#define NSMutableDictionary OFMutableDictionary
#define NSMutableString OFMutableString
#define NSInteger OFInteger
#define NSUInteger OFUInteger
#define NSArray OFArray
#define NSLog OFLog
#define NSData OFData
#define NSString OFString
#define NSUTF8StringEncoding OF_STRING_ENCODING_UTF_8 
#define NSCopying OFCopying


// #ifndef OF_ENUM
// #define OF_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
// #endif


static inline void OFLogv(OFString* format, va_list args)
{
#ifdef __ARC__
    OFString * string = [[[OFString alloc] initWithFormat: (OFConstantString*)format arguments:args] autorelease];
#else
    OFString * string = [[OFString alloc] initWithFormat: (OFConstantString*)format arguments:args];
#endif
    fprintf(stderr, "%s\n", [string UTF8String]); 
	// [of_stdout writeLine: [string UTF8String]];
}

/**
 * OFLog
 * 
 * Writes formatted output to stderr, with end of line.
 *
 */
static inline void OFLog (OFString* format, ...) 
{
    va_list args;
    va_start(args, format);
    OFLogv(format, args);    
    va_end(args);
}

#else
/** must be GUNstep */
#include <Foundation/Foundation.h>

#endif

/**
 * a few extra's
 */
#ifndef nullptr
#define nullptr NULL
#endif

#if defined(__cplusplus)
#define let auto const
#else
#define let const __auto_type
#endif

#if defined(__cplusplus)
#define var auto
#else
#define var __auto_type
#endif



/**
 *  MACRO Min
 *      cache results of calculation in pocket scope 
 */
#define Min(a, b)                                                       \
({                                                                      \
    let _a = a;                                                         \
    let _b = b;                                                         \
    (_a < _b) ? _a : _b;                                                \
})

/**
 *  MACRO Max
 *      cache results of calculation in pocket scope 
 */
#define Max(a, b)                                                       \
({                                                                      \
    let _a = a;                                                         \
    let _b = b;                                                         \
    (_a > _b) ? _a : _b;                                                \
})

