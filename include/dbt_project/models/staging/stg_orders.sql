-- Staging model: light cleanup of raw order data
with source as (

    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        id           as order_id,
        customer_id,
        order_date,
        amount,
        status
    from source

)

select * from renamed
