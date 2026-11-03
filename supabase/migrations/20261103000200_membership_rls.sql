-- Membership/RLS baseline; review for your chosen auth provisioning before applying.
create table if not exists public.company_memberships(
 id uuid primary key default gen_random_uuid(),
 company_id uuid not null references public.companies(id) on delete cascade,
 user_id uuid not null references auth.users(id) on delete cascade,
 role text not null check(role in('owner','admin','manager','staff','viewer')),
 created_at timestamptz not null default now(),
 unique(company_id,user_id)
);
create or replace function public.has_company_access(target_company uuid)
returns boolean language sql stable security definer set search_path=public
as $$ select exists(select 1 from public.company_memberships m where m.company_id=target_company and m.user_id=auth.uid()) $$;
create or replace function public.is_company_admin(target_company uuid)
returns boolean language sql stable security definer set search_path=public
as $$ select exists(select 1 from public.company_memberships m where m.company_id=target_company and m.user_id=auth.uid() and m.role in('owner','admin')) $$;
alter table public.company_memberships enable row level security;
drop policy if exists "members can read own memberships" on public.company_memberships;
create policy "members can read own memberships" on public.company_memberships for select using(user_id=auth.uid());
drop policy if exists "company admins manage memberships" on public.company_memberships;
create policy "company admins manage memberships" on public.company_memberships for all using(public.is_company_admin(company_id)) with check(public.is_company_admin(company_id));
alter table public.branches enable row level security;
drop policy if exists "tenant members access branches" on public.branches;
create policy "tenant members access branches" on public.branches for all using(public.has_company_access(company_id)) with check(public.has_company_access(company_id));\nalter table public.restaurant_tables enable row level security;
drop policy if exists "tenant members access restaurant_tables" on public.restaurant_tables;
create policy "tenant members access restaurant_tables" on public.restaurant_tables for all using(public.has_company_access(company_id)) with check(public.has_company_access(company_id));\nalter table public.menu_items enable row level security;
drop policy if exists "tenant members access menu_items" on public.menu_items;
create policy "tenant members access menu_items" on public.menu_items for all using(public.has_company_access(company_id)) with check(public.has_company_access(company_id));\nalter table public.orders enable row level security;
drop policy if exists "tenant members access orders" on public.orders;
create policy "tenant members access orders" on public.orders for all using(public.has_company_access(company_id)) with check(public.has_company_access(company_id));\nalter table public.order_lines enable row level security;
drop policy if exists "tenant members access order_lines" on public.order_lines;
create policy "tenant members access order_lines" on public.order_lines for all using(public.has_company_access((select o.company_id from public.orders o where o.id=order_lines.order_id))) with check(public.has_company_access((select o.company_id from public.orders o where o.id=order_lines.order_id)));\nalter table public.audit_events enable row level security;
drop policy if exists "tenant members access audit_events" on public.audit_events;
create policy "tenant members access audit_events" on public.audit_events for all using(public.has_company_access(company_id)) with check(public.has_company_access(company_id));
