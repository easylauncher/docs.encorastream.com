---
layout: default
title: Troubleshooting
nav_order: 7
---

# Troubleshooting Guide
{: .no_toc }

Solutions for common issues in the Encora Stream platform.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

This troubleshooting guide provides systematic approaches to diagnose and resolve common issues in the Encora Stream platform. For each issue, we provide possible causes, debugging steps, and resolution procedures.

## Common Issues Reference

### Quick Issue Lookup

| Symptom | Likely Cause | Section |
|---------|--------------|---------|
| No video playback | Input, transcoder, or packager issue | [Not Streaming](#not-streaming) |
| Blocky video artifacts | Network or encoder problems | [Mosaic](#mosaic) |
| Frequent pausing | Bandwidth or buffering issue | [Buffering](#buffering) |
| 404 error on playback | Configuration or path issue | [404 Not Found](#404-not-found) |
| Input not working | Encoder or network problem | [Input Stream Issues](#input-stream-not-working) |
| Playback stops after few seconds | Stream interruption | [Streaming Stuck](#streaming-stuck-after-few-seconds) |
| Missing encryption keys | DRM configuration issue | [DRM Errors](#drm-and-encryption-issues) |
| No audio | Audio configuration issue | [Audio Not Coming](#audio-not-coming) |
| Stream delay/lag | Latency or catchup issue | [Running with Delay](#running-with-delay-catchup) |

## Not Streaming

### Symptoms

- Player shows no video
- Black screen or error message
- Unable to load stream
- Playlist or manifest not accessible

### Possible Reasons

1. The input stream may be misconfigured or stopped
2. The transcoder may be misconfigured or not running properly
3. The packager may be misconfigured or not running properly
4. Network connectivity issues
5. Origin server not serving content

### Debugging Steps

1. **Check Input Stream Configuration**
   - Verify Content ID is correct (case-sensitive)
   - Confirm Content ID matches between input stream, transcoder, and packager
   - Check for trailing spaces or special characters

2. **Verify Input Stream on Server**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ```
   - Look for video and audio stream information
   - Verify bitrate and codec information appears

3. **Test Input Stream with VLC Player**
   - Open VLC → Media → Open Network Stream
   - Enter the input stream URL
   - Verify playback works smoothly

4. **Check Transcoder Status**
   - Navigate to Transcoders in dashboard
   - Verify status shows "RUNNING"
   - If not running, check error messages
   - **If stopped**: Disable and re-enable to restart

5. **Check Packager Status**
   - Navigate to Packagers (AES/DASH/HLS) in dashboard
   - Verify status shows "RUNNING"
   - Check for error messages
   - **If stopped**: Disable and re-enable to restart

6. **Restart Components**
   - Try restarting the transcoder (Disable → Enable)
   - Restart respective packager (Disable → Enable)
   - Wait 30-60 seconds for components to initialize

7. **Test AES Playlist URL with VLC**
   ```
   http://origin-server/content-id/aes/playlist.m3u8
   ```
   - Verify URL is accessible
   - Check if segments are being created

8. **Escalate if Still Not Fixed**
   - Document all troubleshooting steps taken
   - Capture relevant error messages
   - Note which components were checked
   - Provide this information to support team

## Mosaic

### Symptoms

- Blocky video artifacts
- Pixelated or distorted video
- Partial frame corruption
- Visual quality degradation

### Possible Reasons

1. Incorrect VLAN tagging or multicast routing
2. Source encoder is not sending a stable stream
3. Network packet loss or corruption
4. The transcoder may not be running properly
5. The packager may not be running properly
6. Insufficient bandwidth on network path

### Debugging Steps

1. **Check Input Stream Quality**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ffplay udp://@239.1.1.1:5000
   ```
   - Look for error messages
   - Verify stream stability
   - Check for discontinuities

2. **Monitor Network Quality**
   ```bash
   # Check for packet loss
   tcpdump -i eth0 host 239.1.1.1 and port 5000 -c 1000
   ```
   - Monitor for dropped packets
   - Check network utilization
   - Verify VLAN configuration

3. **Check Encoder Settings**
   - Verify encoder output settings are correct
   - Check encoder health and logs
   - Ensure encoder network connection is stable
   - Verify encoder bitrate is appropriate

4. **Restart Transcoder and Packager**
   - Disable transcoder → Wait 10 seconds → Enable
   - Disable packager → Wait 10 seconds → Enable
   - Monitor video quality after restart

5. **Test on Multiple Devices**
   - Try different players or devices
   - Check if issue is player-specific
   - Verify problem exists across all renditions

6. **Escalate if Not Fixed**
   - Provide network diagnostics
   - Include encoder information
   - Document when issue started
   - Note if issue is intermittent or constant

## Buffering

### Symptoms

- Frequent playback pauses
- Loading indicator appears often
- Stuttering playback
- Slow segment loading

### Possible Reasons

1. The transcoder may not be running properly
2. The packager may not be running properly
3. Segments are not downloading in expected time
4. Insufficient bandwidth on client side
5. Origin server overloaded
6. Network congestion or latency

### Debugging Steps

1. **Test in Browser with Network Tools**
   - Open browser developer tools (F12)
   - Go to Network tab
   - Play the stream
   - Monitor segment download times
   
   **Analysis:**
   - Segments should download faster than their duration
   - Example: 6-second segment should download in < 6 seconds
   - Look for slow or failed requests

2. **If Segments Download Slowly**
   - **Diagnose the network:**
     - Test bandwidth from client location
     - Check for network congestion
     - Verify CDN is functioning properly
     - Test from different network/location
   
   - **Check origin server:**
     - Monitor CPU and memory usage
     - Check disk I/O performance
     - Verify sufficient bandwidth available
     - Review origin server logs

3. **If Segments Download Quickly but Still Buffering**
   - **Issue may be in transcoding or packaging:**
     - Restart transcoder (Disable → Enable)
     - Restart packager (Disable → Enable)
     - Monitor transcoder CPU usage
     - Check for transcoding delays

4. **Increase Buffer Time**
   - Edit packager configuration
   - Increase buffer time (e.g., from 12 to 20 seconds)
   - Save and monitor improvement

5. **Check Player Configuration**
   - Verify player buffer settings
   - Ensure adaptive bitrate is working
   - Check if player is selecting appropriate quality

6. **Escalate if Not Resolved**
   - Provide network test results
   - Include segment download timing data
   - Document player and device information
   - Note geographic location if relevant

## 404 Not Found

### Symptoms

- HTTP 404 error when accessing playlist
- Segments return 404 errors
- Player unable to load manifest
- URL not found errors

### Possible Reasons

1. The input stream may be misconfigured
2. Content ID mismatch
3. Media directory not configured correctly
4. Origin server not serving correct path
5. Packager not generating output files

### Debugging Steps

1. **Verify Content ID**
   - Check input stream Content ID (case-sensitive)
   - Verify transcoder uses same Content ID
   - Confirm packager uses same Content ID
   - Look for typos or extra spaces

2. **Check Input Stream on Server**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ```
   - Verify input stream is accessible
   - Confirm stream is active

3. **Test Input Stream with VLC**
   - Verify encoder is sending stream
   - Check stream stability

4. **Check Transcoder Status**
   - Verify status is "RUNNING"
   - If stopped, restart (Disable → Enable)

5. **Check Packager Status**
   - Verify status is "RUNNING"
   - If stopped, restart (Disable → Enable)

6. **Verify Files Exist on Origin**
   ```bash
   ls -la /opt/es/media/packager/{content-id}/
   ```
   - Check if playlist/manifest files exist
   - Verify segments are being created
   - Check file permissions

7. **Test Direct File Access**
   ```bash
   curl -I http://origin-server/content-id/aes/playlist.m3u8
   ```
   - Should return 200 OK
   - If 404, check web server configuration
   - Verify path mappings

8. **Restart Components**
   - Restart transcoder (Disable → Enable)
   - Restart packager (Disable → Enable)
   - Wait for segments to generate

9. **Escalate if Not Resolved**
   - Provide Content ID used
   - Include URL that returns 404
   - Document component statuses
   - Include directory listing if accessible

## Input Stream Not Working

### Symptoms

- Input stream shows as inactive
- Cannot connect to input source
- Transcoder reports no input
- ffprobe fails to read stream

### Possible Reasons

1. Encoder might have issues
2. Network connectivity problems
3. Firewall blocking traffic
4. Incorrect source URL
5. Multicast routing not configured

### Debugging Steps

1. **Check Encoder Status**
   - Verify encoder is powered on and running
   - Check encoder output settings
   - Review encoder logs for errors
   - Confirm encoder network connection

2. **Test Network Connectivity**
   ```bash
   # For UDP multicast
   tcpdump -i eth0 host 239.1.1.1 and port 5000
   
   # For RTMP
   curl -I rtmp://encoder-server:1935/live/stream-key
   ```

3. **Verify Source URL**
   - Check URL is correctly formatted
   - Verify IP address or hostname
   - Confirm port number
   - Check protocol (udp:// or rtmp://)

4. **Check Firewall Rules**
   - Verify firewall allows traffic
   - Check iptables or security groups
   - Ensure multicast is enabled (for UDP)
   - Verify routing for RTMP

5. **Test from Server**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ffplay udp://@239.1.1.1:5000
   ```

6. **Escalate to Encoder Team**
   - Provide encoder model and configuration
   - Include network test results
   - Document error messages
   - Note when issue started

## Streaming Stuck After Few Seconds

### Symptoms

- Player starts playback normally
- Video stops after 10-60 seconds
- Player appears frozen
- No new segments loading

### Possible Reasons

1. Input stream might have stopped
2. Transcoder may not be running properly
3. Packager may not be running properly
4. Encoder stopped sending stream
5. Network interruption

### Debugging Steps

1. **Check Input Stream**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ```
   - Verify stream is still active
   - Check for recent connectivity

2. **Monitor Input Stream Continuously**
   ```bash
   ffplay udp://@239.1.1.1:5000
   ```
   - Watch for interruptions
   - Verify continuous playback

3. **Check Component Status**
   - Verify transcoder status is RUNNING
   - Verify packager status is RUNNING
   - Look for recent status changes

4. **Restart Components**
   - Restart transcoder (Disable → Enable)
   - Restart packager (Disable → Enable)
   - Test playback again

5. **Check Encoder Health**
   - Verify encoder is operating normally
   - Check encoder temperature and resources
   - Review encoder logs

6. **Escalate if Not Fixed**
   - Document exact duration before stopping
   - Provide encoder information
   - Include component statuses
   - Note if issue is reproducible

## DRM and Encryption Issues

### Symptoms

- Error message: "No packages found to the Content"
- License acquisition fails
- Playback blocked with DRM error
- Player shows encryption error

### Possible Reasons

1. Packager cannot retrieve encryption keys from CPIX API
2. Invalid Tenant ID
3. CPIX API unavailable or misconfigured
4. Network connectivity to DRM provider
5. DRM provider service issues

### Debugging Steps

**Note:** This error appears in DASH and HLS packagers but NOT in AES packager.

1. **Verify DRM Configuration**
   - Check Tenant ID is correct
   - Verify CPIX API URL is accurate
   - Confirm DRM provider credentials

2. **Test CPIX API Connectivity**
   ```bash
   curl -I https://cpix-api.example.com/endpoint
   ```
   - Verify API is accessible
   - Check for authentication issues
   - Review response codes

3. **Check Network Connectivity**
   - Verify server can reach DRM provider
   - Check firewall rules
   - Test DNS resolution

4. **Review Packager Logs**
   - Look for CPIX API errors
   - Check for authentication failures
   - Note specific error messages

5. **Verify DRM Provider Service**
   - Check DRM provider status page
   - Verify service is operational
   - Contact DRM provider if needed

6. **Test Without DRM**
   - Temporarily disable DRM
   - Test if streaming works
   - Helps isolate DRM as issue

7. **Escalate to DRM Team**
   - Provide Tenant ID (sanitized if needed)
   - Include CPIX API endpoint
   - Share packager error logs
   - Document when issue started

## Audio Not Coming

### Symptoms

- Video plays but no audio
- Audio track missing
- Silent playback
- Audio selector shows no options

### Possible Reasons

1. No audio stream selected in packager
2. Input stream has no audio
3. Audio track disabled
4. Transcoder not processing audio
5. Audio codec compatibility issue

### Debugging Steps

1. **Check Input Stream for Audio**
   ```bash
   ffprobe -v error -show_streams udp://@239.1.1.1:5000
   ```
   - Look for audio stream entries
   - Verify audio codec information
   - Check audio is present in source

2. **Check Packager Configuration**
   - Navigate to packager settings
   - Look at audio track selection
   - **Verify at least one audio stream is enabled**
   - Check if correct audio track is selected

3. **Enable Audio Track**
   - Edit packager configuration
   - Select appropriate audio track(s)
   - Save configuration
   - Test playback again

4. **Verify Transcoder Audio Settings**
   - Check if transcoder includes audio
   - Verify audio renditions are configured
   - Confirm audio is in transcoder output

5. **Test Audio in Segments**
   ```bash
   ffprobe -v error -show_streams /path/to/segment.ts
   ```
   - Verify audio codec in segments
   - Check audio is present in files

6. **Check Player Audio Settings**
   - Verify player is not muted
   - Check if audio track selection is available
   - Try different audio quality/language if available

7. **Escalate if Not Resolved**
   - Provide input stream details
   - Include audio configuration
   - Note if issue is all content or specific
   - Specify which formats affected (AES/DASH/HLS)

## Running with Delay (Catchup)

### Symptoms

- Stream is behind live (several seconds or minutes)
- Player shows old content
- "Go Live" button appears
- Time delay compared to AES stream

### Possible Reasons

1. The transcoder may not be running properly
2. The packager may not be running properly
3. Player in catchup mode
4. Network buffering
5. Client-side issue

### Debugging Steps

1. **Compare Stream Delays**
   - Play AES stream and DASH/HLS stream side by side
   - Measure time difference
   - If delay is > 10 seconds, investigate further

2. **Check for "Go Live" Button**
   - Look for "Go Live" button in player
   - Click button and see if delay fixes
   - **If fixed:** This indicates a player/app issue
   - Mobile app team needs to address

3. **Follow Up with Mobile App Team**
   - If "Go Live" button fixes issue, it's client-side
   - Document behavior and provide to app developers
   - Note which app version is affected

4. **Check Transcoder Performance**
   - Monitor transcoder CPU usage
   - Look for processing delays
   - Check if transcoder is keeping up with input

5. **Check Packager Performance**
   - Verify packager is creating segments on time
   - Check segment timestamps
   - Monitor packager resource usage

6. **Verify Segment Duration Configuration**
   - Check if segment duration is appropriate
   - Shorter segments = lower latency
   - Review buffer time settings

7. **Restart Components if Needed**
   - Restart transcoder if showing delays
   - Restart packager if segments are delayed
   - Monitor improvement

8. **Escalate with Details**
   - Specify measured delay time
   - Note if issue is consistent or intermittent
   - Include player/app version
   - Provide component performance data

## Testing Procedures

### AES Testing

**Compatible Platforms:**
- Web browsers (with HLS.js)
- VLC Player
- Set-top boxes

**Testing Methods:**

1. **Browser Testing:**
   - Use web player that supports HLS
   - Open developer tools for debugging
   - Monitor network requests

2. **VLC Testing:**
   ```
   Media → Open Network Stream
   Enter: http://origin-server/content-id/aes/playlist.m3u8
   ```

3. **Set-Top Box Testing:**
   - Configure box with stream URL
   - Test playback quality
   - Verify channel switching

### DASH Testing

**Compatible Platforms:**
- Web browsers: Edge, Chrome, Firefox
- Android phones and tablets
- Any device with DASH support

**Testing Methods:**

1. **Browser Testing:**
   - Use web app or DASH.js reference player
   - Test: https://reference.dashif.org/dash.js/
   - Paste manifest URL: `http://origin-server/content-id/dash/manifest.mpd`

2. **Android App Testing:**
   - Download app from Play Store
   - Test playback and quality switching
   - Verify adaptive bitrate behavior

3. **Android Tablet Testing:**
   - Same as phone testing
   - Verify higher quality renditions used
   - Check landscape mode playback

### HLS Testing

**Compatible Platforms:**
- Safari browser
- iOS devices (iPhone, iPad)
- macOS (Safari, QuickTime)
- Any device with HLS support

**Testing Methods:**

1. **Safari Browser:**
   - Simply paste URL in Safari
   - Native HLS support
   - Monitor quality switching

2. **iOS App Testing:**
   - Download app from App Store
   - Test on iPhone and iPad
   - Verify different network conditions (WiFi, LTE, 5G)

3. **macOS Testing:**
   - Safari browser
   - QuickTime Player (File → Open Location)
   - Test on different Mac models

4. **VLC (All Platforms):**
   ```
   File → Open Network Stream
   Enter: http://origin-server/content-id/hls/master.m3u8
   ```

## General Troubleshooting Approach

### Systematic Methodology

When facing any issue, follow this systematic approach:

1. **Define the Problem**
   - What exactly is not working?
   - When did it start?
   - Is it affecting all viewers or specific ones?

2. **Check the Dashboard**
   - Review component statuses
   - Look for red or yellow indicators
   - Check recent changes

3. **Verify Configuration**
   - Confirm Content IDs match
   - Check all component settings
   - Verify network configurations

4. **Test Each Component**
   - Input stream
   - Transcoder
   - Packager(s)
   - Origin server

5. **Review Logs**
   - Check system logs
   - Review component-specific logs
   - Look for error messages or warnings

6. **Isolate the Issue**
   - Determine which component is failing
   - Identify if issue is consistent or intermittent
   - Check if issue is device or format-specific

7. **Apply Resolution**
   - Implement appropriate fix
   - Restart components if needed
   - Update configuration if required

8. **Verify Fix**
   - Test playback thoroughly
   - Verify across different devices
   - Monitor for recurrence

9. **Document**
   - Record what was done
   - Note what worked
   - Update procedures if needed

10. **Implement Prevention**
    - Add monitoring if applicable
    - Update procedures
    - Share learnings with team

## Escalation Procedures

### When to Escalate

Escalate issues when:
- Standard troubleshooting steps don't resolve the issue
- Multiple components are affected
- Issue has business-critical impact
- Security incident suspected
- Root cause is unclear after investigation

### How to Escalate

**Information to Provide:**

1. **Issue Description**
   - Clear description of the problem
   - When it started
   - Impact and scope

2. **Troubleshooting Performed**
   - All steps taken
   - Results of each step
   - What was tried and didn't work

3. **System Information**
   - Component statuses
   - Configuration details
   - Content IDs involved

4. **Evidence**
   - Error messages
   - Log excerpts
   - Screenshots if applicable
   - Test results

5. **Contact Information**
   - Your name and contact details
   - Best way to reach you
   - Urgency level

## Support Resources

### Internal Resources

- **Platform Dashboard**: Real-time component monitoring
- **Component Logs**: Detailed error information
- **Configuration Pages**: Verify all settings

### External Resources

- **vLive Documentation**: Partner platform documentation
- **DRM Provider Support**: For encryption issues
- **Encoder Vendor Support**: For input stream problems

### Tools and Utilities

- **ffprobe**: Stream analysis
- **ffplay**: Quick stream testing
- **VLC**: Multi-protocol testing
- **Browser DevTools**: Network debugging
- **tcpdump**: Network packet analysis

## Related Documentation

- [Input Streams](input-streams) - Input stream configuration
- [Transcoders](transcoders) - Transcoder setup and management
- [Packagers](packagers) - Packaging configuration
- [Origin Servers](origin-servers) - Origin deployment
- [Best Practices](best-practices) - Optimization guidelines
