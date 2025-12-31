---
layout: default
title: Origin Servers
nav_order: 5
---

# Origin Servers
{: .no_toc }

Origin Servers host and deliver packaged streaming content to CDNs and client devices.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Origin Servers are the final component in the streaming pipeline, responsible for hosting packaged media segments and serving them to Content Delivery Networks (CDNs) and direct client requests. Origins store the output from AES, DASH, and HLS packagers and provide HTTP access to manifests and segments.

### Key Functions

- **Storage**: Host packaged media segments and manifest files
- **Delivery**: Serve content via HTTP/HTTPS to CDNs and clients
- **Accessibility**: Provide playback URLs for viewer consumption
- **Integration**: Bridge between packagers and content distribution
- **Performance**: Enable efficient content delivery at scale

## Origin Server Architecture

### Component Integration

```
Input Stream → Transcoder → Packagers → Origin Server → CDN → Viewers
```

### Storage Structure

Origins host content in a directory structure organized by:
- Content ID
- Packaging format (AES, DASH, HLS)
- Segments and manifest files

### Deployment Considerations

- **Same Server as Packagers**: Typical deployment for simplicity
- **Dedicated Origin Servers**: For high-traffic scenarios
- **Geographic Distribution**: Multiple origins for global reach
- **CDN Integration**: Origins as source for edge servers

## Adding a New Origin

### Prerequisites

- Server with sufficient disk space for media storage
- Network connectivity to packagers
- Available network interface with internet access
- Packagers already configured and generating output

### Creation Steps

1. Navigate to **Origins** from the left sidebar
2. Click **Add Origin** button (top-right)
3. **Select Server**:
   - Typically the same server hosting packagers
   - Ensure sufficient disk space for segment storage
   - Verify network connectivity to packagers
4. **Select Server Interface**:
   - Choose primary network interface
   - Verify interface has internet connectivity
   - Confirm interface is properly configured
5. **Choose Deployment Version** (optional):
   - Select specific version if required
   - Use default version if unsure
6. **Set Media Directory**:
   - Standard path: `/opt/es/media/packager`
   - This is where packagers write output segments
   - Ensure directory exists and is writable
   - Verify sufficient disk space available
7. **Enable Origin**: Toggle Enable = ON to activate
8. Click **Save** to finalize origin creation

## Configuration Parameters

| Field | Description | Example Value |
|-------|-------------|---------------|
| Server | Hosting server | origin-server-01 |
| Server Interface | Network interface | eth0 or IP address |
| Media Directory | Segment storage path | `/opt/es/media/packager` |
| Deployment Version | Service version | v2.0 |
| Status | Enable/Disable toggle | ENABLED |

### Media Directory Configuration

**Important Points:**

- **Shared with Packagers**: Use the same directory where packagers write output
- **Writable**: Must have appropriate permissions for web server
- **Disk Space**: Monitor usage and plan for growth
- **Path Consistency**: Must match packager configuration exactly

**Typical Structure:**
```
/opt/es/media/packager/
├── content-001/
│   ├── aes/
│   ├── dash/
│   └── hls/
├── content-002/
│   ├── aes/
│   ├── dash/
│   └── hls/
└── ...
```

## Origin List Display

Once created, origins appear in the list with the following information:

| Field | Information |
|-------|-------------|
| Enabled | ENABLED / DISABLED |
| Live Status | RUNNING / STOPPED |
| Server | Hosting server name |
| Network Interface | Interface name or IP address |
| Media Directory | Storage path |
| Version | Deployment version |

## Origin Actions

Available actions for each origin:

| Action | Icon | Function |
|--------|------|----------|
| View | Eye | Display origin details |
| Disable/Enable | Toggle | Start or stop origin service |
| Edit | Pencil | Modify configuration |
| Delete | Bin | Remove origin |

## Viewing Origin Details

### Top Action Buttons

- **Disable / Enable**: Temporarily stop or start origin service
- **Edit**: Modify origin configuration
- **Back**: Return to origin list

### Information Display

| Field | Description | Example |
|-------|-------------|---------|
| Server | Server hosting the origin | origin-server-01 |
| Server Interface | Network interface in use | eth0 |
| Live Status | Runtime state | RUNNING |
| Deployment Version | Origin service version | v2.0 |
| Media Directory | Segment storage path | `/opt/es/media/packager` |
| Status | Configuration state | ENABLED / DISABLED |
| Created At | Creation timestamp | 2024-01-15 10:30:00 |
| Updated At | Last modification | 2024-01-20 14:45:00 |

