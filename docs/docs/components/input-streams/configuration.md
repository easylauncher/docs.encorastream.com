---
layout: default
title: Configuration Guide
parent: Input Streams
grand_parent: Platform Components
nav_order: 1
---

# Input Streams Configuration Guide
{: .no_toc }

Complete guide for adding, editing, and managing input streams.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Adding a New Input Stream

### Prerequisites

Before creating an input stream, ensure you have:

- Access to the encoder's output URL
- Confirmed the encoder is configured and running
- Network connectivity between encoder and platform
- A unique Content ID chosen for this stream

### Step-by-Step Guide

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

{: .warning }
The Source URL must be accessible from the server running the transcoder. Test connectivity before configuring!

---

## Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| Name | Human-readable channel name | "Sports Channel HD" |
| Content ID | Unique stream identifier (case-sensitive) | "sports_hd_01" |
| Source URL | Encoder stream location | `udp://@239.1.1.1:5000` |
| Server | Server receiving the input | server-01 |
| Status | Enable/Disable toggle | ENABLED |

### Field Validation Rules

**Name:**
- Any descriptive text
- Helps identify the stream in the UI
- Can be changed later

**Content ID:**
- Must be unique across all streams
- Case-sensitive (sport_01 ≠ Sport_01)
- Cannot be changed after creation
- No spaces (use underscores)
- Alphanumeric characters and underscores only

**Source URL:**
- Must include protocol (udp:// or rtmp://)
- Must be accessible from the transcoder server
- Should be tested before saving

---

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

---

## Editing an Input Stream

### Modifiable Fields

You can update the following:

- Name
- Source URL
- Status (Enable/Disable)

{: .important }
**Content ID cannot be changed** after creation. If you need a different Content ID, delete and recreate the input stream.

### Edit Workflow

1. Navigate to the input stream details page
2. Click **Edit** button
3. Modify the desired fields
4. Click **Save** to apply changes
5. Click **Cancel** to discard changes

### When to Edit

- **Name**: Update for better clarity
- **Source URL**: Change encoder location or switch to backup
- **Status**: Enable/disable without deleting configuration

---

## Enabling / Disabling Input Streams

### Toggle Operation

Use the Enable/Disable toggle to control stream processing without deleting the configuration.

**Workflow:**
1. Navigate to Input Streams list
2. Click the toggle icon next to the stream
3. Confirm the action in the dialog
4. Click **Ok** to proceed or **Cancel** to abort

### Use Cases

- **Temporary Maintenance**: Stop processing during encoder maintenance
- **Scheduled Content**: Enable only when content is scheduled
- **Resource Management**: Disable inactive channels to free resources
- **Testing**: Disable before making changes to connected components

{: .tip }
Disabling an input stream also stops associated transcoders and packagers.

---

## Deleting an Input Stream

### Delete Operation

Permanently removes the input stream configuration.

{: .danger }
**Warning:** This action cannot be undone. Associated transcoders and packagers must be removed first.

**Workflow:**
1. Navigate to Input Streams list
2. Click the **Delete** (bin) icon
3. Review the confirmation message
4. Click **Ok** to remove or **Cancel** to abort

### Before Deleting

Ensure the following:

- [ ] No active transcoders are using this input
- [ ] No packagers depend on this stream
- [ ] Stream is disabled to prevent disruption
- [ ] You have documented the configuration if you might need it later

### Deletion Dependencies

If you see an error when deleting, check for:

1. **Transcoders using this input** - Delete transcoders first
2. **Packagers depending on transcoders** - Delete packagers first
3. **Active streaming sessions** - Disable and wait for cleanup

---

## Configuration Best Practices

### Naming Conventions

**Good Examples:**
- `news_channel_hd` - Clear, descriptive, no spaces
- `sports_primary_4k` - Includes purpose and quality
- `entertainment_backup` - Indicates role

**Avoid:**
- `stream1`, `test` - Too generic
- `My Channel` - Contains spaces
- `SPORT$_HD!` - Special characters

### Content ID Guidelines

✅ **Do:**
- Use consistent naming scheme
- Include environment if needed: `prod_news_hd`, `stage_news_hd`
- Document all Content IDs in a central location
- Use lowercase for consistency

❌ **Don't:**
- Mix cases randomly
- Use spaces or special characters
- Reuse Content IDs
- Make Content IDs too long

### Source URL Best Practices

**UDP Multicast:**
- Verify multicast routing is configured
- Test connectivity with `ffprobe` before configuring
- Document multicast groups used
- Use consistent multicast address ranges

**RTMP:**
- Use strong stream keys for security
- Test with OBS or similar tools first
- Monitor connection stability
- Consider using backup RTMP servers

---

## Advanced Configuration

### Multiple Inputs for Redundancy

For critical streams, configure redundant inputs:

**Primary:**
```
Name: "News Primary"
Content ID: "news_primary_hd"
Source URL: udp://@239.1.1.1:5000
```

**Backup:**
```
Name: "News Backup"
Content ID: "news_backup_hd"
Source URL: udp://@239.1.1.2:5000
```

### Network Interface Selection

When multiple network interfaces exist:

- **Management Interface**: For dashboard access
- **Streaming Interface**: For high-bandwidth video traffic
- **Separate VLANs**: For traffic isolation

---

## Troubleshooting Configuration Issues

### Issue: Cannot Save Input Stream

**Possible Causes:**
- Duplicate Content ID
- Invalid Source URL format
- Required field missing
- No server available

**Solution:**
- Verify Content ID is unique
- Check URL format matches protocol
- Ensure all required fields are filled
- Contact administrator if no servers available

### Issue: Cannot Delete Input Stream

**Cause:** Dependent components exist

**Solution:**
1. Navigate to Transcoders
2. Find and delete transcoders using this input
3. Navigate to Packagers
4. Delete packagers dependent on those transcoders
5. Try deleting input stream again

### Issue: Content ID Mismatch Errors

**Cause:** Case-sensitive Content ID not matching

**Solution:**
- Content IDs are case-sensitive
- Check for trailing spaces
- Verify exact match in all components
- Use copy-paste to avoid typos

---

## Related Documentation

- [Protocol Support](../protocols/) - UDP and RTMP details
- [Testing Guide](../testing/) - Verify configurations
- [Best Practices](../best-practices/) - Optimization tips
- [Troubleshooting](../../../reference/troubleshooting/) - Common issues
