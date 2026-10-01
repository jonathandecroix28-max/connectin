const stripTrailingSlash = (value) => value.replace(/\/+$/, "");

const rawApiUrl = import.meta.env.VITE_API_URL || "http://localhost:8000";
const normalizedApiUrl = stripTrailingSlash(rawApiUrl);
const rawStorageUrl = import.meta.env.VITE_STORAGE_URL || `${normalizedApiUrl}/storage`;

export const API_URL = normalizedApiUrl.endsWith("/api")
	? normalizedApiUrl
	: `${normalizedApiUrl}/api`;

export const STORAGE_URL = stripTrailingSlash(rawStorageUrl);

export const buildStorageUrl = (path) => {
	if (!path) return "";
	if (/^https?:\/\//i.test(path)) return path;

	const cleanPath = String(path).replace(/^\/+/, "");
	return `${STORAGE_URL}/${cleanPath}`;
};