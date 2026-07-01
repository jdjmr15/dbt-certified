{%- set payments_method = ['bank_transfer', 'coupon', 'credit_cart', 'gift_card'] -%}

with payments as (
    select * 
    from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'
)

,pivoted as (
    select 
        order_id,
    {%- for payment_method in payments_method %}
        sum(
                case 
                    when payment_method = '{{ payment_method }}' then payment_amount else 0 
                end
            ) as {{ payment_method }}_amount 
        {%- if not loop.last -%}, {%- endif %}  
    {%- endfor %}
    from payments 
    group by 1
)

select *
from pivoted







