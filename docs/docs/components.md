---
layout: default
title: Platform Components
nav_order: 3
has_children: true
---

# 🔧 Platform Components
{: .no_toc }

The {{ site.product_name }} platform consists of four core components that work together to deliver high-quality live streaming content.
{: .fs-6 .fw-300 }

---

## Component Overview

The streaming pipeline follows a logical flow from input to delivery:

```
📥 Input Streams → ⚙️ Transcoders → 📦 Packagers → 🌐 Origin Servers → Viewers
```

### Component Responsibilities

| Component | Icon | Purpose | Key Features |
|-----------|------|---------|--------------|
| **Input Streams** | 📥 | Ingest live video from encoders | UDP/RTMP support, Content ID management |
| **Transcoders** | ⚙️ | Create multiple quality renditions | ABR profiles, Multi-bitrate output |
| **Packagers** | 📦 | Format streams for delivery | HLS, DASH, AES, DRM support |
| **Origin Servers** | 🌐 | Store and deliver content | HTTP/HTTPS serving, CDN integration |

---

## Getting Started with Components

To deploy a complete streaming workflow:

1. **📥 [Configure Input Streams](input-streams/)** - Set up your video source
2. **⚙️ [Deploy Transcoders](transcoders/)** - Define quality profiles
3. **📦 [Set Up Packagers](packagers/)** - Choose delivery formats
4. **🌐 [Enable Origin Servers](origin-servers/)** - Activate content delivery

---

## Component Dependencies

Each component depends on the previous one in the pipeline:

- **Transcoders** require an active **Input Stream**
- **Packagers** require a running **Transcoder**
- **Origin Servers** require configured **Packagers**

{: .note }
Always configure components in the correct order to ensure smooth operation.

---

## Quick Links

- [Input Streams Configuration](input-streams/)
- [Transcoders Setup](transcoders/)
- [Packagers Guide](packagers/)
- [Origin Servers Deployment](origin-servers/)
