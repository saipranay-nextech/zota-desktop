#!/usr/bin/env node

/**
 * Downloads the PostgreSQL installer for bundling with the app.
 *
 * Usage:
 *   node scripts/download-postgres.js
 *
 * Downloads PostgreSQL 14 Windows x64 installer to resources/
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

const POSTGRES_VERSION = '14.13-1';
const DOWNLOAD_URL = `https://get.enterprisedb.com/postgresql/postgresql-${POSTGRES_VERSION}-windows-x64.exe`;
const OUTPUT_DIR = path.resolve(__dirname, '..', 'resources');
const OUTPUT_FILE = path.join(OUTPUT_DIR, 'postgresql-14-windows-x64.exe');

if (fs.existsSync(OUTPUT_FILE)) {
  const stats = fs.statSync(OUTPUT_FILE);
  console.log(`PostgreSQL installer already exists (${(stats.size / 1024 / 1024).toFixed(1)} MB)`);
  console.log(`Path: ${OUTPUT_FILE}`);
  process.exit(0);
}

// Ensure resources directory exists
if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

console.log(`Downloading PostgreSQL ${POSTGRES_VERSION} installer...`);
console.log(`URL: ${DOWNLOAD_URL}`);
console.log(`Saving to: ${OUTPUT_FILE}\n`);

function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);

    https.get(url, (response) => {
      // Handle redirects
      if (response.statusCode === 301 || response.statusCode === 302) {
        file.close();
        fs.unlinkSync(dest);
        return download(response.headers.location, dest).then(resolve).catch(reject);
      }

      if (response.statusCode !== 200) {
        file.close();
        fs.unlinkSync(dest);
        reject(new Error(`Download failed with status ${response.statusCode}`));
        return;
      }

      const totalSize = parseInt(response.headers['content-length'] || '0', 10);
      let downloadedSize = 0;
      let lastPercent = 0;

      response.on('data', (chunk) => {
        downloadedSize += chunk.length;
        if (totalSize > 0) {
          const percent = Math.round((downloadedSize / totalSize) * 100);
          if (percent !== lastPercent && percent % 5 === 0) {
            const mb = (downloadedSize / 1024 / 1024).toFixed(1);
            const totalMb = (totalSize / 1024 / 1024).toFixed(1);
            process.stdout.write(`\r  ${percent}% (${mb} / ${totalMb} MB)`);
            lastPercent = percent;
          }
        }
      });

      response.pipe(file);

      file.on('finish', () => {
        file.close();
        console.log('\n\nDownload complete!');
        const stats = fs.statSync(dest);
        console.log(`File size: ${(stats.size / 1024 / 1024).toFixed(1)} MB`);
        resolve();
      });
    }).on('error', (err) => {
      file.close();
      if (fs.existsSync(dest)) fs.unlinkSync(dest);
      reject(err);
    });
  });
}

download(DOWNLOAD_URL, OUTPUT_FILE)
  .then(() => {
    console.log(`\nPostgreSQL installer ready at: ${OUTPUT_FILE}`);
  })
  .catch((err) => {
    console.error(`\nDownload failed: ${err.message}`);
    console.error('\nYou can manually download it from:');
    console.error('  https://www.enterprisedb.com/downloads/postgres-postgresql-downloads');
    console.error(`\nPlace the installer at: ${OUTPUT_FILE}`);
    process.exit(1);
  });
