import re

_TAG_RE = re.compile(r"<[^>]+>")


def strip_html(value: str) -> str:
    """Remove all HTML tags from a string to prevent stored XSS."""
    if not value:
        return value
    return _TAG_RE.sub("", value).strip()


def sanitize_dict(data: dict, fields: list[str]) -> dict:
    """Strip HTML tags from specified string fields in a dict (in-place)."""
    for f in fields:
        v = data.get(f)
        if isinstance(v, str):
            data[f] = strip_html(v)
    return data
