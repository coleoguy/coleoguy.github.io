/**
 * Blackmon Lab chat proxy — Cloudflare Worker
 *
 * DEPLOY STEPS:
 *   1. Go to https://dash.cloudflare.com/ → Workers & Pages → Create application → Create Worker
 *   2. Paste this file, save and deploy.
 *   3. In Settings → Variables → add a Secret named GEMINI_API_KEY
 *      (get a free key at https://aistudio.google.com/app/apikey)
 *   4. Copy the Worker URL (looks like https://blackmon-lab-chat.YOURNAME.workers.dev)
 *   5. Paste that URL as WORKER_URL in assets/js/v3.js
 *
 * Free tier limits: 100,000 requests/day, Gemini 2.0 Flash: 1,500 req/day, 1M tokens/min.
 */

const GEMINI_MODEL = 'gemini-2.0-flash';
const CONTEXT_URL  = 'https://coleoguy.github.io/llms-full.txt';
const ALLOWED_ORIGIN = 'https://coleoguy.github.io';

export default {
  async fetch(request, env) {
    const origin = request.headers.get('Origin') || '';
    const corsHeaders = {
      'Access-Control-Allow-Origin': ALLOWED_ORIGIN,
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type',
    };

    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: corsHeaders });
    }

    if (request.method !== 'POST') {
      return new Response('Method not allowed', { status: 405 });
    }

    let question;
    try {
      ({ question } = await request.json());
    } catch {
      return new Response(JSON.stringify({ error: 'Invalid JSON' }), { status: 400, headers: corsHeaders });
    }

    if (!question || !question.trim()) {
      return new Response(JSON.stringify({ error: 'No question' }), { status: 400, headers: corsHeaders });
    }

    // Fetch lab context — Cloudflare edge caches this for 1 hour
    const ctxResp = await fetch(CONTEXT_URL, { cf: { cacheTtl: 3600, cacheEverything: true } });
    const labContext = await ctxResp.text();

    const systemPrompt =
      'You are the Blackmon Lab research assistant at Texas A&M University. ' +
      'Answer questions about the lab\'s research, people, and publications using the lab context below. ' +
      'Be concise (2–4 sentences). If the answer isn\'t in the context, say so honestly.\n\n' +
      'LAB CONTEXT:\n' + labContext;

    const geminiResp = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${env.GEMINI_API_KEY}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          system_instruction: { parts: [{ text: systemPrompt }] },
          contents: [{ role: 'user', parts: [{ text: question.trim() }] }],
          generationConfig: { maxOutputTokens: 300, temperature: 0.3 },
        }),
      }
    );

    const data = await geminiResp.json();
    const answer = data?.candidates?.[0]?.content?.parts?.[0]?.text;

    if (!answer) {
      return new Response(
        JSON.stringify({ error: 'No response from Gemini', raw: data }),
        { status: 502, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      );
    }

    return new Response(
      JSON.stringify({ answer }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    );
  },
};
