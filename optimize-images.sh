#!/bin/bash

# Image Optimization Script for Portfolio Website
# Run this script after installing imagemagick and webp tools

echo "🚀 Starting image optimization process..."

IMAGE_FILE="WhatsApp Image 2025-02-12 at 05.27.07_1303fb9c.jpg"

# Check if image file exists
if [ ! -f "$IMAGE_FILE" ]; then
    echo "❌ Error: Image file not found: $IMAGE_FILE"
    exit 1
fi

echo "📊 Original image size:"
ls -lah "$IMAGE_FILE"

# 1. Optimize the original JPEG
echo "🔧 Optimizing JPEG..."
if command -v jpegoptim &> /dev/null; then
    cp "$IMAGE_FILE" "${IMAGE_FILE}.backup"
    jpegoptim --max=80 --strip-all "$IMAGE_FILE"
    echo "✅ JPEG optimized"
else
    echo "⚠️  jpegoptim not found, skipping JPEG optimization"
fi

# 2. Create WebP version
echo "🖼️  Creating WebP version..."
if command -v cwebp &> /dev/null; then
    cwebp -q 80 "$IMAGE_FILE" -o "profile-optimized.webp"
    echo "✅ WebP version created"
else
    echo "⚠️  cwebp not found, skipping WebP creation"
fi

# 3. Create AVIF version (next-gen format)
echo "🔮 Creating AVIF version..."
if command -v magick &> /dev/null; then
    magick "$IMAGE_FILE" -quality 80 "profile-optimized.avif"
    echo "✅ AVIF version created"
else
    echo "⚠️  ImageMagick not found, skipping AVIF creation"
fi

# 4. Create responsive image sizes
echo "📱 Creating responsive image sizes..."
if command -v convert &> /dev/null; then
    convert "$IMAGE_FILE" -resize 300x300 -quality 80 "profile-300.jpg"
    convert "$IMAGE_FILE" -resize 600x600 -quality 80 "profile-600.jpg"
    echo "✅ Responsive images created"
else
    echo "⚠️  ImageMagick convert not found, skipping responsive images"
fi

echo "📊 Final file sizes:"
ls -lah *.{jpg,jpeg,webp,avif} 2>/dev/null | head -10

echo ""
echo "🎉 Image optimization complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update HTML to use the optimized images"
echo "2. Test the website with new images"
echo "3. Run performance tests with Lighthouse"
echo ""
echo "💡 Expected improvements:"
echo "- WebP: 60-80% size reduction"
echo "- AVIF: 70-90% size reduction"
echo "- Faster LCP (Largest Contentful Paint)"
echo "- Better Core Web Vitals scores"