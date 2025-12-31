---
layout: default
title: Testing & Validation
parent: Input Streams
grand_parent: Platform Components
nav_order: 3
---

# Testing & Validation
{: .no_toc }

Methods to verify your input streams are working correctly.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Testing input streams before connecting them to transcoders ensures smooth operation and helps identify issues early.

{: .important }
Always test input streams in a staging environment before production deployment.

---

## Quick Verification

### Method 1: VLC Player (Easiest)

VLC is the simplest way to verify your input stream is working:

**Steps:**
1. Open VLC Media Player
2. Select **Media** → **Open Network Stream** (or press `Ctrl+N`)
3. Enter your Source URL
4. Click **Play**

**Expected Result:**
- Video plays smoothly without interruptions
- Audio is synchronized with video
- Quality is as expected from encoder

**UDP Example:**
```
udp://@239.1.1.1:5000
```

**RTMP Example:**
```
rtmp://encoder.example.com:1935/live/stream-key
```

---

### Method 2: ffprobe (Detailed Info)

`ffprobe` provides detailed technical information about your stream:

**Command:**
```bash
ffprobe -v error -show_format -show_streams udp://@239.1.1.1:5000
```

**Expected Output:**
```
Input #0, mpegts, from 'udp://@239.1.1.1:5000':
  Duration: N/A, start: 12345.678, bitrate: 8192 kb/s
    Stream #0:0[0x100]: Video: h264, yuv420p, 1920x1080, 29.97 fps
    Stream #0:1[0x101]: Audio: aac, 48000 Hz, stereo, 128 kb/s
```

**What to Check:**
- ✅ Video codec (should be h264 or hevc)
- ✅ Resolution (e.g., 1920x1080)
- ✅ Frame rate (e.g., 29.97 fps or 25 fps)
- ✅ Audio codec (should be aac)
- ✅ Audio sample rate (typically 48000 Hz)
- ✅ Bitrate is reasonable

---

### Method 3: ffplay (Visual Test)

`ffplay` provides playback with minimal latency for testing:

**Command:**
```bash
ffplay udp://@239.1.1.1:5000
```

**Keyboard Controls:**
- `Q` - Quit
- `F` - Toggle fullscreen
- `P` or `Space` - Pause
- `M` - Mute audio

---

## Detailed Testing Procedures

### UDP Multicast Testing

#### Step 1: Verify Network Connectivity

**Check multicast routing:**
```bash
ip route show | grep multicast
```

**Expected output:**
```
224.0.0.0/4 dev eth0 scope link
```

#### Step 2: Monitor Network Traffic

**Capture multicast packets:**
```bash
sudo tcpdump -i eth0 host 239.1.1.1 and port 5000 -c 100
```

**What to look for:**
- Packets are arriving
- No excessive packet loss
- Consistent packet sizes

#### Step 3: Check Stream Properties

**Get detailed stream information:**
```bash
ffprobe -v error -show_streams udp://@239.1.1.1:5000
```

#### Step 4: Test Playback

**Play stream:**
```bash
ffplay -fflags nobuffer udp://@239.1.1.1:5000
```

---

### RTMP Testing

#### Step 1: Verify Server Reachability

**Test TCP connection:**
```bash
telnet encoder.example.com 1935
```

**Expected:**
```
Trying encoder.example.com...
Connected to encoder.example.com.
```

Press `Ctrl+]` then type `quit` to exit.

#### Step 2: Test Stream Availability

**Check if stream is live:**
```bash
ffprobe rtmp://encoder.example.com:1935/live/stream-key
```

#### Step 3: Test Playback

**Play RTMP stream:**
```bash
ffplay rtmp://encoder.example.com:1935/live/stream-key
```

---

## Automated Testing

### Stream Health Check Script

Create a simple health check script:

```bash
#!/bin/bash
# stream-check.sh

STREAM_URL="$1"
TIMEOUT=10

echo "Testing stream: $STREAM_URL"

# Test with ffprobe
if timeout $TIMEOUT ffprobe -v error -show_streams "$STREAM_URL" > /dev/null 2>&1; then
    echo "✅ Stream is accessible"
    
    # Get stream details
    ffprobe -v error -show_entries stream=codec_type,width,height,codec_name "$STREAM_URL"
else
    echo "❌ Stream is not accessible"
    exit 1
fi
```

