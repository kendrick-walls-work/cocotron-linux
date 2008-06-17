/*------------------------------------------------------------------------
 *
 * Derivative of the OpenVG 1.0.1 Reference Implementation
 * -------------------------------------
 *
 * Copyright (c) 2007 The Khronos Group Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and /or associated documentation files
 * (the "Materials "), to deal in the Materials without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Materials,
 * and to permit persons to whom the Materials are furnished to do so,
 * subject to the following conditions: 
 *
 * The above copyright notice and this permission notice shall be included 
 * in all copies or substantial portions of the Materials. 
 *
 * THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE MATERIALS OR
 * THE USE OR OTHER DEALINGS IN THE MATERIALS.
 *
 *-------------------------------------------------------------------*/

#import "KGBitmapContext.h"
#import "VGmath.h"
#import "KGSurface.h"

@class KGPaint;

typedef enum {
// These are winding masks, do not change value
  VG_EVEN_ODD=1,
  VG_NON_ZERO=-1
} VGFillRuleMask;

typedef struct Edge {
   CGPoint		v0;
   CGPoint		v1;
   int         direction;
   CGPoint     normal;
   CGFloat     cnst;
   int         minscany;
   int         maxscany;
// These are init/modified during AET processing, should be broken out to save memory
   struct Edge *next;
   CGFloat      vdxwl;
   CGFloat      sxPre;
   CGFloat      exPre;
   CGFloat      bminx;
   CGFloat      bmaxx;
   int          minx;
   int          maxx;
} Edge;

typedef void (*KGBlendSpan_RGBA8888)(KGRGBA8888 *src,KGRGBA8888 *dst,int length);
typedef void (*KGBlendSpan_RGBAffff)(KGRGBAffff *src,KGRGBAffff *dst,int length);

@class KGSurface,KGContext_builtin;

typedef void (*KGWriteCoverageSpans)(KGContext_builtin *self,int *x, int *y,int *coverage,int *lengths,int count);


#define KGRasterizer KGContext_builtin

@interface KGContext_builtin : KGBitmapContext {
   KGSurface  *m_renderingSurface;
   KGSurface  *m_mask;
   KGPaint    *m_paint;
   
   BOOL _useRGBA8888;

   KGBlendSpan_RGBA8888 _blend_lRGBA8888_PRE;
   KGBlendSpan_RGBAffff _blend_lRGBAffff_PRE;

    int _vpx,_vpy,_vpwidth,_vpheight;
    
    int    _edgeCount;
    int    _edgeCapacity;
    Edge  *_edgePool;
    Edge **_edges;
    
    int *_winding;
    int *_increase;
    
    int     sampleSizeShift;
	int     numSamples;
    int     samplesWeight;
    CGFloat *samplesX;
    CGFloat *samplesY;
}

-(void)setWidth:(size_t)width height:(size_t)height reallocateOnlyIfRequired:(BOOL)roir;

KGRasterizer *KGRasterizerInit(KGRasterizer *self,KGSurface *renderingSurface);
void KGRasterizerDealloc(KGRasterizer *self);
void KGRasterizerSetViewport(KGRasterizer *self,int vpwidth,int vpheight);
void KGRasterizerClear(KGRasterizer *self);
void KGRasterizerAddEdge(KGRasterizer *self,const CGPoint v0, const CGPoint v1);
void KGRasterizerSetShouldAntialias(KGRasterizer *self,BOOL antialias);
void KGRasterizerFill(KGRasterizer *self,VGFillRuleMask fillRule);

void KGRasterizeSetBlendMode(KGRasterizer *self,CGBlendMode blendMode);
void KGRasterizeSetMask(KGRasterizer *self,KGSurface* mask);
void KGRasterizeSetPaint(KGRasterizer *self,KGPaint* paint);
//private

void KGRasterizeWriteCoverageSpan(KGRasterizer *self,int x, int y,int coverage,int lengths);

@end