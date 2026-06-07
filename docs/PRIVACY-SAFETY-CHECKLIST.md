# Privacy + Safety Checklist

Use this before pushing any reusable engineering asset to this public repo.

## Never Commit

- API keys
- OAuth client secrets
- tokens
- private `.env` values
- customer data
- private emails or phone numbers
- local machine absolute paths
- production-only deploy commands with sensitive app names or secrets
- private screenshots unless approved

## Check For

```text
sk-
gho_
GOOGLE_CLIENT_SECRET
OPENAI_API_KEY
AUTH_SECRET
DATABASE_URL=
/Users/
C:\Users\
.env
```

## Public-Friendly Replacement

Use placeholders:

```env
OPENAI_API_KEY=
GOOGLE_CLIENT_SECRET=
DATABASE_URL=sqlite:///local.db
```

Use generic paths:

```text
/path/to/project
~/.cursor/skills
```

## Rule

If an asset only works because it contains private production details, turn it into a template instead of publishing the exact workflow.