**Usage:**
```bash
chmod +x stream-check.sh
./stream-check.sh "udp://@239.1.1.1:5000"
```

---

## Validation Checklist

Before marking an input stream as production-ready, verify:

### Video Validation
- [ ] Video codec is H.264 or HEVC
- [ ] Resolution matches expected (e.g., 1920x1080)
- [ ] Frame rate is consistent (29.97 fps or 25 fps)
- [ ] Bitrate is appropriate for content (5-15 Mbps for HD)
- [ ] No visible artifacts or corruption
- [ ] Color space is correct
- [ ] Aspect ratio is correct

### Audio Validation
- [ ] Audio codec is AAC or MPEG Audio
- [ ] Sample rate is 48000 Hz (or 44100 Hz)
- [ ] Audio channels are correct (stereo or multi-channel)
- [ ] Audio bitrate is appropriate (128-256 kbps)
- [ ] Audio is synchronized with video
- [ ] No audio dropouts or glitches
- [ ] Volume levels are appropriate

### Network Validation
- [ ] Stream is consistently accessible
- [ ] No packet loss or minimal loss (< 0.1%)
- [ ] Latency is acceptable
- [ ] Bandwidth is sufficient
- [ ] Firewall allows traffic
- [ ] No network routing issues

### Configuration Validation
- [ ] Content ID is unique
- [ ] Content ID is case-consistent
- [ ] Source URL is correct
- [ ] Server assignment is appropriate
- [ ] Documentation is complete

---

## Performance Testing

### Measure Stream Bitrate

**Using ffprobe:**
```bash
ffprobe -v error -select_streams v:0 -show_entries \
  stream=bit_rate -of default=nokey=1:noprint_wrappers=1 \
  udp://@239.1.1.1:5000
```

### Check Packet Loss

**Monitor with tcpdump:**
```bash
sudo tcpdump -i eth0 host 239.1.1.1 -c 1000 | \
  awk '{print $1}' | uniq -c
```

### Measure Latency

**Test end-to-end latency:**
1. Display timecode on encoder output
2. Play stream with VLC or ffplay
3. Compare displayed timecode with reference
4. Calculate latency difference

---

## Troubleshooting Test Failures

### VLC Cannot Play Stream

**Possible Causes:**
- Stream URL is incorrect
- Network connectivity issue
- Encoder not transmitting
- Firewall blocking traffic

**Solutions:**
1. Verify URL format is correct
2. Test network connectivity with ping/telnet
3. Check encoder status and output
4. Review firewall rules

### ffprobe Shows No Streams

**Possible Causes:**
- Stream not available at that moment
- Wrong URL or port
- Codec not supported
- Network routing issue

**Solutions:**
1. Verify encoder is streaming
2. Check URL and port are correct
3. Test with different tool (VLC)
4. Check network configuration

### Playback Stutters or Buffers

**Possible Causes:**
- Insufficient bandwidth
- Packet loss on network
- Encoder output unstable
- Server resource constraints

**Solutions:**
1. Check available bandwidth
2. Monitor packet loss with tcpdump
3. Verify encoder settings and stability
4. Check server CPU and network utilization

---

## Continuous Monitoring

### Set Up Monitoring

For production streams, implement continuous monitoring:

**Monitor script example:**
```bash
#!/bin/bash
# monitor-stream.sh

STREAM_URL="$1"
INTERVAL=60  # Check every 60 seconds

while true; do
    if timeout 10 ffprobe -v error "$STREAM_URL" > /dev/null 2>&1; then
        echo "[$(date)] ✅ Stream OK"
    else
        echo "[$(date)] ❌ Stream FAILED"
        # Alert logic here (email, SMS, etc.)
    fi
    sleep $INTERVAL
done
```

---

## Related Documentation

- [Configuration Guide](../configuration/) - Set up input streams
- [Protocol Support](../protocols/) - UDP and RTMP details
- [Best Practices](../best-practices/) - Optimization tips
- [Troubleshooting](../../../reference/troubleshooting/) - Common issues
