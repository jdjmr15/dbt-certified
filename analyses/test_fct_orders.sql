with data_ as (
    select * from {{ ref('fct_orders', v=1) }}

)

select * from data_