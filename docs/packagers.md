---
layout: default
title: Packagers
nav_order: 4
---

# Packagers
{: .no_toc }

Packagers transform transcoded video into streaming formats for delivery to end-users.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Packagers are essential components that convert transcoded video renditions into streaming formats suitable for different devices and platforms. The Encora Stream platform supports three main packaging formats:

- **AES Packager**: For AES-128 encrypted streaming
- **DASH Packager**: For MPEG-DASH streaming with optional DRM
- **HLS Packager**: For HLS (HTTP Live Streaming) with optional DRM

Each packager type generates specific manifest files and media segments optimized for its target protocol and devices.

## Packaging Formats Comparison

| Feature | AES | DASH | HLS |
|---------|-----|------|-----|
| **Primary Use** | Set-top boxes, older devices | Web browsers (Chrome, Edge) | Apple devices (iOS, Safari) |
| **Encryption** | AES-128 | CENC with DRM | FairPlay DRM |
| **File Extension** | .m3u8 | .mpd | .m3u8 |
| **Segment Format** | .ts | .mp4 | .ts |
| **DRM Support** | Basic encryption | Widevine, PlayReady | FairPlay |
| **Browser Support** | Limited | Chrome, Edge, Firefox | Safari only |

## AES Packager

### Overview

AES Packager creates encrypted HLS streams using AES-128 encryption. This format is widely compatible with set-top boxes and media players that support HLS with basic encryption.

### Key Features

- AES-128 encryption for content protection
- HLS-compatible .m3u8 playlists
- .ts (Transport Stream) segments
- Compatible with VLC and most set-top boxes
- No DRM server required

### Adding an AES Packager

**Steps:**

1. Navigate to **AES Packagers** from the left sidebar
2. Click **Add AES Packager** button
3. **Select Input Stream**: Choose the source stream
4. **Select Transcoder**: Choose associated transcoder
5. **Select Server**: Choose packaging server
6. **Select Server Interface**: Choose network interface
7. **Configure Media Directory**: Set output path (e.g., `/opt/es/media/packager`)
8. **Configure Segment Duration**: Set segment length (typically 4-10 seconds)
9. **Configure Target Duration**: Set playlist target duration
10. **Configure Buffer Time**: Set playback buffer (e.g., 12 seconds)
11. **Select Audio**: Choose audio track(s) from available options
12. **Enable Packager**: Toggle Enable = ON
13. Click **Save**

### Configuration Parameters

| Parameter | Description | Typical Value |
|-----------|-------------|---------------|
| Input Stream | Source video stream | Content ID reference |
| Transcoder | Associated transcoder | Selected transcoder |
| Server | Packaging server | packager-server-01 |
| Server Interface | Network interface | eth0 or primary interface |
| Media Directory | Output path | `/opt/es/media/packager` |
| Segment Duration | Chunk length in seconds | 4-10 seconds |
| Target Duration | Playlist target duration | 10 seconds |
| Buffer Time | Playback buffer | 12 seconds |
| Audio Tracks | Selected audio streams | English, Spanish, etc. |

### Testing AES Streams

**VLC Player:**
```
File → Open Network Stream → Enter playlist URL
```

**ffplay:**
```bash
ffplay "http://origin-server/path/to/playlist.m3u8"
```

**Web Browser:**
Use a web player that supports HLS (limited browser support)

## DASH Packager

### Overview

DASH (Dynamic Adaptive Streaming over HTTP) Packager creates MPEG-DASH streams suitable for web browsers and Android devices. Supports advanced DRM systems including Widevine and PlayReady.

### Key Features

- MPEG-DASH format for broad web compatibility
- .mpd (Media Presentation Description) manifests
- .mp4 segments for efficient streaming
- DRM support via CPIX integration
- Optimized for Chrome, Edge, and Firefox browsers

### Adding a DASH Packager

**Steps:**

