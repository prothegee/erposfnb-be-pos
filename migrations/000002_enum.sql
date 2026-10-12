do $$
begin
    begin
    create type pos.measure_type as enum(
        'ton', 'kg', 'g', 'mg', 'L', 'ml'
    );
    exception when duplicate_object then null;
    end;

    begin
    create type pos.length_type as enum(
        'mm', 'cm', 'm', 'km'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

do $$
begin
    begin
    create type pos.order_type as enum ('dine_in', 'take_away', 'online_order');
    exception when duplicate_object then null;
    end;

    begin
    create type pos.order_status as enum ('pending', 'processing', 'ready', 'completed');
    exception when duplicate_object then null;
    end;
end;
$$;

do $$
begin
    begin
    create type pos.currency as enum (
        'IDR'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

do $$
begin
    begin
    create type pos.payment_status as enum ('pending', 'declined', 'paid');
    exception when duplicate_object then null;
    end;

    begin
    create type pos.payment_method as enum ('cash', 'debit', 'credit', 'qr');
    exception when duplicate_object then null;
    end;
end;
$$;

do $$
begin
    begin
    create type pos.stock_request_status as enum ('pending', 'approved', 'shipped', 'received');
    exception when duplicate_object then null;
    end;
end;
$$;
