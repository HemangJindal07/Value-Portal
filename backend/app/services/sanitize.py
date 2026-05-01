import re

_TAG_RE = re.compile(r"<[^>]+>")
_EVENT_ATTR_RE = re.compile(r'\s+on\w+\s*=\s*("[^"]*"|\'[^\']*\'|[^\s>]*)', re.IGNORECASE)


def strip_html(value: str) -> str:
    """Remove HTML tags and event handler attributes to prevent stored XSS."""
    if not value:
        return value
    value = _EVENT_ATTR_RE.sub("", value)
    return _TAG_RE.sub("", value).strip()


def sanitize_dict(data: dict, fields: list[str]) -> dict:
    """Strip HTML tags from specified string fields in a dict (in-place)."""
    for f in fields:
        v = data.get(f)
        if isinstance(v, str):
            data[f] = strip_html(v)
    return data