1. Navigate to **DASH Packagers** from the left sidebar
2. Click **Add DASH Packager** button
3. **Select Input Stream**: Choose the source stream
4. **Select Transcoder**: Choose associated transcoder
5. **Select Server**: Choose packaging server
6. **Select Server Interface**: Choose network interface
7. **Configure Media Directory**: Set output path
8. **Configure Segment Duration**: Set segment length (typically 4 seconds)
9. **Configure Min Buffer Time**: Set minimum buffer (e.g., 12 seconds)
10. **Select Audio**: Choose audio track(s)
11. **DRM Configuration** (if required):
    - Enable DRM toggle
    - Enter Tenant ID (from DRM provider)
    - Configure CPIX API settings
12. **Enable Packager**: Toggle Enable = ON
13. Click **Save**

### Configuration Parameters

| Parameter | Description | Typical Value |
|-----------|-------------|---------------|
| Input Stream | Source video stream | Content ID reference |
| Transcoder | Associated transcoder | Selected transcoder |
| Server | Packaging server | packager-server-01 |
| Server Interface | Network interface | eth0 |
| Media Directory | Output path | `/opt/es/media/packager` |
| Segment Duration | Chunk length | 4 seconds |
| Min Buffer Time | Minimum buffer | 12 seconds |
| Audio Tracks | Selected audio | Multiple audio tracks |
| Enable DRM | DRM protection toggle | ON/OFF |
| Tenant ID | DRM provider tenant ID | Organization ID |
| CPIX API URL | Key server endpoint | https://cpix-api.example.com |

### DRM Configuration

**When to Use DRM:**
- Premium content requiring protection
- Licensed content with DRM requirements
- Preventing unauthorized redistribution
- Meeting content provider security requirements

**DRM Setup:**
1. Obtain Tenant ID from DRM provider
2. Configure CPIX API access
3. Test key retrieval before production
4. Monitor license server availability
5. Implement key rotation policies

### Testing DASH Streams

**Web Browser (Chrome/Edge):**
Use DASH.js or Shaka Player in a test page

**DASH.js test page:**
```html
https://reference.dashif.org/dash.js/
```

**Android Device:**
Use ExoPlayer-based applications

## HLS Packager

### Overview

HLS (HTTP Live Streaming) Packager creates Apple HLS streams optimized for iOS, iPadOS, macOS, and Safari browsers. Supports FairPlay DRM for content protection.

### Key Features

- Apple HLS format for Apple ecosystem
- .m3u8 master and variant playlists
- .ts segments for compatibility
- FairPlay DRM integration
- Optimized for iOS, Safari, and Apple devices

### Adding an HLS Packager

**Steps:**

1. Navigate to **HLS Packagers** from the left sidebar
2. Click **Add HLS Packager** button
3. **Select Input Stream**: Choose the source stream
4. **Select Transcoder**: Choose associated transcoder
5. **Select Server**: Choose packaging server
6. **Select Server Interface**: Choose network interface
7. **Configure Media Directory**: Set output path
8. **Configure Segment Duration**: Set segment length (typically 6 seconds)
9. **Configure Target Duration**: Set target duration (e.g., 10 seconds)
10. **Configure Buffer Time**: Set buffer time (e.g., 12 seconds)
11. **Select Audio**: Choose audio track(s)
12. **DRM Configuration** (if required):
    - Enable DRM toggle
    - Enter Tenant ID
    - Configure CPIX API settings for FairPlay
13. **Enable Packager**: Toggle Enable = ON
14. Click **Save**

### Configuration Parameters

| Parameter | Description | Typical Value |
|-----------|-------------|---------------|
| Input Stream | Source video stream | Content ID reference |
| Transcoder | Associated transcoder | Selected transcoder |
| Server | Packaging server | packager-server-01 |
| Server Interface | Network interface | eth0 |
| Media Directory | Output path | `/opt/es/media/packager` |
| Segment Duration | Chunk length | 6 seconds |
| Target Duration | Playlist target | 10 seconds |
| Buffer Time | Playback buffer | 12 seconds |
| Audio Tracks | Selected audio | Multiple audio tracks |
| Enable DRM | FairPlay DRM toggle | ON/OFF |
| Tenant ID | DRM provider ID | Organization ID |

### Testing HLS Streams

**Safari Browser:**
Native HLS support - paste URL directly

**iOS Device:**
Use Safari or native player apps

**macOS:**
Safari or QuickTime Player

