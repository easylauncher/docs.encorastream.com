---
layout: default
title: Best Practices
parent: Input Streams
grand_parent: Platform Components
nav_order: 4
---

# Input Streams Best Practices
{: .no_toc }

Optimization guidelines and recommendations for input stream configuration.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Naming Conventions

### Channel Names

Use descriptive, identifiable names that clearly indicate the content:

**✅ Good Examples:**
```
"News Channel HD"
"Sports Primary 4K"
"Entertainment Main"
"Event Camera 1"
"Concert Main Feed"
```

**❌ Bad Examples:**
```
"Stream 1"
"Test"
"Channel"
"Input"
"temp"
```

### Content ID Guidelines

Content IDs are critical—they must be unique and consistent:

**✅ Best Practices:**
- Use lowercase for consistency
- Use underscores instead of spaces
- Include environment indicator: `prod_`, `stage_`, `test_`
- Include purpose and quality: `news_hd`, `sports_4k`
- Keep length reasonable (< 32 characters)

**Examples:**
```
prod_news_hd_01
stage_sports_main_4k
test_event_backup_hd
```

**❌ Avoid:**
- Mixed case: `News_HD_01` vs `news_hd_01`
- Spaces: `news hd 01`
- Special characters: `news$hd#01`
- Too generic: `stream1`, `test`
- Too long: `production_news_high_definition_primary_backup_stream_01`

{: .important }
Content ID cannot be changed after creation. Choose carefully!

---

## Network Configuration

### UDP Multicast

**Best Practices:**

1. **Dedicated VLAN**
   - Use separate VLAN for video traffic
   - Isolate multicast traffic from other network traffic
   - Configure VLAN tagging correctly

2. **Quality of Service (QoS)**
   - Prioritize video traffic (DSCP marking)
   - Ensure consistent bandwidth allocation
   - Monitor for packet loss

3. **Multicast Address Management**
   - Use consistent address ranges
   - Document all multicast groups used
   - Avoid conflicts with other multicast applications
   - Typical range: 239.1.0.0 to 239.255.255.255

4. **Switch Configuration**
   - Enable IGMP snooping
   - Configure multicast forwarding
   - Set appropriate IGMP query intervals

### RTMP

**Best Practices:**

1. **Stream Key Security**
   - Generate strong, random keys
   - Rotate keys periodically
   - Keep keys confidential
   - Monitor for unauthorized use

2. **Network Reliability**
   - Use wired connections over Wi-Fi
   - Ensure stable internet connection
   - Monitor upload bandwidth availability
   - Test during peak hours

3. **Firewall Configuration**
   - Open port 1935 for RTMP
   - Use IP whitelisting when possible
   - Log connection attempts
   - Monitor for suspicious activity

---

## Redundancy and Failover

### Primary and Backup Streams

Always configure backup streams for critical content:

**Primary Stream:**
```
Name: "News Primary HD"
Content ID: "news_primary_hd"
Source URL: udp://@239.1.1.1:5000
```

**Backup Stream:**
```
Name: "News Backup HD"
Content ID: "news_backup_hd"
Source URL: udp://@239.1.1.2:5000
```

### Automatic Failover

Implement monitoring to detect failures and switch to backup:

- Monitor primary stream health
- Define failure criteria (e.g., 3 consecutive failures)
- Automate switch to backup stream
- Alert operations team
- Document failover procedures

---

## Encoder Configuration

### Recommended Encoder Settings

**Video Settings:**
- **Codec**: H.264 (AVC)
- **Profile**: High or Main
- **Level**: 4.0 or higher
- **Bitrate**: 
  - SD (480p): 2-3 Mbps
  - HD (720p): 4-6 Mbps
  - Full HD (1080p): 8-12 Mbps
  - 4K (2160p): 25-50 Mbps
- **Keyframe Interval**: 2 seconds (60 frames @ 30fps)
- **B-frames**: 2-3

**Audio Settings:**
- **Codec**: AAC-LC
- **Sample Rate**: 48000 Hz
- **Bitrate**: 128-256 kbps
- **Channels**: Stereo (2.0) or as needed

**Transport Settings:**
- **CBR** (Constant Bitrate) preferred over VBR
- **GOP** (Group of Pictures): Closed GOP
- **PTS/DTS**: Ensure proper timestamping

---

## Documentation

### What to Document

Maintain comprehensive documentation for each input stream:

**Essential Information:**
- Channel name and purpose
- Content ID
- Source URL (protocol, IP, port)
- Encoder make and model
- Encoder IP address
- Contact information for encoder operator
- Network diagram showing connectivity
- Multicast group assignments (for UDP)

**Operational Information:**
- Scheduled streaming hours
- Maintenance windows
- Backup stream configuration
- Failover procedures
- Historical issues and resolutions

### Documentation Template

