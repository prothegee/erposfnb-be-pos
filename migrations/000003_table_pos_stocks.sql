create table if not exists pos.stocks(
    id                  uuid                primary key default uuidv7(),
    tenant_id           uuid                not null,
    tenant_id_branch    uuid                not null,
    name                text                not null,
    quantity            bigint              not null default 0,
    quantity_warning    bigint              not null default 0,
    thumbnail           text                not null,
    description         text                null,
    category            text                null,
    tags                text[]              null,
    out_of_stock        boolean             not null default false,
    extra_info          text                null,
    weight              numeric             null,
    weight_deduct       numeric             not null default 0,
    weight_unit         pos.measure_type    null,
    dimension_x         numeric             null,
    dimension_y         numeric             null,
    dimension_z         numeric             null,
    dimension_unit      pos.length_type     null,

    constraint chk_pos_stocks_tags_max
        check (tags is null or cardinality(tags) <= 6),
    constraint chk_pos_stocks_weight_deduct
        check (
            (weight is null and weight_deduct = 0)
            or
            (
                weight is not null
                and weight > 0
                and weight_deduct >= 0
                and weight_deduct < weight
            )
        )
);

create index if not exists idx_pos_stocks_tenant_id on pos.stocks(tenant_id);
create index if not exists idx_pos_stocks_tenant_id_branch on pos.stocks(tenant_id_branch);
create index if not exists idx_pos_stocks_name on pos.stocks(name);
