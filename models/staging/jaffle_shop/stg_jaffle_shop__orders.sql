with 

order_table AS (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status as order_status
    from {{ source('jaffle_shop', 'orders') }}

)


select
    order_id,
    customer_id,
    order_date,
    order_status
from order_table
