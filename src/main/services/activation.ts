import { configService } from './config';
import { decryptActivationCode } from './crypto';
import { ActivationPayload } from '../../shared/types';

export interface ActivationResult {
  success: boolean;
  error?: string;
  payload?: ActivationPayload;
}

class ActivationService {
  async activate(code: string): Promise<ActivationResult> {
    const trimmedCode = code.trim();

    if (!trimmedCode) {
      return { success: false, error: 'Activation code is required' };
    }

    const payload = decryptActivationCode(trimmedCode);

    if (!payload) {
      return { success: false, error: 'Invalid or expired activation code' };
    }

    // Save activation to config
    await configService.save({
      activated: true,
      customerId: payload.customerId,
      customerName: payload.customerName,
      activatedAt: new Date().toISOString(),
    });

    return { success: true, payload };
  }

  async isActivated(): Promise<boolean> {
    return configService.isActivated();
  }

  async getActivationInfo(): Promise<{
    activated: boolean;
    customerId: string;
    customerName: string;
  }> {
    const config = await configService.load();
    return {
      activated: config.activated,
      customerId: config.customerId,
      customerName: config.customerName,
    };
  }
}

export const activationService = new ActivationService();
