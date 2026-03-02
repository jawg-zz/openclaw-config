# supabase - Supabase management

Manage Supabase projects, databases, and migrations.

## Setup

Install Supabase CLI:
```bash
# Download binary from GitHub releases
curl -fsSL https://github.com/supabase/cli/releases/latest/download/supabase_linux_arm64.tar.gz -o supabase.tar.gz
tar -xzf supabase.tar.gz
rm supabase.tar.gz
```

Store your Supabase credentials in `TOOLS.md`:

```markdown
### Supabase

- **project_id**: Your Supabase project ID (e.g., wtyeuqqhlzzjhzqoxput)
- **access_token**: Your Supabase access token (get from https://app.supabase.com/account/tokens)
```

Set environment variable:
```bash
export SUPABASE_ACCESS_TOKEN="your-token-here"
```

## Link to Project

```bash
supabase link --project-ref YOUR_PROJECT_REF
```

### Apply Migrations from a GitHub Repo

```bash
# Clone the repo
git clone https://github.com/owner/repo.git
cd repo/supabase  # or wherever migrations are

# Link to your project
supabase link --project-ref YOUR_PROJECT_REF

# Push migrations (applies all pending migrations)
supabase db push

# Or reset database (warning: deletes all data)
supabase db reset
```

### Apply Migration Files Directly

If migrations are in a GitHub repo and you have the SQL content:

```bash
# Create a migration file locally
echo "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name TEXT);" > migrations/001_setup.sql

# Push to database
supabase db push
```

### Run SQL Directly

```bash
supabase db query "SELECT * FROM users LIMIT 10;"
```

### Generate Types from Database

```bash
supabase gen types typescript --project-id YOUR_PROJECT_REF > types/database.ts
```

### View Database Schema

```bash
# List tables
supabase db query "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"

# Describe a table
supabase db query "\d table_name"
```

### Run SQL Directly

```bash
# Run a SQL query
supabase db query "SELECT * FROM users LIMIT 10;"

# Run SQL from a file
supabase db query --file schema.sql
```

### Check Migration Status

```bash
supabase migration list
```

### Create a New Migration

```bash
supabase migration new migration_name
```

## Environment Variables

Your Supabase project needs these configured:

```bash
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key  # Keep secret!
```

## Troubleshooting

### Connection Issues

If you can't connect:
1. Check project status at https://status.supabase.com
2. Verify your access token is valid
3. Make sure the project is not paused

### Migration Conflicts

If migrations are out of sync:
```bash
# Repair migration history (mark as reverted)
supabase migration repair --status reverted 20250129

# Then push again
supabase db push
```

### Reset Database (Warning: Deletes All Data)

```bash
supabase db reset
```

### Check Current Schema

Use the Supabase Dashboard → SQL Editor:
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;
```
