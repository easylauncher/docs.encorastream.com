---
layout: default
title: Transcoders
parent: Platform Components
nav_order: 2
has_children: false
---

# ⚙️ Transcoders
{: .no_toc }

Transcoders transform input streams into multiple quality renditions for adaptive bitrate streaming.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Transcoders process input streams and generate multiple video renditions at different resolutions and bitrates. This enables Adaptive Bitrate (ABR) streaming, where viewers automatically receive the best quality based on their available bandwidth.

### Key Features

- **ABR Profile Support**: Predefined quality profiles for different use cases
- **Multiple Renditions**: Generate various quality levels simultaneously
- **Efficient Processing**: Optimized transcoding performance
- **Server Distribution**: Balance load across multiple servers
- **Real-time Processing**: Low-latency transcoding for live streams

## ABR Profiles

ABR (Adaptive Bitrate) Profiles define the video quality settings for transcoding. The platform provides several predefined profiles optimized for different scenarios.

### Available Profiles

- **Low ABR**: For bandwidth-constrained viewers
- **Medium ABR**: Balanced quality and bandwidth
- **High ABR**: Premium quality for high-speed connections
- **Custom ABR**: Define your own rendition settings

### Profile Characteristics

Each profile includes multiple renditions with specifications for:
- Video resolution
- Video bitrate
- Audio bitrate
- Frame rate
- Codec settings

## Adding a New Transcoder

### Prerequisites

- Input stream must be configured and active
- Server with sufficient CPU and memory resources
- ABR profile selected based on audience requirements

### Creation Steps

1. Navigate to **Transcoders** from the left sidebar
2. Click **Add Transcoder** button (top-right)
3. **Select Input Stream**:
   - Choose from available input streams
   - Verify Content ID matches your configuration
4. **Select ABR Profile**:
   - Choose profile based on target audience
   - Consider bandwidth availability
5. **Select Server**:
   - Choose server with available resources
   - Consider geographic location for latency
6. **Configure Renditions**:
   - Enable/disable specific quality levels
   - Customize bitrates if needed
7. **Enable Transcoder**: Toggle Enable = ON
8. Click **Save** to create the transcoder

## Transcoder Configuration

### Basic Settings

| Field | Description | Example |
|-------|-------------|---------|
| Input Stream | Source video stream | sports_hd_01 |
| ABR Profile | Quality profile | High ABR |
| Server | Processing server | transcoder-01 |
| Status | Enable/Disable toggle | ENABLED |

### Rendition Settings

Each rendition includes:

| Parameter | Description | Example Values |
|-----------|-------------|----------------|
| Resolution | Video dimensions | 1920x1080, 1280x720, 854x480 |
| Video Bitrate | Video quality | 4500 Kbps, 2800 Kbps, 1400 Kbps |
| Audio Bitrate | Audio quality | 128 Kbps, 96 Kbps |
| Frame Rate | Frames per second | 30 fps, 25 fps |
| Codec | Video encoding | H.264, H.265 |

### Typical Rendition Ladder

**High Quality Streaming:**
- 1080p @ 4500 Kbps
- 720p @ 2800 Kbps
- 480p @ 1400 Kbps
- 360p @ 800 Kbps

**Medium Quality Streaming:**
- 720p @ 2500 Kbps
- 480p @ 1200 Kbps
- 360p @ 700 Kbps
- 240p @ 400 Kbps

## Viewing Transcoder Details

### Information Display

The transcoder details page shows:

**Basic Information:**
- Input Stream reference
- Content ID
- ABR Profile name
- Server assignment
- Live Status (RUNNING / STOPPED)
- Enabled Status

**Rendition Details:**
- List of configured renditions
- Enable/Disable status for each
- Resolution and bitrate information

**Timestamps:**
- Created At
- Updated At

### Action Buttons

- **Disable / Enable**: Control transcoder operation
- **Edit**: Modify configuration
- **Delete**: Remove transcoder
- **Back**: Return to list view

## Managing Transcoders

### Editing a Transcoder

**Workflow:**
1. Navigate to transcoder details
2. Click **Edit** button
3. Modify settings:
   - Change server assignment
   - Enable/disable renditions
   - Update ABR profile
4. Click **Save** to apply or **Cancel** to discard

**Note:** Cannot change input stream after creation. Delete and recreate if needed.

### Enabling / Disabling

**Toggle Operation:**
1. Go to Transcoders list
2. Click toggle icon or use button in details view
3. Confirm the action
4. Monitor status change

**Use Cases:**
- Temporary maintenance windows
- Resource optimization during low demand
- Testing and troubleshooting

### Deleting a Transcoder

