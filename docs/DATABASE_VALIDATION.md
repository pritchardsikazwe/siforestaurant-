# Database validation plan — SifoRestaurant

Status: schema draft only; not applied to any database.

## Required before production
- Apply migrations to a disposable Supabase/PostgreSQL project first.
- Create two companies and users; verify each user can only access their own company records.
- Verify staff roles cannot manage company membership; only owner/admin can.
- Test foreign-key paths and invalid quantities/prices/status values.
- Verify order totals are calculated server-side; never trust client-submitted totals.
- Add company-scoped branch validation to all write paths.
- Confirm audit events are append-only and capture actor, action, and record identity.
- Review RLS policy recursion, SECURITY DEFINER function ownership/search_path, and privilege grants.
- Add automated SQL migration tests before marking this PR ready.
