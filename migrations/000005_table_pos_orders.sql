create table if not exists pos.orders(
    id                  uuid                primary key default uuidv7(),
    tenant_id           uuid                not null,
    tenant_id_branch    uuid                not null,
    type                pos.order_type      not null default 'dine_in',
    status              pos.order_status    not null default 'pending',
    customer_name       text                null,
    customer_phone      text                null,
    customer_email      text                null,
    order_created       timestamp           not null default now(),
    last_updated        timestamp           not null default now()
);

create index if not exists idx_pos_orders_tenant_id on pos.orders(tenant_id);
create index if not exists idx_pos_orders_tenant_id_branch on pos.orders(tenant_id_branch);
create index if not exists idx_pos_orders_type_and_status on pos.orders(type, status);
create index if not exists idx_pos_orders_customer_info
    on pos.orders(customer_name, customer_phone, customer_email);

create table if not exists pos.order_items(
    id                  uuid                primary key default uuidv7(),
    id_order            uuid                not null,
    id_item             uuid                not null,
    quantity            bigint              not null default 1,
    price_at_order      numeric(15,2)       not null,
    currency_at_order   pos.currency        not null default 'IDR',
    weight              numeric             null,
    weight_unit         pos.measure_type    null,

    constraint fk_pos_order_items_id_order
        foreign key (id_order)
        references pos.orders(id)
        on delete cascade,
    constraint fk_pos_order_items_id_item
        foreign key (id_item)
        references pos.items(id)
        on delete no action
);

create index if not exists idx_pos_order_items_id_order on pos.order_items(id_order);
create index if not exists idx_pos_order_items_id_item on pos.order_items(id_item);

create table if not exists pos.orders_tax(
    id                  uuid            primary key default uuidv7(),
    tenant_id           uuid            not null,
    tenant_id_branch    uuid            not null,
    name                text            not null,
    percentage          numeric(5,2)    not null,

    constraint chk_pos_orders_tax_percentage
        check (percentage >= 0 and percentage <= 100)
);

create index if not exists idx_pos_orders_tax_tenant_id on pos.orders_tax(tenant_id);
create index if not exists idx_pos_orders_tax_tenant_id_branch on pos.orders_tax(tenant_id_branch);

create table if not exists pos.order_tax_line(
    id                  uuid            primary key default uuidv7(),
    id_order            uuid            not null,
    id_tax              uuid            not null,
    name_snapshot       text            not null,
    percentage_snapshot numeric(5,2)    not null,

    constraint fk_pos_order_tax_line_id_order
        foreign key (id_order)
        references pos.orders(id)
        on delete cascade,
    constraint fk_pos_order_tax_line_id_tax
        foreign key (id_tax)
        references pos.orders_tax(id)
        on delete no action
);

create index if not exists idx_pos_order_tax_line_id_order on pos.order_tax_line(id_order);

Create table if not exists pos.order_payment(
    id_order            uuid                primary key,
    total               numeric(15,2)       not null,
    currency            pos.currency        not null default 'IDR',
    status              pos.payment_status  not null default 'pending',
    method              pos.payment_method  not null default 'cash',

    constraint fk_pos_order_payment_id_order
        foreign key (id_order)
        references pos.orders(id)
        on delete no action
);
