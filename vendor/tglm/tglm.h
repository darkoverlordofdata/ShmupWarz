/*******************************************************************
** This code is part of the Dark Overload Framework.
**
MIT License

Copyright (c) 2018 Dark Overlord of Data

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************/
/**
 * tglm is Tiny GLM for c99
 *
 * opengl math helpers inspired by GLM.
 * using clang vector extensions and function overload.
 * 
 */
#ifndef _TGLM_H
#define _TGLM_H
#include <math.h>
/**
 *  OpenCL Vector definitions 
 */
typedef int IVec2   __attribute__((ext_vector_type(2)));
typedef int IVec3   __attribute__((ext_vector_type(3)));
typedef float Vec2  __attribute__((ext_vector_type(2)));
typedef float Vec3  __attribute__((ext_vector_type(3)));
typedef float Vec4  __attribute__((ext_vector_type(4)));
typedef float Mat   __attribute__((ext_vector_type(16)));

/**
 * clamp number/vector between MIN and MAX values
 *
 * @param  val value
 * @param  minVal minimum 
 * @param  maxVal maximum 
 * @returns clamped value
 * 
 */
static inline float  __attribute__((overloadable)) glm_clamp(float val, float minVal, float maxVal) {
    float min = (val > minVal) ? val : minVal;
    return (min < maxVal) ? min : maxVal;
}
static inline Vec2  __attribute__((overloadable)) glm_clamp(Vec2 v, float minVal, float maxVal) {
    return (Vec2) { 
        glm_clamp(v.x, minVal, maxVal),
        glm_clamp(v.y, minVal, maxVal) 
    };
}
static inline Vec2  __attribute__((overloadable)) glm_clamp(Vec2 v, Vec2 minVal, Vec2 maxVal) {
    return (Vec2) { 
        glm_clamp(v.x, minVal.x, maxVal.x),
        glm_clamp(v.y, minVal.y, maxVal.y) 
    };
}
static inline Vec3  __attribute__((overloadable)) glm_clamp(Vec3 v, float minVal, float maxVal) {
    return (Vec3) {
        glm_clamp(v.x, minVal, maxVal),
        glm_clamp(v.y, minVal, maxVal),
        glm_clamp(v.z, minVal, maxVal)
    };
}
static inline Vec4  __attribute__((overloadable)) glm_clamp(Vec4 v, float minVal, float maxVal) {
    return (Vec4) {
        glm_clamp(v.x, minVal, maxVal),
        glm_clamp(v.y, minVal, maxVal),
        glm_clamp(v.z, minVal, maxVal),
        glm_clamp(v.w, minVal, maxVal)
    };
}

/** 
 * translate transform matrix by v vector
 *
 * @param  m  affine transfrom
 * @param  v  translate vector [x, y, z]
 * @returns translated matrix
 * 
 */
static inline Mat glm_translate(Mat m, Vec3 v) {
    m.scdef = m.scdef + m.s0123 * v.x + m.s4567 * v.y + m.s89ab * v.z;
    return m;
}


/**
 * length - return scalar Euclidean length of a vector
 * 
 * @param v vector
 * @returns norm * norm
 * 
 */
static inline float __attribute__((overloadable)) glm_length(Vec2 v) {
    return sqrtf(v.x * v.x + v.y * v.y);
}
static inline float __attribute__((overloadable)) glm_length(Vec3 v) {
    return sqrtf(v.x * v.x + v.y * v.y + v.z * v.z);
}
static inline float __attribute__((overloadable)) glm_length(Vec4 v) {
    return sqrtf(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w);
}


/**
 * vector dot product
 *
 * @param a vector1
 * @param b vector2
 * @returns dot product
 * 
 */
static inline float __attribute__((overloadable)) glm_dot(Vec2 a, Vec2 b) {
    return a.x * b.x + a.y * b.y;
}
static inline float __attribute__((overloadable)) glm_dot(Vec3 a, Vec3 b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
}
static inline float __attribute__((overloadable)) glm_dot(Vec4 a, Vec4 b) {
    return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
}

/**
 * norm * norm (magnitude) of vector
 *
 * @param v vector
 * @returns norm * norm
 * 
 */
static inline float __attribute__((overloadable)) glm_norm2(Vec2 v) {
  return glm_dot(v, v);
}
static inline float __attribute__((overloadable)) glm_norm2(Vec3 v) {
  return glm_dot(v, v);
}
static inline float __attribute__((overloadable)) glm_norm2(Vec4 v) {
  return glm_dot(v, v);
}

