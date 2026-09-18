# Relay

Relay is a local-first personal agent that runs as a static browser app. It has a real planner/tool/reply loop through an optional Token Harbor or OpenRouter model connection, encrypted private memory, tasks, notes, arithmetic, encrypted exports, and an offline fallback controller.

## Run locally

```sh
python3 -m http.server 4173 --bind 127.0.0.1
```

Open `http://127.0.0.1:4173`. Do not bind the development server to a public interface.

## Security model

- AES-256-GCM at rest with a new 96-bit IV for each save
- PBKDF2-SHA-256, 310,000 rounds, random 128-bit salt
- Passphrase and model credential only in tab memory
- Strict CSP; only the selected model providers (`https://tokenharbor.ai` and `https://openrouter.ai`) can receive network requests
- No analytics, cookies, accounts, remote assets, or backend
- Encrypted JSON portability with a 2 MB import cap
- Model output can only invoke an allow-listed tool registry
- No direct web search because the CSP permits no search provider and a static app has no safe proxy

A local app cannot provide multi-device E2EE or protect an already-compromised browser/device. Relay accurately describes this as client-side encrypted storage.

## Agent loop

1. Send recent conversation and tool schemas to the planner.
2. Validate and execute up to six allow-listed tool calls in-browser.
3. Return tool results to the model for a final answer.
4. Encrypt the updated workspace before writing local storage.

## Secret policy

Never commit or push credential material. Run `./prepush-secret-scan.sh` before every push. If it reports a match, stop and remove the secret before continuing.