**Warning:** Ensure dependent packagers are removed first.

**Workflow:**
1. Navigate to Transcoders list
2. Click Delete (bin) icon
3. Confirm deletion
4. Verify removal from list

**Before Deleting:**
- Stop all dependent packagers
- Disable the transcoder
- Verify no active viewers

## Server Resource Planning

### CPU Requirements

Transcoding is CPU-intensive. Plan resources based on:

- Number of input streams
- Number of renditions per stream
- Input resolution and bitrate
- Target output quality

**Rule of Thumb:**
- 1080p input → 1-2 CPU cores per rendition
- Multiple streams require dedicated servers
- Monitor CPU usage and scale accordingly

### Memory Requirements

**Typical Memory Usage:**
- Base system: 2-4 GB
- Per transcoder instance: 1-2 GB
- Additional buffer for peak loads

**Recommendations:**
- Minimum 8 GB for single transcoder
- 16 GB+ for multiple transcoders
- Monitor swap usage (should be minimal)

### Network Bandwidth

**Calculation:**
- Input stream bitrate × safety factor (1.5x)
- Output bitrate sum × concurrent viewers
- Add overhead for monitoring and management

## Performance Optimization

### Best Practices

**Profile Selection:**
- Use appropriate ABR profile for your audience
- Don't over-provision quality for bandwidth-limited viewers
- Test playback on target devices

**Rendition Configuration:**
- Disable unused renditions to save resources
- Match renditions to viewer demographics
- Consider mobile-first strategies for broad audiences

**Server Distribution:**
- Distribute load across multiple servers
- Use dedicated servers for high-profile content
- Monitor resource utilization continuously

**Quality vs. Performance:**
- Balance quality settings with available CPU
- Use hardware acceleration where available
- Consider GPU-accelerated transcoding for scale

## Monitoring Transcoder Health

### Status Indicators

**Live Status:**
- **RUNNING**: Actively transcoding
- **STOPPED**: Not processing
- **ERROR**: Requires attention

**Health Checks:**
- Verify output renditions are generated
- Monitor CPU and memory usage
- Check for dropped frames or errors

### Performance Metrics

Monitor these key indicators:

- **CPU Usage**: Should be stable, not maxing out
- **Memory Usage**: No memory leaks or swapping
- **Processing Latency**: Time from input to output
- **Frame Rate**: Consistent with input stream
- **Bitrate Stability**: Output matches configuration

## Troubleshooting

### Common Issues

**Issue: Transcoder shows STOPPED status**
- Check if input stream is active
- Verify server resources are available
- Review transcoder logs for errors
- Try disabling and re-enabling

**Issue: Missing renditions**
- Verify renditions are enabled in configuration
- Check CPU resources on transcoder server
- Confirm server has network connectivity
- Review error logs for processing failures

**Issue: High CPU usage**
- Reduce number of active renditions
- Lower output resolution or bitrate
- Distribute load across more servers
- Consider hardware acceleration

**Issue: Output quality problems**
- Verify input stream quality is sufficient
- Check for network packet loss
- Review encoding settings in ABR profile
- Test with different rendition configurations

### Diagnostic Steps

1. **Check Input Stream**: Verify source is healthy
2. **Review Server Resources**: CPU, memory, disk I/O
3. **Examine Logs**: Look for error messages
4. **Test Output**: Verify renditions are playable
5. **Monitor Performance**: Track metrics over time
6. **Restart If Needed**: Disable/enable to reset state

### Resolution Commands

**Check transcoder process:**
```bash
ps aux | grep transcoder
top -p <transcoder-pid>
```

**Monitor CPU usage:**
```bash
mpstat 1
```

**Check output files:**
```bash
ls -lh /opt/es/media/transcoder/
```

## Best Practices Summary

### Configuration

✓ Select appropriate ABR profiles for your audience
✓ Enable only necessary renditions
✓ Use consistent naming conventions
✓ Document server assignments
✓ Test configurations in staging first

### Operations

✓ Monitor transcoder health continuously
✓ Plan capacity based on concurrent streams
✓ Schedule maintenance during low-traffic periods
✓ Maintain backup transcoders for critical content
✓ Keep deployment versions consistent

### Performance

✓ Balance quality with available resources
✓ Distribute load across multiple servers
✓ Monitor and optimize CPU usage
✓ Use hardware acceleration where possible
✓ Profile performance under peak loads

## Related Documentation

- [Input Streams](../input-streams/) - Configure source streams
- [Packagers](../packagers/) - Package transcoded output
- [Best Practices](../../guides/best-practices/) - Optimization guidelines
- [Troubleshooting](../../reference/troubleshooting/) - Resolve issues