```markdown
# Input Stream: News Channel HD

**Content ID**: prod_news_hd_01
**Source URL**: udp://@239.1.1.1:5000
**Status**: Production

## Encoder Details
- **Make/Model**: Encoder Model XYZ
- **IP Address**: 10.0.1.50
- **Output Format**: 1080p @ 29.97 fps, 10 Mbps
- **Location**: Studio A, Building 1

## Network
- **VLAN**: 100 (Video Production)
- **Multicast Group**: 239.1.1.1:5000
- **Switch Port**: Gi1/0/10

## Contacts
- **Primary**: John Doe (john@example.com)
- **Backup**: Jane Smith (jane@example.com)
- **On-Call**: +1-555-0123

## Backup Configuration
- **Backup URL**: udp://@239.1.1.2:5000
- **Backup Encoder**: 10.0.1.51

## Notes
- Production stream for evening news broadcast
- Scheduled: 6:00 PM - 11:00 PM daily
- Maintenance: Sunday 2:00 AM - 4:00 AM
```

---

## Monitoring and Alerting

### Key Metrics to Monitor

**Stream Health:**
- Stream availability (up/down)
- Bitrate consistency
- Packet loss rate
- Frame rate stability

**Network Health:**
- Network bandwidth utilization
- Packet loss percentage
- Latency measurements
- Interface errors

**Server Resources:**
- CPU utilization
- Memory usage
- Network interface throughput
- Disk I/O (if recording)

### Alert Thresholds

Set up alerts for:

| Metric | Threshold | Action |
|--------|-----------|--------|
| Stream Down | 3 consecutive failures | Critical alert |
| Packet Loss | > 0.1% | Warning |
| Bitrate Drop | > 20% from baseline | Warning |
| High CPU | > 80% for 5 minutes | Warning |

---

## Testing and Validation

### Pre-Production Testing

Before deploying to production:

1. **Connectivity Testing**
   - Verify network path from encoder to server
   - Test with `ffprobe` and VLC
   - Confirm multicast routing (for UDP)
   - Validate RTMP connectivity

2. **Quality Testing**
   - Verify video resolution and frame rate
   - Check audio synchronization
   - Test under various network conditions
   - Verify bitrate stability

3. **Load Testing**
   - Test with realistic encoder settings
   - Simulate network issues
   - Verify recovery from interruptions
   - Test failover to backup

### Ongoing Validation

**Daily:**
- Visual check of stream quality
- Review monitoring dashboard
- Check for alerts or warnings

**Weekly:**
- Review historical performance data
- Test backup stream functionality
- Verify documentation is current
- Update contact information

**Monthly:**
- Full end-to-end testing
- Failover procedure testing
- Review and update documentation
- Analyze trends and patterns

---

## Security Best Practices

### Access Control

- Restrict dashboard access to authorized personnel
- Use strong passwords
- Enable two-factor authentication if available
- Audit access logs regularly

### Network Security

**UDP Multicast:**
- Use dedicated VLANs
- Implement ACLs to restrict access
- Monitor for unauthorized multicast sources
- Use network segmentation

**RTMP:**
- Use strong, unique stream keys
- Rotate stream keys periodically
- Implement IP whitelisting
- Use RTMPS (RTMP over TLS) when possible
- Monitor for brute-force attempts

### Content Protection

- Use HTTPS for management interfaces
- Encrypt sensitive configuration data
- Implement DRM for downstream content
- Regular security audits

---

## Resource Planning

### Bandwidth Requirements

Calculate required bandwidth:

**Formula:**
```
Total Bandwidth = Number of Streams × Stream Bitrate × Overhead Factor
Overhead Factor = 1.2 (20% overhead)
```

**Example:**
```
5 streams × 10 Mbps × 1.2 = 60 Mbps
```

### Server Resources

**Per Input Stream:**
- CPU: Minimal (< 5%)
- Memory: ~100 MB per stream
- Network: Bandwidth as calculated above
- Storage: None (unless recording)

### Scaling Guidelines

**Single Server Capacity:**
- Small deployment: 10-20 input streams
- Medium deployment: 20-50 input streams
- Large deployment: 50+ streams (consider multiple servers)

---

## Troubleshooting Tips

### Quick Diagnostics

**Problem**: Stream not working

**Quick Checks:**
1. Is encoder transmitting? (Check encoder display)
2. Is network connected? (`ping` encoder IP)
3. Is stream accessible? (`ffprobe` source URL)
4. Is firewall allowing traffic? (Check firewall rules)
5. Is Content ID correct? (Case-sensitive check)

### Common Issues

| Issue | Quick Fix |
|-------|-----------|
| Stream not found | Verify Source URL is correct |
| Content ID mismatch | Check case-sensitivity |
| No video | Check encoder output settings |
| No audio | Verify encoder audio configuration |
| Intermittent drops | Check network stability |

---

## Related Documentation

- [Configuration Guide](../configuration/) - Detailed setup instructions
- [Protocol Support](../protocols/) - UDP and RTMP details
- [Testing Guide](../testing/) - Verification methods
- [Troubleshooting](../../../reference/troubleshooting/) - Common issues
