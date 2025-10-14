import express from 'express';
import { shortenPostRequestBodySchema } from '../validation/request.validation.js';
import { nanoid } from 'nanoid';
import { db } from '../db/index.js';
import { urlsTable } from '../models/index.js';
import { ensureAuthenticated } from '../middlewares/auth.middleware.js';
import {and, eq } from 'drizzle-orm';


const router = express.Router();

router.post('/shorten', ensureAuthenticated, async function(req, res) {

  const validationResult = await shortenPostRequestBodySchema.safeParseAsync(req.body);

  if (validationResult.error) {
    return res.status(400).json({ error: validationResult.error.format() });
  }

  const { url, code } = validationResult.data;
  const shortCode = code ?? nanoid(6);

  try {
    const existing = await db.select().from(urlsTable).where(eq(urlsTable.shortCode, shortCode));

    if (existing.length > 0) {
      return res.status(409).json({ error: 'Short code already exists. Please use a different code or leave it empty to auto-generate.' });
    }

    const [result] = await db.insert(urlsTable).values({
      shortCode,
      targetUrl: url,
      userId: req.user.id,
    }).returning({
      id: urlsTable.id,
      shortCode: urlsTable.shortCode,
      targetUrl: urlsTable.targetUrl,
    });

    return res.status(201).json({ result: { id: result.id, shortCode: result.shortCode, targetUrl: result.targetUrl } });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
});

router.get('/codes', ensureAuthenticated, async function(req, res) {
    const codes = await db.select().from(urlsTable).where(eq(urlsTable.userId, req.user.id));
    return res.json({ codes });
});

router.delete('/:id', ensureAuthenticated, async function(req, res) {
    const id = req.params.id;
    await db.delete(urlsTable).where(and(eq(urlsTable.id, id), eq(urlsTable.userId, req.user.id)));
    return res.status(200).json({ deleted: true });
});

router.get('/:shortCode', async function(req, res) {

    const code = req.params.shortCode;

    const [result] = await db.select(
        {
            targetUrl: urlsTable.targetUrl
        }
    ).from(urlsTable).where(eq(urlsTable.shortCode, code));

    if (!result) {
        return res.status(404).json({ error: 'Invalid Url' });
    }

    return res.redirect(result.targetUrl);
});

export default router;