**VLC (all platforms):**
```
File → Open Network Stream → Enter playlist URL
```

## Common Operations

### Viewing Packager Details

All packager types display similar information:

**Basic Info:**
- Input Stream reference
- Content ID
- Associated Transcoder
- Server and Interface
- Live Status (RUNNING / STOPPED)

**Configuration:**
- Media Directory path
- Segment Duration
- Buffer settings
- Audio track configuration
- DRM settings (if enabled)

**Timestamps:**
- Created At
- Updated At

### Editing Packagers

**Editable Fields:**
- Server assignment
- Network interface
- Media directory
- Segment duration
- Buffer time
- Audio track selection
- DRM configuration

**Non-editable:**
- Input Stream (must recreate)
- Packager type (must recreate)

**Workflow:**
1. Navigate to packager details
2. Click **Edit** button
3. Modify desired settings
4. Click **Save** or **Cancel**

### Enabling / Disabling

**Toggle packager state without deleting:**

1. Navigate to packager list or details
2. Click toggle icon or Enable/Disable button
3. Confirm the action
4. Monitor status change

### Deleting Packagers

**Warning:** Ensure no active viewers before deletion.

**Workflow:**
1. Disable the packager first
2. Click Delete (bin) icon
3. Confirm deletion
4. Verify removal

## Media Directory Structure

### Directory Organization

Packagers write output to the configured media directory with the following structure:

```
/opt/es/media/packager/
├── {content-id}/
│   ├── aes/
│   │   ├── playlist.m3u8
│   │   ├── segment-001.ts
│   │   ├── segment-002.ts
│   │   └── ...
│   ├── dash/
│   │   ├── manifest.mpd
│   │   ├── segment-001.mp4
│   │   ├── segment-002.mp4
│   │   └── ...
│   └── hls/
│       ├── master.m3u8
│       ├── variant-1080p.m3u8
│       ├── segment-001.ts
│       └── ...
```

### Directory Requirements

- **Writable** by packager service
- **Sufficient disk space** for segments (typically 100+ GB)
- **Fast I/O** for segment creation and deletion
- **Accessible** by origin servers for content delivery
- **Monitored** for disk space usage

## Segment Management

### Segment Duration Guidelines

**AES & HLS:**
- **Short (4-6 seconds)**: Lower latency, more segments
- **Medium (6-10 seconds)**: Balanced approach
- **Long (10+ seconds)**: Higher latency, fewer segments

**DASH:**
- **Typical: 4 seconds**: Optimized for web delivery
- **Low-latency: 2 seconds**: Real-time applications
- **Standard: 4-6 seconds**: Most use cases

### Buffer Time Configuration

**Playback Buffer:**
- Minimum: 8-12 seconds
- Recommended: 12-20 seconds for stability
- High-latency networks: 20-30 seconds

**Trade-offs:**
- Longer buffer: More stable playback, higher latency
- Shorter buffer: Lower latency, risk of buffering

## Audio Track Configuration

### Multiple Audio Support

All packager types support multiple audio tracks:

- **Multi-language**: English, Spanish, French, etc.
- **Descriptive Audio**: For accessibility
- **Multiple Bitrates**: Standard and low-bandwidth

### Audio Selection

1. Review available audio from transcoder output
2. Enable required audio tracks in packager configuration
3. Verify audio appears in manifest files
4. Test playback with different audio selections

### Audio Debugging

**Issue: No audio in playback**

1. Check input stream has audio
2. Verify transcoder includes audio renditions
3. Ensure at least one audio track is selected in packager
4. Use ffprobe to verify audio in segments

## DRM Best Practices

### When to Enable DRM

**Use DRM for:**
- Premium subscription content
- Licensed movies and TV shows
- Sports events with broadcast rights
- Content requiring robust protection

**Skip DRM for:**
- Free content
- Public domain material
- Internal corporate communications
- Development and testing

### DRM Configuration Checklist

- [ ] Obtain Tenant ID from DRM provider
- [ ] Configure CPIX API endpoint
- [ ] Test key retrieval functionality
- [ ] Verify DRM provider availability
- [ ] Implement key rotation schedule
- [ ] Monitor license server health
- [ ] Plan for DRM provider failover
- [ ] Document DRM configuration

