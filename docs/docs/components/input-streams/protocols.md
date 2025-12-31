---
layout: default
title: Protocol Support
parent: Input Streams
grand_parent: Platform Components
nav_order: 2
---

# Protocol Support
{: .no_toc }

Understanding UDP and RTMP protocols for video ingestion.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Supported Protocols

{{ site.product_name }} supports two primary protocols for ingesting live video streams:

- **UDP Multicast**: Traditional broadcast workflow protocol
- **RTMP**: Internet-based streaming protocol

---

## UDP Multicast

### Overview

UDP (User Datagram Protocol) multicast is widely used in professional broadcast environments for transporting MPEG-TS streams over IP networks.

### URL Format

```
udp://@[multicast-address]:[port]
```

### Examples

```
udp://@239.1.1.1:5000
udp://@239.255.0.1:1234
udp://@225.100.100.100:5004
```

### Characteristics

| Feature | Description |
|---------|-------------|
| **Protocol** | UDP (connectionless) |
| **Format** | MPEG-TS (Transport Stream) |
| **Latency** | Very low (< 1 second) |
| **Reliability** | No retransmission |
| **Use Case** | Professional broadcast, studio environments |
| **Network** | Requires multicast routing |

### Network Requirements

**Multicast Routing:**
- Network switches must support IGMP (Internet Group Management Protocol)
- Routers must be configured for multicast forwarding
- VLANs may require multicast configuration

**Bandwidth:**
- Dedicated network bandwidth for video traffic
- Typical: 5-15 Mbps per HD stream
- Higher for 4K content (25-50 Mbps)

**Quality of Service (QoS):**
- Prioritize video traffic
- Minimize packet loss
- Reduce jitter and latency

### Configuration Steps

**1. Verify Network Support**

Check if multicast is enabled:

```bash
# On Linux server
ip route show | grep multicast
```

**2. Test Multicast Reception**

Use `ffprobe` to verify stream:

```bash
ffprobe -v error -show_streams udp://@239.1.1.1:5000
```

**3. Monitor Multicast Traffic**

```bash
tcpdump -i eth0 host 239.1.1.1 and port 5000
```

### Advantages

✅ **Low Latency**: Minimal delay from encoder to platform
✅ **High Quality**: No compression artifacts from protocol
✅ **Network Efficient**: One stream serves multiple receivers
✅ **Professional Standard**: Industry standard in broadcast

### Limitations

❌ **Network Dependent**: Requires proper multicast configuration
❌ **No Error Correction**: Lost packets cannot be recovered
❌ **Limited to LAN**: Typically not routed over internet
❌ **Complex Troubleshooting**: Requires network expertise

### Troubleshooting UDP

**Issue: Stream not received**

Check these items:

1. **Multicast routing enabled**
   ```bash
   ip route show | grep multicast
   ```

2. **Firewall allows UDP**
   ```bash
   sudo iptables -L -n | grep udp
   ```

3. **Encoder is transmitting**
   - Check encoder status
   - Verify output configuration
   - Monitor encoder network interface

4. **Correct network interface**
   - Verify interface receives multicast
   - Check IGMP membership
   - Monitor interface statistics

---

## RTMP Streaming

### Overview

RTMP (Real-Time Messaging Protocol) is a TCP-based protocol widely used for internet streaming, particularly with OBS, Wirecast, and cloud encoders.

### URL Format

```
rtmp://[server]:[port]/[application]/[stream-key]
```

### Examples

```
rtmp://encoder.example.com:1935/live/stream-key-123
rtmp://10.0.1.100:1935/live/channel01
rtmp://rtmp.streaming.com:1935/app/secret_key_xyz
```

### Characteristics

| Feature | Description |
|---------|-------------|
| **Protocol** | TCP (connection-oriented) |
| **Format** | FLV container (H.264 + AAC) |
| **Latency** | Low (2-5 seconds) |
| **Reliability** | Automatic retransmission |
| **Use Case** | OBS, cloud encoders, remote feeds |
| **Network** | Works over internet |

### Port Configuration

**Default Port:** 1935

**Firewall Rules:**
```bash
# Allow RTMP traffic
sudo iptables -A INPUT -p tcp --dport 1935 -j ACCEPT
```

### Authentication

**Stream Keys:**
- Use strong, random stream keys
- Rotate keys periodically
- Keep keys confidential
- Monitor for unauthorized use

**Example Stream Key Format:**
```
live_event_2024_secure_a1b2c3d4e5f6
```

### Configuration Steps

**1. Test RTMP Connection**

Use `ffprobe`:

```bash
ffprobe -v error rtmp://encoder.example.com:1935/live/stream-key
```

