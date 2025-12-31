---
layout: default
title: Home
nav_order: 1
description: "Encora Stream - Live Streaming Platform Documentation"
permalink: /
---

# Encora Stream Documentation
{: .fs-9 }

Welcome to the Encora Stream platform documentation. Encora Stream is a comprehensive live streaming solution powered by vLive technology.
{: .fs-6 .fw-300 }

[Get Started](#getting-started){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View on GitHub](https://github.com/easylauncher/docs.encorastream.com){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## Overview

Encora Stream is a white-labeled live streaming platform that enables you to deliver high-quality video content to your audience across multiple devices and platforms. The platform supports industry-standard protocols including HLS, DASH, and AES encryption with optional DRM protection.

### Key Features

- **Multi-Protocol Support**: Stream content using HLS, DASH, and AES protocols
- **Adaptive Bitrate Streaming**: Automatic quality adjustment based on viewer bandwidth
- **DRM Protection**: Secure your premium content with industry-standard DRM
- **Multi-Device Compatibility**: Reach viewers on web, mobile, tablets, and set-top boxes
- **Real-Time Monitoring**: Track stream health and performance in real-time
- **Scalable Architecture**: Handle varying loads with transcoding and packaging components

## Platform Components

### Input Streams
Configure and manage live video input sources from encoders, supporting UDP and RTMP protocols.

### Transcoders
Transform input streams into multiple quality renditions for adaptive bitrate streaming.

### Packagers
Package transcoded streams into HLS, DASH, and AES formats with optional DRM encryption.

### Origin Servers
Store and serve packaged media segments to CDNs and client devices.

## Getting Started

1. **Configure Input Stream**: Set up your video source with proper Content ID and source URL
2. **Create Transcoder**: Define ABR profiles and renditions for your content
3. **Set Up Packagers**: Configure HLS, DASH, and/or AES packagers with appropriate settings
4. **Deploy Origin Server**: Enable content delivery from origin servers
5. **Test Playback**: Verify streaming across target devices and platforms

## Documentation Structure

- [Input Streams]({% link docs/input-streams.md %}) - Configure video sources
- [Transcoders]({% link docs/transcoders.md %}) - Set up video transcoding
- [Packagers]({% link docs/packagers.md %}) - Configure stream packaging
- [Origin Servers]({% link docs/origin-servers.md %}) - Deploy content delivery
- [Best Practices]({% link docs/best-practices.md %}) - Optimization guidelines
- [Troubleshooting]({% link docs/troubleshooting.md %}) - Common issues and solutions

## Support

For technical support and questions, please refer to our [Troubleshooting Guide]({% link docs/troubleshooting.md %}) or contact the support team.

---

*Powered by vLive Technology*