### DRM Troubleshooting

**Error: "No packages found to the Content"**

This error occurs when packager cannot retrieve encryption keys from CPIX API.

**Resolution:**
1. Verify CPIX API URL is correct
2. Check Tenant ID is valid
3. Ensure network connectivity to CPIX server
4. Verify DRM provider service is operational
5. Review packager logs for detailed errors
6. Contact DRM provider support if needed

## Performance Optimization

### Server Resource Planning

**Per Packager Requirements:**
- CPU: 0.5-1 core per packager
- Memory: 512 MB - 1 GB per packager
- Disk I/O: Fast storage for segment writes
- Network: Sufficient bandwidth for origin delivery

### Scaling Guidelines

**Single Server Capacity:**
- Small deployment: 5-10 packagers
- Medium deployment: 10-20 packagers
- Large deployment: Distribute across servers

**Indicators to Scale:**
- CPU usage consistently above 70%
- Disk I/O saturation
- Increased segment creation latency
- Origin fetch delays

## Monitoring and Alerts

### Key Metrics

Monitor these indicators:

- **Status**: RUNNING vs STOPPED
- **Segment Creation Rate**: Consistent with segment duration
- **Disk Space**: Available space in media directory
- **CPU Usage**: Packager process resources
- **Error Logs**: Packaging failures

### Alert Conditions

Set up alerts for:
- Packager status changes to STOPPED
- Disk space below 10% free
- Missing segments or manifest files
- DRM key retrieval failures
- Unusually high CPU usage

## Troubleshooting

### Not Streaming

**Symptoms:**
- Player shows no video
- 404 errors for playlist URLs
- Manifest files not generated

**Debug Steps:**
1. Verify input stream is active
2. Check transcoder status is RUNNING
3. Confirm packager status is RUNNING
4. Test playlist URL accessibility
5. Review packager logs for errors
6. Check media directory permissions
7. Verify disk space availability

### Buffering Issues

**Symptoms:**
- Frequent playback interruptions
- Slow segment loading
- Player shows buffering indicator

**Debug Steps:**
1. Test segment download times in browser network tab
2. Check origin server load and bandwidth
3. Verify CDN is functioning properly
4. Review segment duration configuration
5. Increase buffer time if needed
6. Monitor packager CPU usage

### 404 Not Found

**Symptoms:**
- Playlist or segments return 404 errors

**Debug Steps:**
1. Verify Content ID is correct (case-sensitive)
2. Check media directory path exists
3. Confirm origin server is serving correct path
4. Review web server configuration
5. Test direct file access on origin server

### Mosaic / Corruption

**Symptoms:**
- Blocky video artifacts
- Audio/video desync
- Playback freezes

**Debug Steps:**
1. Check input stream quality with ffprobe
2. Verify encoder is sending stable stream
3. Test transcoder output quality
4. Restart transcoder and packager
5. Monitor network packet loss

## Best Practices Summary

### Configuration

✓ Choose appropriate segment duration for your use case
✓ Configure adequate buffer time for network conditions
✓ Enable only required audio tracks
✓ Use DRM only when necessary
✓ Test configuration before production deployment

### Operations

✓ Monitor packager status continuously
✓ Set up alerts for failures
✓ Maintain sufficient disk space
✓ Rotate logs regularly
✓ Document DRM configurations

### Security

✓ Enable DRM for premium content
✓ Rotate encryption keys regularly
✓ Monitor CPIX API health
✓ Restrict access to media directories
✓ Use HTTPS for all delivery URLs

### Performance

✓ Distribute packagers across servers
✓ Monitor CPU and disk I/O
✓ Use fast storage for media directories
✓ Implement CDN for content delivery
✓ Test under peak load conditions

## Related Documentation

- [Input Streams]({% link docs/input-streams.md %}) - Configure source streams
- [Transcoders]({% link docs/transcoders.md %}) - Set up transcoding
- [Origin Servers]({% link docs/origin-servers.md %}) - Deploy content delivery
- [Troubleshooting]({% link docs/troubleshooting.md %}) - Resolve issues
