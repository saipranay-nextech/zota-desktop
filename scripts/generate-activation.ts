#!/usr/bin/env ts-node

import { encryptActivationCode } from '../src/main/services/crypto';
import { ActivationPayload } from '../src/shared/types';

const args = process.argv.slice(2);

function parseArgs(): {
  customerId: string;
  customerName: string;
  expires?: string;
} {
  const result: any = {};

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--customer-id' && args[i + 1]) {
      result.customerId = args[++i];
    } else if (args[i] === '--customer-name' && args[i + 1]) {
      result.customerName = args[++i];
    } else if (args[i] === '--expires' && args[i + 1]) {
      result.expires = args[++i];
    }
  }

  return result;
}

function main() {
  const { customerId, customerName, expires } = parseArgs();

  if (!customerId || !customerName) {
    console.error(
      'Usage: npm run generate-activation -- --customer-id <id> --customer-name "<name>" [--expires YYYY-MM-DD]'
    );
    process.exit(1);
  }

  const payload: ActivationPayload = {
    customerId,
    customerName,
    version: 1,
  };

  if (expires) {
    payload.expiresAt = expires;
  }

  const code = encryptActivationCode(payload);

  console.log('\n========================================');
  console.log(`Activation Code for: ${customerName}`);
  console.log('========================================\n');
  console.log(code);
  console.log('\n========================================');
  console.log('Share this code with the customer.');
  console.log('========================================\n');
}

main();
