/**
 * Blackmon Lab chat proxy — Cloudflare Worker
 * Uses Cloudflare Workers AI — no external API key needed.
 * Deploy: npx wrangler deploy
 */

const CONTEXT_URL    = 'https://coleoguy.github.io/llms.txt';
const ALLOWED_ORIGIN = 'https://coleoguy.github.io';
const MODEL          = '@cf/meta/llama-3.1-8b-instruct';

export default {
  async fetch(request, env) {
    const corsHeaders = {
      'Access-Control-Allow-Origin': ALLOWED_ORIGIN,
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    };

    const json = (body, status = 200) =>
      new Response(JSON.stringify(body), {
        status,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });

    if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: corsHeaders });
    if (request.method !== 'POST') return json({ error: 'Method not allowed' }, 405);

    let question;
    try { ({ question } = await request.json()); }
    catch { return json({ error: 'Invalid JSON' }, 400); }

    if (!question?.trim()) return json({ error: 'No question' }, 400);

    let labContext = '';
    try {
      const ctxResp = await fetch(CONTEXT_URL, { cf: { cacheTtl: 3600, cacheEverything: true } });
      labContext = await ctxResp.text();
    } catch {
      return json({ error: 'Could not load lab context' }, 502);
    }

    const systemPrompt =
      'You are a research assistant for the Blackmon Lab at Texas A&M University. ' +
      'Answer ONLY using the LAB CONTEXT provided below. Do not use outside knowledge. ' +
      'Be concise (2–4 sentences). If the answer is not in the context, say so honestly.\n\n' +
      'LAB CONTEXT:\n' + labContext;

    let result;
    try {
      result = await env.AI.run(MODEL, {
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: question.trim() },
        ],
        max_tokens: 300,
      });
    } catch (err) {
      return json({ error: 'AI inference failed', detail: String(err) }, 502);
    }

    const answer = result?.response;
    if (!answer) return json({ error: 'Empty AI response' }, 502);

    return json({ answer });
  },
};
