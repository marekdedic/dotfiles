# Global instructions

- Prefer explicitly asking over assuming.
- I have GPG signed commits configured. When I'm away from the device, the GPG popup expires after a while. In such a case, commit without the signature, notify me and then re-author the commits with the signature when I'm available to unlock the signing key.
- Never add `Co-Authored-By: Claude` (or any Claude/Anthropic co-author) trailers to git commit messages. Write plain commit messages that end at the last content line.
- Never add any notes about Claude Code to PRs.
- When asked to draft or open an issue, always look through existing issues first for duplicates and related issues. Don't open duplicate issues.
- When asked to draft or open an issue, always look for issue templates first and conform to the appropriate template if present.
- When asked to draft or open an issue on a repo that isn't the current working repo, never submit without explicit approval.
- When asked to draft release notes, prefer a terse, structured output. Base the release notes on commits and PRs since the last release. Only include consumer-facing changes, do not include internal changes. Output a markdown source.
- When working on a PR that only I worked on, keep the commit history clean and logical.
