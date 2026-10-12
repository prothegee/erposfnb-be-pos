create table if not exists pos.stock_request(
    id                  uuid                        primary key default uuidv7(),
    tenant_id           uuid                        not null,
    tenant_id_branch    uuid                        not null,
    id_stock_local      uuid                        null,
    id_stock_warehouse  uuid                        null,
    name                text                        not null,
    quantity            bigint                      not null default 0,
    weight              numeric                     null,
    weight_unit         pos.measure_type            null,
    dimension_x         numeric                     null,
    dimension_y         numeric                     null,
    dimension_z         numeric                     null,
    dimension_unit      pos.length_type             null,
    note                text                        null,
    status              pos.stock_request_status    not null default 'pending',
    request_by          uuid                        not null,
    request_at          timestamp                   not null default now(),
    approved_by         uuid                        null,
    approved_at         timestamp                   null,
    received_by         uuid                        null,
    received_at         timestamp                   null
);

create index if not exists idx_pos_stock_request_tenant on pos.stock_request(tenant_id);
create index if not exists idx_pos_stock_request_branch on pos.stock_request(tenant_id_branch);
create index if not exists idx_pos_stock_request_status on pos.stock_request(status);
