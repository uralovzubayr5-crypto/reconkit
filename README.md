# ReconKit

Scoped recon for authorized engagements — one command, one report, everything logged.

ReconKit exists because recon tooling is easy to run and hard to *document*. It refuses
to touch a host that is not on a signed scope list, logs every command it runs, and
produces a single Markdown report you can attach to the client deliverable.

Built by [Zubayr Uralov](https://github.com/uralovzubayr5-crypto).

## Install

```sh
git clone https://github.com/uralovzubayr5-crypto/reconkit
cd reconkit
chmod +x reconkit/recon.sh
```

Requires: `subfinder`, `nmap`, `openssl`, plus `jq` for the merge step. On Kali they
are one `apt install` away.

## Usage

```sh
# scope.txt — one domain per line, signed off by the client
cat scope.txt
example-client.com

./reconkit/recon.sh example-client.com
```

Output lands in `engagements/<date>/<target>/`:

```
subdomains.txt   nmap .nmap/.xml      tls.md
report.md        commands.log
```

Anything outside `scope.txt` is refused with exit code 2 — no flags to remember.

## What it does

1. **subdomains** — passive enumeration via `subfinder`
2. **ports** — `nmap -T3 -p- --open` across resolved hosts
3. **tls** — certificate subject/issuer/dates per host, so expiring certs are findings too
4. **report** — merges the three into `report.md` with a timestamp and the exact command log

## Config

| env var | default | meaning |
|---|---|---|
| `SCOPE_FILE` | `scope.txt` | path to the signed scope list |
| `OUT_DIR` | `engagements` | root output directory |
| `NMAP_ARGS` | `-T3 -p- --open` | override scan profile (be kind to prod) |

## Ethics

Recon without written authorization is illegal in most jurisdictions. ReconKit's scope
gate is not a substitute for a signed engagement letter — it is a reminder that one
exists.

## License

MIT
