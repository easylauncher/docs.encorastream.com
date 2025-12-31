---
layout: default
title: Input Streams
parent: Platform Components
nav_order: 1
has_children: true
---

# 📥 Input Streams
{: .no_toc }

Input Streams are the foundation of your streaming workflow, representing live video sources from encoders.
{: .fs-6 .fw-300 }

---

## Overview

Input Streams represent live video sources ingested from hardware or software encoders. The platform supports both UDP multicast and RTMP protocols for video ingestion. Each input stream is uniquely identified by a Content ID that must match across the entire streaming pipeline.

### Key Concepts

- **Content ID**: Unique identifier for the stream (case-sensitive)
- **Source URL**: Location of the input stream (UDP or RTMP)
- **Protocol Support**: UDP multicast and RTMP
- **Encoder Integration**: Compatible with standard broadcast encoders

{: .important }
The **Content ID** is case-sensitive and must match exactly across all components (transcoders, packagers, etc.).

---

## In This Section

- [Configuration Guide](configuration/) - How to add and configure input streams
- [Protocol Support](protocols/) - UDP and RTMP protocol details
- [Testing & Validation](testing/) - Verify your input streams work correctly
- [Best Practices](best-practices/) - Optimization and naming conventions

---

## Quick Start

### Adding Your First Input Stream

1. Navigate to **Input Streams** from the left sidebar
2. Click **Add Input Stream** button
3. Fill in the required fields:
   - **Name**: Descriptive channel name
   - **Content ID**: Unique identifier (case-sensitive)
   - **Source URL**: Complete encoder URL
4. Click **Save**

[View detailed configuration guide →](configuration/)

---

## Common Use Cases

### Live TV Broadcast
```
Name: "News Channel HD"
Content ID: "news_hd_01"
Source URL: udp://@239.1.1.1:5000
```

### Event Streaming
```
Name: "Concert Event Main"
Content ID: "concert_2024_main"
Source URL: rtmp://encoder.example.com:1935/live/event01
```

### Multi-Camera Production
```
Name: "Sports Camera 1"
Content ID: "sports_cam1_hd"
Source URL: udp://@239.1.1.10:5000
```

---

## Protocol Support

The platform supports two primary ingestion protocols:

### UDP Multicast
- Format: `udp://@[multicast-address]:[port]`
- Best for: Traditional broadcast workflows
- Requires: Network multicast routing
- [Learn more about UDP →](protocols/#udp-multicast)

### RTMP
- Format: `rtmp://[server]:[port]/[app]/[stream-key]`
- Best for: Internet-based encoders, OBS, Wirecast
- Requires: RTMP server configuration
- [Learn more about RTMP →](protocols/#rtmp-streaming)

---

## Configuration Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| Name | ✅ | Human-readable channel name | "Sports Channel HD" |
| Content ID | ✅ | Unique stream identifier | "sports_hd_01" |
| Source URL | ✅ | Encoder stream location | `udp://@239.1.1.1:5000` |
| Server | ✅ | Server receiving the input | server-01 |
| Status | ✅ | Enable/Disable toggle | ENABLED |

---

## Workflow Integration

Input streams connect to the rest of your streaming pipeline:

```
📥 Input Stream → ⚙️ Transcoder → 📦 Packager → 🌐 Origin → 👥 Viewers
```

### Next Steps After Configuration

1. **Create a Transcoder** - [Transcoders Documentation](../transcoders/)
2. **Set up Packagers** - [Packagers Documentation](../packagers/)
3. **Deploy Origin** - [Origin Servers Documentation](../origin-servers/)

---

## Related Documentation

- [Configuration Guide](configuration/) - Detailed setup instructions
- [Testing Guide](testing/) - Verification methods
- [Best Practices](best-practices/) - Optimization tips
- [Troubleshooting](../../reference/troubleshooting/#input-stream-not-working) - Common issues
