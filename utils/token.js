import jwt from 'jsonwebtoken';
import { userTokenSchema } from '../validation/token.validation.js';

export async function createUserToken(payload) {
    const validationResult = await userTokenSchema.safeParseAsync(payload);

    if (validationResult.error) {
        throw new Error(validationResult.error.message);
    }

    const payloadValidatedData = validationResult.data;

    const secret = process.env.JWT_SECRET;
    if (!secret) {
        throw new Error('JWT_SECRET is not defined in environment variables');
    }

    const token = jwt.sign(payloadValidatedData, secret, { expiresIn: '1h' }); // Add expiration if needed
    return token;
}

export function validateUserToken(token) {
    const secret = process.env.JWT_SECRET;
    if (!secret) {
        throw new Error('JWT_SECRET is not defined in environment variables');
    }

    try {
        const payload = jwt.verify(token, secret);
        return payload;
    } catch (error) {
        return null;
    }
}
