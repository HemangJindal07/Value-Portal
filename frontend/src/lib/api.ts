const DEFAULT_API_URL = "http://localhost:8000";

function getApiBaseUrl(): string {
  // Prefer a runtime-injected value so we don't get stuck with stale
  // Turbopack inlined `NEXT_PUBLIC_*` values.
  if (typeof window !== "undefined") {
    const injected = (window as unknown as {
      __VALUE_PORTAL_API_URL__?: unknown;
    }).__VALUE_PORTAL_API_URL__;

    if (typeof injected === "string" && injected.length > 0) return injected;
  }

  return process.env.NEXT_PUBLIC_API_URL || DEFAULT_API_URL;
}

type RequestOptions = {
  method?: string;
  body?: unknown;
  token?: string;
};

export type UploadResult = {
  url: string;
  filename: string;
  size: number;
  content_type: string;
};

/**
 * Upload a file to the backend /api/uploads endpoint.
 * Returns the Supabase Storage public URL.
 */
export async function uploadFile(
  file: File,
  token: string
): Promise<UploadResult> {
  const formData = new FormData();
  formData.append("file", file);

  const res = await fetch(`${getApiBaseUrl()}/api/uploads`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${token}`,
    },
    body: formData,
  });

  if (!res.ok) {
    const error = await res.json().catch(() => ({ detail: "Upload failed" }));
    throw new Error(error.detail || `Upload error: ${res.status}`);
  }

  return res.json();
}

export async function api<T = unknown>(
  endpoint: string,
  options: RequestOptions = {}
): Promise<T> {
  const { method = "GET", body, token } = options;

  const headers: Record<string, string> = {
    "Content-Type": "application/json",
  };

  if (token) {
    headers["Authorization"] = `Bearer ${token}`;
  }

  const res = await fetch(`${getApiBaseUrl()}${endpoint}`, {
    method,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });

  if (!res.ok) {
    const error = await res.json().catch(() => ({ detail: "Request failed" }));
    const detail = Array.isArray(error.detail)
      ? error.detail.map((d: { msg?: string }) => d.msg ?? JSON.stringify(d)).join("; ")
      : error.detail || `API error: ${res.status}`;
    throw new Error(detail);
  }

  if (res.status === 204) {
    return undefined as T;
  }

  const text = await res.text();
  if (!text) {
    return undefined as T;
  }

  return JSON.parse(text) as T;
}
