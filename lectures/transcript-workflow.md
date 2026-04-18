# Vimeo Transcript Extraction Workflow

## Prerequisites

```bash
brew install yt-dlp
pip3 install 'curl-cffi==0.14.0'  # must be 0.10.x-0.14.x for yt-dlp impersonation
```

Verify impersonation works:

```bash
yt-dlp --list-impersonate-targets
# Should show Chrome, Safari, Firefox etc. as available
```

## 1. Export Vimeo Cookies

yt-dlp cannot reliably decrypt Chrome cookies on macOS. Export them manually:

1. Install Chrome extension **"Get cookies.txt LOCALLY"**
2. Navigate to `vimeo.com` (logged in)
3. Click extension icon > Export > saves `cookies.txt`

## 2. List Videos in a Vimeo Folder

yt-dlp does not support Vimeo folder URLs. Use the Vimeo API via Python:

```python
import ssl, http.cookiejar, urllib.request, json, re

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

cj = http.cookiejar.MozillaCookieJar("cookies.txt")
cj.load(ignore_discard=True, ignore_expires=True)

opener = urllib.request.build_opener(
    urllib.request.HTTPCookieProcessor(cj),
    urllib.request.HTTPSHandler(context=ctx)
)

# Get JWT from folder page
opener.addheaders = [('User-Agent', 'Mozilla/5.0')]
resp = opener.open("https://vimeo.com/user/<USER_ID>/folder/<FOLDER_ID>")
html = resp.read().decode('utf-8')
token = re.search(r'"jwt"\s*:\s*"([^"]+)"', html).group(1)

# Query folder items via API
def api_get(path):
    opener.addheaders = [
        ('User-Agent', 'Mozilla/5.0'),
        ('Authorization', f'jwt {token}'),
        ('Accept', 'application/vnd.vimeo.*+json;version=3.4'),
    ]
    url = f"https://api.vimeo.com{path}"
    return json.loads(opener.open(url).read().decode('utf-8'))

data = api_get("/users/<USER_ID>/projects/<FOLDER_ID>/items?per_page=100")

for item in data['data']:
    if item['type'] == 'video':
        v = item['video']
        vid_id = v['uri'].split('/')[-1]
        print(f"https://vimeo.com/{vid_id}")
    elif item['type'] == 'folder':
        # Recurse into subfolders using item['folder']['uri']
        pass
```

Save output to `urls.txt` (one URL per line).

## 3. Download Transcripts

### Single video

```bash
yt-dlp --cookies cookies.txt \
  --write-subs --sub-langs "en-x-autogen" \
  --skip-download \
  "https://vimeo.com/<VIDEO_ID>"
```

### Batch download from URL list

```bash
yt-dlp --cookies cookies.txt \
  --write-subs --sub-langs "en-x-autogen" \
  --skip-download \
  -o "transcripts/%(title)s.%(ext)s" \
  -a urls.txt
```

### Parallel batch download

Split URLs and run concurrently:

```bash
split -l 36 urls.txt batch_

# Run all batches in parallel
for f in batch_*; do
  yt-dlp --cookies cookies.txt \
    --write-subs --sub-langs "en-x-autogen" \
    --skip-download \
    -o "transcripts/%(title)s.%(ext)s" \
    -a "$f" &
done
wait
```

## Key Flags

| Flag | Purpose |
|---|---|
| `--write-subs` | Download subtitles (use this, not `--write-auto-subs`, for Vimeo) |
| `--sub-langs "en-x-autogen"` | Vimeo's auto-generated English subtitle language code |
| `--skip-download` | Don't download the video, only subtitles |
| `--list-subs` | Check what subtitle languages are available |
| `--convert-subs srt` | Convert VTT to SRT format |
| `-o "%(title)s.%(ext)s"` | Output filename template |

## Gotchas

- **`--write-auto-subs` does not work for Vimeo.** Use `--write-subs` with `--sub-langs "en-x-autogen"`.
- **Duplicate titles across sections** (e.g., "1-Introduction") will overwrite each other. Use `-o "%(id)s-%(title)s.%(ext)s"` to prefix with video ID.
- **Cookie expiry**: the `vimeo` session cookie expires in ~30 days. Re-export if downloads start failing with 404s.
- **curl-cffi version**: yt-dlp only supports 0.10.x through 0.14.x. Version 0.15+ and 0.9.x will silently disable impersonation.