### Media Directory Usage

The media directory serves multiple purposes:

- **Storage Location**: All packaged media from AES, DASH, HLS packagers
- **Organization**: Directory structure by content and stream format
- **Write Access**: Packagers write segments to this location
- **Read Access**: Origin serves content from this directory
- **Shared Resource**: Multiple packagers may write to same directory

## Editing an Origin

### Editable Fields

The edit page allows modification of:

- **Server**: Server hosting the origin
  - Typically the same server hosting packagers
  - Changing requires proper server preparation
  - Verify new server has media directory access

- **Server Interface**: Primary network interface
  - Must have connectivity to CDN and clients
  - Verify IP address configuration

- **Deployment Version**: Origin service version
  - Select specific version if needed
  - Coordinate with platform updates

- **Media Directory**: Absolute path for segment storage
  - Example: `/opt/es/media/packager`
  - Must exist and be writable by packagers
  - Requires sufficient disk space
  - Changing may require data migration

- **Enable Origin**: Activation toggle
  - Enable: Activate origin immediately
  - Disable: Keep configured but inactive

### Edit Workflow

1. Navigate to origin details page
2. Click **Edit** button
3. Review all modifications carefully
4. Click **Save** to apply changes
5. Click **Cancel** to discard without saving
6. Monitor origin status after updates

## Enabling / Disabling Origins

### Toggle Operation

The toggle action controls the origin service state without removing configuration.

**Use Cases:**
- Temporary maintenance windows
- Testing and validation
- Resource optimization
- Planned downtime

**Workflow:**
1. Navigate to Origins list
2. Click toggle (Enabled/Disabled) icon
3. Review confirmation message
4. Click **Ok** to enable/disable
5. Click **Cancel** to discard action

**Effect:**
- Disabling stops content serving immediately
- Active viewers may experience playback interruption
- Packagers continue writing to media directory
- Configuration is preserved

## Deleting an Origin

### Delete Operation

Permanently removes the origin from the platform.

**Warning:** This does not delete media files from disk. Only the origin configuration is removed.

**Before Deleting:**
- Ensure no active viewers are using the origin
- Disable the origin first
- Consider if media files should be preserved
- Update CDN configurations if needed
- Document reasons for removal

**Workflow:**
1. Navigate to Origins list
2. Click Delete (bin) icon
3. Review confirmation message
4. Click **Ok** to remove origin
5. Click **Cancel** to discard action

## Playback URLs

### URL Structure

Origins serve content through HTTP/HTTPS URLs with the following structure:

**AES Playlist:**
```
http://origin-server.example.com/content-id/aes/playlist.m3u8
```

**DASH Manifest:**
```
http://origin-server.example.com/content-id/dash/manifest.mpd
```

**HLS Master Playlist:**
```
http://origin-server.example.com/content-id/hls/master.m3u8
```

### CDN Integration

Origins typically serve as source for CDN edge servers:

```
Client → CDN Edge → CDN Origin Shield → Origin Server
```

**Benefits:**
- Reduced load on origin servers
- Lower latency for global viewers
- Improved scalability
- Better reliability

### Direct Client Access

For testing or low-traffic scenarios, clients can access origins directly:

**Advantages:**
- Simpler setup
- No CDN costs
- Direct control

**Limitations:**
- Limited scalability
- Higher origin load
- No geographic distribution
- No edge caching

## Performance and Capacity

### Disk Space Planning

**Calculation Factors:**
- Number of concurrent channels
- Segment duration (affects segment count)
- Retention/buffer window (typically 10-60 minutes)
- Multiple packaging formats (AES, DASH, HLS)
- Multiple quality renditions

**Example Calculation:**

For 1 channel with:
- 3 formats (AES, DASH, HLS)
- 4 renditions per format
- 10-minute buffer
- 6-second segments
- ~2 MB per segment average

Total: ~100 segments × 12 formats/renditions × 2 MB = ~2.4 GB per channel

**Recommendations:**
- 100 GB minimum for small deployments
- 500 GB - 1 TB for medium deployments
- 1+ TB for large deployments
- Monitor usage and expand as needed

### Network Bandwidth

**Considerations:**
- Aggregate bitrate of all streams
- Number of concurrent viewers (if serving directly)
- CDN pull bandwidth
- Peak load scenarios

**Best Practices:**
- Use CDN to reduce origin bandwidth
- Monitor bandwidth utilization
- Plan for peak events (3-5x normal load)
- Implement rate limiting if needed

