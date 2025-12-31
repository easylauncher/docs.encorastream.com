---
layout: default
title: Getting Started
nav_order: 2
has_children: false
---

# 🚀 Getting Started
{: .no_toc }

Quick start guide to deploying your first stream on {{ site.product_name }}.
{: .fs-6 .fw-300 }

---

## Overview

This guide will walk you through setting up your first live stream from start to finish in approximately 30 minutes.

{: .highlight }
Before you begin, ensure you have access to the {{ site.product_name }} dashboard and a video encoder ready to send a stream.

---

## Prerequisites

Before deploying your first stream, you'll need:

- ✅ Access to {{ site.product_name }} dashboard
- ✅ A hardware or software encoder (OBS, vMix, Wirecast, etc.)
- ✅ Network connectivity between encoder and platform
- ✅ Basic understanding of streaming protocols (UDP/RTMP)

---

## Quick Start Steps

### Step 1: 📥 Configure Input Stream

Create an input stream to receive video from your encoder.

1. Navigate to **Input Streams** in the sidebar
2. Click **Add Input Stream**
3. Fill in the details:
   - **Name**: A descriptive channel name (e.g., "Main Channel HD")
   - **Content ID**: Unique identifier (e.g., "main_channel_hd")
   - **Source URL**: Your encoder URL (e.g., `udp://@239.1.1.1:5000`)
4. Click **Save**

{: .important }
**Content ID** must be consistent across all components (transcoder, packagers). It is case-sensitive!

[Learn more about Input Streams →](../components/input-streams/)

---

### Step 2: ⚙️ Create Transcoder

Set up transcoding to create multiple quality levels for adaptive streaming.

1. Navigate to **Transcoders** in the sidebar
2. Click **Add Transcoder**
3. Configure:
   - **Input Stream**: Select your newly created input stream
   - **ABR Profile**: Choose based on your audience (High ABR for premium quality)
   - **Server**: Select available transcoding server
   - **Renditions**: Enable quality levels you want (1080p, 720p, 480p, 360p)
4. Toggle **Enable** to ON
5. Click **Save**

{: .note }
The transcoder will start processing immediately. It may take 30-60 seconds to begin.

[Learn more about Transcoders →](../components/transcoders/)

---

### Step 3: 📦 Set Up Packagers

Create packagers to format your stream for different devices and platforms.

#### Choose Your Packager Type(s):

**For Set-Top Boxes and VLC:**
- Create an **AES Packager** for basic encrypted HLS streaming

**For Web Browsers (Chrome, Edge, Firefox):**
- Create a **DASH Packager** for modern web playback

**For Apple Devices (iOS, Safari):**
- Create an **HLS Packager** for Apple ecosystem

{: .tip }
You can (and should) create all three packager types to support all devices!

**Basic Packager Setup (example for AES):**

1. Navigate to **AES Packagers**
2. Click **Add AES Packager**
3. Configure:
   - **Input Stream**: Select your input stream
   - **Transcoder**: Select your transcoder
   - **Server**: Select packaging server
   - **Media Directory**: `/opt/es/media/packager`
   - **Segment Duration**: 6 seconds (recommended)
   - **Audio**: Select audio tracks
4. Toggle **Enable** to ON
5. Click **Save**

Repeat for DASH and HLS packagers as needed.

[Learn more about Packagers →](../components/packagers/)

---

### Step 4: 🌐 Deploy Origin Server

Enable content delivery from origin servers.

1. Navigate to **Origins** in the sidebar
2. Click **Add Origin**
3. Configure:
   - **Server**: Same as packager server (typical)
   - **Server Interface**: Primary network interface (eth0)
   - **Media Directory**: `/opt/es/media/packager` (same as packagers)
4. Toggle **Enable** to ON
5. Click **Save**

[Learn more about Origin Servers →](../components/origin-servers/)

---

### Step 5: ✅ Test Your Stream

Once all components are deployed, test your stream:

#### Get Your Playback URLs

For **AES** streams:
```
http://your-origin-server/[content-id]/aes/playlist.m3u8
```

For **DASH** streams:
```
http://your-origin-server/[content-id]/dash/manifest.mpd
```

For **HLS** streams:
```
http://your-origin-server/[content-id]/hls/master.m3u8
```

Replace `[content-id]` with your actual Content ID.

#### Testing Methods

**1. VLC Player (Quick Test)**
- Open VLC
- Media → Open Network Stream
- Paste your playlist URL
- Click Play

**2. Web Browser**
- For DASH: Use [DASH.js Reference Player](https://reference.dashif.org/dash.js/)
- For HLS on Safari: Paste URL directly in address bar
- For HLS on Chrome: Use [HLS.js demo](https://hls-js.netlify.app/demo/)

**3. Mobile Devices**
- iOS Safari: Paste HLS URL directly
- Android: Use ExoPlayer-based apps for DASH

---

## Verification Checklist

Before going to production, verify:

- [ ] Input stream is receiving video (check with VLC or ffprobe)
- [ ] Transcoder status shows **RUNNING**
- [ ] All packagers show **RUNNING** status
- [ ] Origin server is accessible via HTTP
- [ ] Playback URLs return valid manifests (not 404)
- [ ] Video plays smoothly in test players
- [ ] Multiple quality levels switch automatically (ABR working)
- [ ] Audio is present and synchronized

---

## Common First-Time Issues

### Problem: "Not Streaming" or 404 Error

**Solution:**
1. Verify Content ID matches exactly across all components (case-sensitive!)
2. Check that input stream is actually receiving video from encoder
3. Ensure transcoder and packagers show RUNNING status
4. Wait 60-90 seconds after enabling all components

### Problem: Video Plays but Poor Quality

**Solution:**
1. Check encoder output quality and bitrate
2. Verify input stream with `ffprobe` or VLC
3. Review transcoder rendition settings
4. Ensure network bandwidth is sufficient

### Problem: Video Works but No Audio

**Solution:**
1. Verify encoder is sending audio
2. Check input stream has audio tracks (use ffprobe)
3. Ensure at least one audio track is selected in packager configuration

---

## Next Steps

Now that you have your first stream running:

1. **📚 Review [Best Practices](../guides/best-practices/)** for optimization tips
2. **🔍 Bookmark [Troubleshooting Guide](../reference/troubleshooting/)** for quick issue resolution
3. **🔒 Set up DRM Protection** for premium content (see [Packagers documentation](../components/packagers/#drm-configuration))
4. **📊 Configure monitoring** to track stream health

---

## Need Help?

- [Troubleshooting Guide](../reference/troubleshooting/)
- [Best Practices](../guides/best-practices/)
- [Component Documentation](../components/)

{: .success }
Congratulations! You've successfully deployed your first stream on {{ site.product_name }}! 🎉
