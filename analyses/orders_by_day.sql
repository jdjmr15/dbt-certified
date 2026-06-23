With orders as
(
    Select * from {{ ref('stg_orders') }}
)
, daily as
(
    Select order_date,
    count(*) as order_num,
    {% for order_status in ['returned','completed','return_pending'] %}
        sum(case when order_status = '{{ order_status }}' then 1 else 0 end) as {{ order_status }}_total {% if not loop.last %},{% endif %}
    {% endfor %}
    From orders
    Group by 1
)

, Compared as
(
    Select *, lag(order_num) over (order by order_date) as prev_day_orders
    From daily
)

select * from Compared