/**
 * norm (magnitude) of vec3
 *
 * @param vec vector
 * @returns norm
 */
static inline float __attribute__((overloadable)) glm_norm(Vec2 vec) {
  return sqrtf(glm_norm2(vec));
}
static inline float __attribute__((overloadable)) glm_norm(Vec3 vec) {
  return sqrtf(glm_norm2(vec));
}
static inline float __attribute__((overloadable)) glm_norm(Vec4 vec) {
  return sqrtf(glm_norm2(vec));
}


/**
 * return an identity matrix
 */
static inline Mat mat_identity()
{
    return (Mat){   1.0f, 0.0f, 0.0f, 0.0f,
                    0.0f, 1.0f, 0.0f, 0.0f,
                    0.0f, 0.0f, 1.0f, 0.0f,
                    0.0f, 0.0f, 0.0f, 1.0f };
}


/**
 * normalize vector and store result in same vec
 *
 * @param v vector
 * @returns normalized vector
 * 
 */
static inline Vec3 __attribute__((overloadable)) glm_normalize(Vec3 v)
{
    float n = glm_norm(v);
    if (n == 0.0f) {
        v.x = v.y = v.z = 0.0f;
        return v;
    }
    v = v * 1.0f / n;
    return v;
}
static inline Vec2 __attribute__((overloadable)) glm_normalize(Vec2 v)
{
    float n = glm_norm(v);
    if (n == 0.0f) {
        v.x = v.y = 0.0f;
        return v;
    }
    v = v * 1.0f / n;
    return v;
}


/**
 * scales existing transform matrix by v vector
 * and stores result in same matrix
 *
 * @param  m  affine transfrom
 * @param  v  scale vector [x, y, z]
 * @returns scaled Vec3
 */
static inline Mat glm_scale(Mat m, Vec3 v) 
{
    m.s0123 = m.s0123 * v.x;
    m.s4567 = m.s4567 * v.y;
    m.s89ab = m.s89ab * v.z;
    return m;
}

/**
 * set up orthographic projection matrix
 *
 * @param  left    left and right vertical clipping planes
 * @param  right   left and right vertical clipping planes
 * @param  bottom  bottom and top horizontal clipping planes
 * @param  top     bottom and top horizontal clipping planes
 * @param  nearVal nearer and farther depth clipping planes
 * @param  farVal  nearer and farther depth clipping planes
 * @returns projection matrix
 */
static inline Mat glm_ortho(float left,
                    float right,
                    float bottom,
                    float top,
                    float nearVal,
                    float farVal)

{
    Mat proj = mat_identity();

    proj.s0 = 2 / (right - left);
    proj.s5 = 2 / (top - bottom);
    proj.sa = -1;
    proj.sc = - (right + left) / (right - left);
    proj.sd = - (top + bottom) / (top - bottom);
    proj.se =  - nearVal / (farVal - nearVal);

    return proj;
}

/**
 * rotate existing transform matrix around given axis by angle
 *
 * @param  m      affine transfrom
 * @param  angle  angle (radians)
 * @param  axis   axis
 */
static inline Mat glm_rotate(Mat m, float angle, Vec3 v) 
{
    float a = angle;
    float c = cos(a);
    float s = sin(a);
    
    Vec3 axis = glm_normalize(v);
    Vec3 temp = (1-c) * axis;

    Mat rotate;
    rotate.s0 = c + temp.x * axis.x;
    rotate.s1 = temp.x * axis.y + s * axis.z;
    rotate.s2 = temp.x * axis.z - s * axis.y;

    rotate.s4 = temp.y * axis.x - s * axis.z;
    rotate.s5 = c + temp.y * axis.y;
    rotate.s6 = temp.y * axis.z + s * axis.x;

    rotate.s8 = temp.z * axis.x + s * axis.y;
    rotate.s9 = temp.z * axis.y - s * axis.x;
    rotate.sa = c + temp.z * axis.z;

    Mat result;
    result.s0123 = m.s0123 * rotate.s0 + m.s4567 * rotate.s1 + m.s89ab * rotate.s2;
    result.s4567 = m.s0123 * rotate.s4 + m.s4567 * rotate.s5 + m.s89ab * rotate.s6;
    result.s89ab = m.s0123 * rotate.s8 + m.s4567 * rotate.s9 + m.s89ab * rotate.sa;
    result.scdef = m.scdef;

    return result;
}

#endif // _TGLM_H