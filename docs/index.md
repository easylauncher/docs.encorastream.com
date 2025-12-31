---
layout: default
title: Home
nav_order: 1
description: "Test - Encora Stream - Live Streaming Platform Documentation"
permalink: /
---

# {{ site.product_name }} Documentation
{: .fs-9 }

Welcome to the {{ site.product_name }} platform documentation. {{ site.product_name }} is a comprehensive live streaming solution powered by {{ site.partner_name }} technology.
{: .fs-6 .fw-300 }

[Get Started](#getting-started){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

## Overview

{{ site.product_name }} is a white-labeled live streaming platform that enables you to deliver high-quality video content to your audience across multiple devices and platforms. The platform supports industry-standard protocols including HLS, DASH, and AES encryption with optional DRM protection.

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

### 🚀 Getting Started
Start your streaming journey with our quick start guide and platform overview.

### 🔧 Platform Components
Learn about the core components that power your streaming infrastructure:
- **📥 Input Streams** - Configure video sources from encoders
- **⚙️ Transcoders** - Transform streams into multiple quality renditions
- **📦 Packagers** - Package content for HLS, DASH, and AES delivery
- **🌐 Origin Servers** - Deploy content delivery infrastructure

### 📚 Guides & Best Practices
Optimize your deployment with expert guidance and operational excellence tips.

### 🔍 Reference & Troubleshooting
Find solutions to common issues and detailed reference materials.

## Support

For technical support and questions, please refer to our [Troubleshooting Guide](docs/reference/troubleshooting/) or contact the support team.

---

*Powered by {{ site.partner_name }} Technology*



