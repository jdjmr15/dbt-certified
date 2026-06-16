with   
    customers as (
        select *
        from {{ ref('stg_customers') }}
    ),

    orders as (
        select *
        from {{ ref('int_orders') }}
    ),

    customer_orders as (
        select
            orders.*,
            customers.full_name,
            customers.surname,
            customers.givenname,

            min(order_date) over (partition by customers.customer_id) as customer_first_order_date,
            min(valid_order_date) over (partition by customers.customer_id) as customer_first_non_returned_order_date,
            max(valid_order_date) over (partition by customers.customer_id) as customer_most_recent_non_returned_order_date,
            count(*)  over (partition by customers.customer_id) as customer_order_count,
            sum(nvl2(valid_order_date,1,0)) over (partition by customers.customer_id) as customer_non_returned_order_count,
            sum(nvl2(valid_order_date,order_value_dollars,0)) over (partition by customers.customer_id) as customer_total_lifetime_value,
            array_agg(distinct orders.order_id) over (partition by customers.customer_id) as customer_order_ids


        from orders
        inner join customers using (customer_id)
    ),

    customer_average_order_value as (
        select
            *,
            div0null(customer_total_lifetime_value, customer_non_returned_order_count) as customer_avg_non_returned_order_value
        from customer_orders
    )

select * from customer_average_order_value