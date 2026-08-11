-- Intermediate model: aggregates completed orders per customer
with orders as (

    select * from {{ ref('stg_orders') }}
    where status = 'completed'

),

aggregated as (

    select
        customer_id,
        count(*)          as completed_order_count,
        sum(amount)       as lifetime_value,
        min(order_date)   as first_order_date,
        max(order_date)   as most_recent_order_date
    from orders
    group by 1

)

select * from aggregated