**2. Monitor RTMP Stream**

Use `ffplay` for testing:

```bash
ffplay rtmp://encoder.example.com:1935/live/stream-key
```

**3. Check RTMP Server Logs**

Review server logs for connection attempts and errors.

### Advantages

✅ **Internet Friendly**: Works over standard networks
✅ **Reliable**: TCP ensures packet delivery
✅ **Widely Supported**: OBS, Wirecast, vMix, etc.
✅ **Firewall Friendly**: Uses standard ports

### Limitations

❌ **Higher Latency**: TCP overhead adds delay
❌ **Bandwidth Overhead**: Protocol metadata
❌ **Single Receiver**: One-to-one connection
❌ **Internet Dependent**: Requires stable internet

### Troubleshooting RTMP

**Issue: Cannot connect to RTMP server**

1. **Verify server is reachable**
   ```bash
   telnet encoder.example.com 1935
   ```

2. **Check stream key**
   - Verify stream key is correct
   - Check for typos
   - Ensure no spaces or special characters

3. **Firewall configuration**
   - Port 1935 must be open
   - Check both server and encoder firewalls
   - Verify NAT configuration if applicable

4. **Encoder settings**
   - Verify RTMP URL is correct
   - Check encoder output format (H.264 + AAC)
   - Ensure encoder is streaming

---

## Protocol Comparison

### When to Use UDP

Choose UDP multicast when:

- ✅ Operating in a controlled LAN environment
- ✅ Using professional broadcast equipment
- ✅ Lowest possible latency is critical
- ✅ Network supports multicast routing
- ✅ High-quality, uncompressed feed required

### When to Use RTMP

Choose RTMP when:

- ✅ Encoder is remote or internet-based
- ✅ Using OBS, Wirecast, or similar software
- ✅ Network multicast is not available
- ✅ Need simple, reliable connection
- ✅ Working with content creators

---

## Protocol Specifications

### UDP Multicast

**Technical Specifications:**

| Parameter | Value |
|-----------|-------|
| Transport | UDP |
| Container | MPEG-TS |
| Video Codec | H.264, HEVC |
| Audio Codec | AAC, MPEG Audio |
| Multicast Range | 224.0.0.0 to 239.255.255.255 |
| Typical Bitrate | 5-50 Mbps |

### RTMP

**Technical Specifications:**

| Parameter | Value |
|-----------|-------|
| Transport | TCP |
| Container | FLV |
| Video Codec | H.264 |
| Audio Codec | AAC, MP3 |
| Default Port | 1935 |
| Typical Bitrate | 2-10 Mbps |

---

## Network Configuration

### Bandwidth Requirements

**UDP Multicast:**
- Dedicated VLAN recommended
- QoS priority for video traffic
- No bandwidth multiplication (efficient)

**RTMP:**
- Requires upload bandwidth at encoder
- Download bandwidth at platform
- Each stream needs full bandwidth

### Firewall Configuration

**UDP Multicast:**
```bash
# Allow multicast traffic
sudo iptables -A INPUT -p udp -d 224.0.0.0/4 -j ACCEPT
```

**RTMP:**
```bash
# Allow RTMP port
sudo iptables -A INPUT -p tcp --dport 1935 -j ACCEPT
```

---

## Best Practices

### For UDP Multicast

1. **Use dedicated network** for video traffic
2. **Configure QoS** to prioritize video
3. **Test multicast routing** before deployment
4. **Monitor packet loss** continuously
5. **Document multicast groups** used

### For RTMP

1. **Use strong stream keys** for security
2. **Monitor connection stability**
3. **Implement reconnection logic** in encoders
4. **Test with representative content** before production
5. **Keep backup RTMP servers** for redundancy

---

## Diagnostic Commands

### UDP Testing

**Check stream availability:**
```bash
ffprobe -v error -show_streams udp://@239.1.1.1:5000
```

**Monitor packets:**
```bash
tcpdump -i eth0 host 239.1.1.1
```

**Test playback:**
```bash
ffplay udp://@239.1.1.1:5000
```

### RTMP Testing

**Check stream availability:**
```bash
ffprobe rtmp://server:1935/live/stream-key
```

**Test playback:**
```bash
ffplay rtmp://server:1935/live/stream-key
```

**Monitor connection:**
```bash
netstat -an | grep 1935
```

---

## Related Documentation

- [Configuration Guide](../configuration/) - Set up input streams
- [Testing Guide](../testing/) - Verify stream functionality
- [Best Practices](../best-practices/) - Optimization tips
- [Troubleshooting](../../../reference/troubleshooting/) - Common issues
