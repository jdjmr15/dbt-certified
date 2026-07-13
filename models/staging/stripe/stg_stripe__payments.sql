with 

source as (
    select * from {{ source('stripe', 'payment') }}
),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        amount as payment_amount,
        {{ cents_to_dollars("amount", 3) }} as amount_cents,
        created as payment_created,
        _batched_at

    from source

)

select * from renamed