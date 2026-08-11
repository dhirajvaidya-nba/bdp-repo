-- Mart model: enriched customer dimension combining staging and intermediate layers
with customers as (

    select * from {{ ref('stg_customers') }}

),

customer_orders as (

    select * from {{ ref('int_customer_orders') }}

),

final as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        coalesce(co.completed_order_count, 0) as completed_order_count,
        coalesce(co.lifetime_value, 0)        as lifetime_value,
        co.first_order_date,
        co.most_recent_order_date
    from customers c
    left join customer_orders co
        on c.customer_id = co.customer_id

)

select * from final
