---
layout: default
title: Input Streams
nav_order: 2
---

# Input Streams
{: .no_toc }

Input Streams are the foundation of your streaming workflow, representing live video sources from encoders.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Input Streams represent live video sources ingested from hardware or software encoders. The platform supports both UDP multicast and RTMP protocols for video ingestion. Each input stream is uniquely identified by a Content ID that must match across the entire streaming pipeline.

### Key Concepts

- **Content ID**: Unique identifier for the stream (case-sensitive)
- **Source URL**: Location of the input stream (UDP or RTMP)
- **Protocol Support**: UDP multicast and RTMP
- **Encoder Integration**: Compatible with standard broadcast encoders

## Adding a New Input Stream

### Steps to Create

1. Navigate to **Input Streams** from the left sidebar
2. Click **Add Input Stream** button (top-right)
3. Fill in the required fields:
   - **Name**: Descriptive channel name for easy identification
   - **Content ID**: Unique identifier (case-sensitive, must match CMS)
   - **Source URL**: Complete encoder URL with protocol
4. Click **Save** to create the input stream

### Source URL Formats

**UDP Multicast:**
```
udp://@239.1.1.1:5000
```

**RTMP:**
```
rtmp://encoder-server.example.com:1935/live/stream-key
```

## Input Stream Configuration

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| Name | Human-readable channel name | "Sports Channel HD" |
| Content ID | Unique stream identifier (case-sensitive) | "sports_hd_01" |
| Source URL | Encoder stream location | `udp://@239.1.1.1:5000` |
| Server | Server receiving the input | server-01 |
| Status | Enable/Disable toggle | ENABLED |

### Important Notes

- **Content ID** is case-sensitive and must match exactly across all components
- **Source URL** must be accessible from the server running the transcoder
- Verify encoder output format compatibility before configuration
- Test connectivity to source URL before deployment

## Viewing Input Stream Details

### Information Display

The input stream details page shows:

- **Name**: Channel identifier
- **Content ID**: Unique stream ID
- **Source URL**: Encoder location
- **Server**: Assigned server
- **Status**: ENABLED / DISABLED
- **Created At**: Creation timestamp
- **Updated At**: Last modification timestamp

### Action Buttons

- **Disable / Enable**: Toggle stream processing
- **Edit**: Modify configuration
- **Delete**: Remove input stream
- **Back**: Return to list view

## Editing an Input Stream

### Modifiable Fields

You can update the following:

- Name
- Source URL
- Status (Enable/Disable)

**Note:** Content ID cannot be changed after creation. If you need a different Content ID, delete and recreate the input stream.

### Edit Workflow

1. Navigate to the input stream details page
2. Click **Edit** button
3. Modify the desired fields
4. Click **Save** to apply changes
5. Click **Cancel** to discard changes

## Enabling / Disabling Input Streams

### Toggle Operation

Use the Enable/Disable toggle to control stream processing without deleting the configuration.

**Workflow:**
1. Navigate to Input Streams list
2. Click the toggle icon next to the stream
3. Confirm the action in the dialog
4. Click **Ok** to proceed or **Cancel** to abort

**Use Cases:**
- Temporarily stop processing during maintenance
- Pause inactive channels without losing configuration
- Quick enable/disable for scheduled content

## Deleting an Input Stream

### Delete Operation

Permanently removes the input stream configuration.

**Warning:** This action cannot be undone. Associated transcoders and packagers must be removed first.

**Workflow:**
1. Navigate to Input Streams list
2. Click the **Delete** (bin) icon
3. Review the confirmation message
4. Click **Ok** to remove or **Cancel** to abort

### Before Deleting

Ensure the following:
- No active transcoders are using this input
- No packagers depend on this stream
- Stream is disabled to prevent disruption

## Testing Input Streams

### Verification Methods

**Using ffprobe:**
```bash
ffprobe -v error -show_format -show_streams udp://@239.1.1.1:5000
```

**Using VLC Player:**
1. Open VLC
2. Media → Open Network Stream
3. Enter the Source URL
4. Click Play

### Expected Output

A properly configured input stream should display:
- Video codec information
- Audio codec information
- Bitrate and resolution details
- Stable playback without errors

## Best Practices

### Configuration Guidelines

- Use **descriptive names** that identify the content clearly
- Maintain **unique Content IDs** across all channels
- **Verify source URLs** before saving configuration
- **Test connectivity** in staging before production
- **Document** all critical source information
- **Monitor** input stream health continuously

### Naming Conventions

Good examples:
- `news_channel_hd`
- `sports_primary_4k`
- `entertainment_backup`

Avoid:
- Generic names like `stream1`, `test`
- Special characters that may cause issues
- Spaces (use underscores instead)

### Network Considerations

- Ensure **network routing** for UDP multicast streams
- Verify **firewall rules** allow traffic from encoder
- Check **bandwidth availability** for stream bitrate
- Configure **VLAN tagging** if required
- Test **latency** between encoder and server

## Troubleshooting

### Common Issues

**Issue: Input stream not connecting**
- Verify Source URL is correct and accessible
- Check network connectivity and firewall rules
- Confirm encoder is sending the stream
- Test with ffprobe or VLC from the server

**Issue: Content ID mismatch**
- Content IDs are case-sensitive - verify exact match
- Check for trailing spaces or special characters
- Ensure CMS configuration matches platform setting

**Issue: Stream quality problems**
- Verify encoder output settings
- Check network bandwidth and packet loss
- Test input stream stability with monitoring tools
- Review encoder logs for errors

### Diagnostic Commands

**Check stream info:**
```bash
ffprobe -v error -show_streams udp://@239.1.1.1:5000
```

**Monitor stream packets:**
```bash
tcpdump -i eth0 host 239.1.1.1 and port 5000
```

**Test stream playback:**
```bash
ffplay udp://@239.1.1.1:5000
```

## Related Documentation

- [Transcoders]({% link docs/transcoders.md %}) - Configure transcoding for input streams
- [Packagers]({% link docs/packagers.md %}) - Package transcoded content
- [Troubleshooting]({% link docs/troubleshooting.md %}) - Resolve common issues
