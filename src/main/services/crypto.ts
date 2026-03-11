import * as crypto from 'crypto';
import { ActivationPayload } from '../../shared/types';

const ALGORITHM = 'aes-256-gcm';
const ENCRYPTION_KEY = Buffer.from('ZotaCPOS2024SecretKey32Bytes!!' + '@@', 'utf8').subarray(0, 32);
const IV_LENGTH = 16;
const AUTH_TAG_LENGTH = 16;

export function encryptActivationCode(payload: ActivationPayload): string {
  const iv = crypto.randomBytes(IV_LENGTH);
  const cipher = crypto.createCipheriv(ALGORITHM, ENCRYPTION_KEY, iv);

  const jsonString = JSON.stringify(payload);
  const encrypted = Buffer.concat([
    cipher.update(jsonString, 'utf8'),
    cipher.final(),
  ]);

  const authTag = cipher.getAuthTag();

  // Format: IV (16) + AuthTag (16) + Encrypted data
  const combined = Buffer.concat([iv, authTag, encrypted]);
  return 'ZOTA-' + combined.toString('base64');
}

export function decryptActivationCode(code: string): ActivationPayload | null {
  try {
    if (!code.startsWith('ZOTA-')) {
      return null;
    }

    const data = Buffer.from(code.slice(5), 'base64');

    if (data.length < IV_LENGTH + AUTH_TAG_LENGTH + 1) {
      return null;
    }

    const iv = data.subarray(0, IV_LENGTH);
    const authTag = data.subarray(IV_LENGTH, IV_LENGTH + AUTH_TAG_LENGTH);
    const encrypted = data.subarray(IV_LENGTH + AUTH_TAG_LENGTH);

    const decipher = crypto.createDecipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
    decipher.setAuthTag(authTag);

    const decrypted = Buffer.concat([
      decipher.update(encrypted),
      decipher.final(),
    ]);

    const payload = JSON.parse(decrypted.toString('utf8')) as ActivationPayload;

    // Validate expiration if present
    if (payload.expiresAt) {
      const expiry = new Date(payload.expiresAt);
      if (expiry < new Date()) {
        return null;
      }
    }

    // Validate required fields
    if (!payload.customerId || !payload.customerName || payload.version !== 1) {
      return null;
    }

    return payload;
  } catch (error) {
    console.error('Failed to decrypt activation code:', error);
    return null;
  }
}