### Server Resources

**Typical Requirements:**
- CPU: Minimal (serving pre-packaged content)
- Memory: 4-8 GB
- Disk I/O: Important for many concurrent requests
- Network: 1 Gbps+ for medium/large deployments

## Monitoring and Maintenance

### Health Checks

Monitor these indicators:

- **Status**: RUNNING vs STOPPED
- **Disk Space**: Available storage capacity
- **Request Rate**: HTTP requests per second
- **Response Time**: Time to serve segments
- **Error Rate**: 404s and 500s
- **Bandwidth Usage**: Outgoing traffic

### Alerts

Set up notifications for:
- Origin status changes to STOPPED
- Disk space below 15%
- High error rates (>1% 404/500 errors)
- Unusual bandwidth spikes
- Service restarts or crashes

### Regular Maintenance

**Weekly Tasks:**
- Review disk space usage trends
- Check for orphaned media files
- Verify all origins are RUNNING
- Review access logs for issues

**Monthly Tasks:**
- Analyze bandwidth usage patterns
- Clean up old or unused content
- Review and update capacity plans
- Test failover procedures

**Quarterly Tasks:**
- Review deployment versions
- Plan infrastructure upgrades
- Conduct capacity planning
- Update documentation

## Troubleshooting

### Origin Not Serving Content

**Symptoms:**
- 404 errors for playlist URLs
- Segments not accessible
- Playback fails immediately

**Debug Steps:**
1. Verify origin status is RUNNING
2. Check media directory exists and is accessible
3. Confirm packagers are writing to correct directory
4. Test direct file access on origin server:
   ```bash
   curl http://origin-server/content-id/aes/playlist.m3u8
   ```
5. Check web server configuration
6. Review origin service logs
7. Verify file permissions on media directory

### Disk Space Full

**Symptoms:**
- Origin stops responding
- Packagers cannot write new segments
- Errors in packager logs

**Resolution:**
1. Identify large or old files:
   ```bash
   du -sh /opt/es/media/packager/*
   ```
2. Remove old or unused content
3. Increase disk capacity
4. Implement automatic cleanup policies
5. Monitor disk space continuously

### High Latency

**Symptoms:**
- Slow segment loading
- Buffering during playback
- Delayed playback start

**Debug Steps:**
1. Test segment download times
2. Check origin server CPU and disk I/O
3. Verify network connectivity
4. Review web server configuration
5. Consider CDN implementation
6. Check for bandwidth throttling

### Inconsistent Content

**Symptoms:**
- Some segments accessible, others not
- Playback stutters or stops
- 404 errors intermittently

**Debug Steps:**
1. Verify packagers are running properly
2. Check disk space and I/O performance
3. Review file permissions
4. Test segment creation and deletion
5. Check for filesystem errors
6. Review packager and origin logs

## Best Practices

### Deployment

✓ Deploy origins on same servers as packagers initially
✓ Use dedicated origin servers for high-traffic scenarios
✓ Implement CDN for production deployments
✓ Configure HTTPS for secure content delivery
✓ Use consistent paths across all components

### Storage

✓ Use fast storage (SSD) for media directories
✓ Monitor disk space continuously
✓ Implement automatic cleanup of old segments
✓ Plan capacity based on content and retention needs
✓ Use RAID for reliability in production

### Network

✓ Configure appropriate bandwidth allocation
✓ Use dedicated network interfaces for high traffic
✓ Implement rate limiting to prevent abuse
✓ Monitor bandwidth usage patterns
✓ Plan for peak load scenarios

### Security

✓ Use HTTPS for all content delivery
✓ Implement access controls for admin interfaces
✓ Restrict direct origin access (use CDN)
✓ Monitor for unauthorized access attempts
✓ Keep deployment versions updated

### Operations

✓ Set up comprehensive monitoring and alerts
✓ Document all configuration changes
✓ Test failover procedures regularly
✓ Maintain backup origins for critical content
✓ Conduct regular capacity reviews

## Related Documentation

- [Input Streams]({% link docs/input-streams.md %}) - Configure source streams
- [Transcoders]({% link docs/transcoders.md %}) - Set up transcoding
- [Packagers]({% link docs/packagers.md %}) - Configure stream packaging
- [Best Practices]({% link docs/best-practices.md %}) - Optimization guidelines
- [Troubleshooting]({% link docs/troubleshooting.md %}) - Resolve common issues
