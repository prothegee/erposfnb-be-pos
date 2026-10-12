create table if not exists pos.items(
    id                  uuid                primary key default uuidv7(),
    tenant_id           uuid                not null,
    tenant_id_branch    uuid                not null,
    name                text                not null,
    use_sync_stock      boolean             not null default false,
    thumbnail           text                not null,
    description         text                null,
    category            text                null,
    tags                text[]              null,
    out_of_order        boolean             not null default false,
    price               numeric(15,2)       not null,
    currency            pos.currency        not null default 'IDR',
    weight              numeric             null,
    weight_unit         pos.measure_type    null,
    dimension_x         numeric             null,
    dimension_y         numeric             null,
    dimension_z         numeric             null,
    dimension_unit      pos.length_type     null,

    constraint chk_pos_items_tags_max
        check (tags is null or cardinality(tags) <= 6)
);

create index if not exists idx_pos_items_tenant_id on pos.items(tenant_id);
create index if not exists idx_pos_items_tenant_id_branch on pos.items(tenant_id_branch);
create index if not exists idx_pos_items_name on pos.items(name);

create table if not exists pos.items_builder(
    id                  uuid                primary key default uuidv7(),
    id_item             uuid                not null,
    stock_id            uuid                not null,
    stock_weight        numeric             not null,
    stock_weight_unit   pos.measure_type    not null default 'kg',

    constraint fk_pos_items_builder_id_item
        foreign key (id_item)
        references pos.items(id)
        on delete cascade,
    constraint fk_pos_items_builder_stock_id
        foreign key (stock_id)
        references pos.stocks(id)
        on delete cascade
);

create index if not exists idx_pos_items_builder_id_item on pos.items_builder(id_item);
create index if not exists idx_pos_items_builder_stock_id on pos.items_builder(stock_id);

