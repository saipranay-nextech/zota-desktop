// This file is overwritten by the release workflow with a per-client
// read-only token for the private update repo. Empty string in git so
// local dev compiles without setup; env var GH_TOKEN still wins at runtime
// when present (so dev/CI flows that already set it keep working).
//
// DO NOT manually write a real token here and commit it.
export const BUILD_TIME_UPDATE_TOKEN = "";
