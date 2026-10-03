-- Rode este arquivo inteiro em: Supabase > SQL Editor > New query > Run

create table if not exists alunos (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  created_at timestamptz default now()
);

create table if not exists presencas (
  aluno_id uuid not null references alunos(id) on delete cascade,
  data date not null,
  status text not null check (status in ('P','F','J')),
  primary key (aluno_id, data)
);

create table if not exists sem_treino (
  data date primary key
);

alter table alunos enable row level security;
alter table presencas enable row level security;
alter table sem_treino enable row level security;

-- Somente usuarios logados podem ler e alterar
drop policy if exists "logado alunos" on alunos;
create policy "logado alunos" on alunos for all to authenticated using (true) with check (true);
drop policy if exists "logado presencas" on presencas;
create policy "logado presencas" on presencas for all to authenticated using (true) with check (true);
drop policy if exists "logado sem_treino" on sem_treino;
create policy "logado sem_treino" on sem_treino for all to authenticated using (true) with check (true);
