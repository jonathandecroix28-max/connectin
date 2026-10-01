const stripTrailingSlash = (value) => value.replace(/\/+$/, "");

const rawApiUrl = import.meta.env.VITE_API_URL || "http://localhost:8000";
const normalizedApiUrl = stripTrailingSlash(rawApiUrl);

export const API_URL = normalizedApiUrl.endsWith("/api")
	? normalizedApiUrl
	: `${normalizedApiUrl}/api`;

export const STORAGE_URL = stripTrailingSlash(import.meta.env.VITE_STORAGE_URL || normalizedApiUrl);

export const buildStorageUrl = (path) => {
	if (!path) return "";
	if (/^https?:\/\//i.test(path)) return path;

	const cleanPath = String(path).replace(/^\/+/, "");
	return `${STORAGE_URL}/storage/${cleanPath}`;
};