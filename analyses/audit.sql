/*
    1. In your project, in the root folder, create a file packages.yml
    Paste the following into the packages.yml file:
    # packages.yml 

    packages:
    - package: dbt-labs/audit_helper
        version: 0.12.2
    
    2. Run dbt deps in the command line

*/

--------------------------------------------------------------
-- Comparo los conteo de filas
---------------------------------------------------------------
{% set old_relation = adapter.get_relation(
      database = target.database,
      schema = target.schema,
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_row_counts(
    a_relation = old_relation,
    b_relation = dbt_relation
) }}
---------------------------------------------------------------


---------------------------------------------------------------
-- Comparo valores de columna
---------------------------------------------------------------

{% set old_relation = adapter.get_relation(
      database = target.database,
      schema = target.schema,
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{% if execute %} 
    {{ audit_helper.compare_all_columns(
        a_relation = old_relation,
        b_relation = dbt_relation,
        primary_key = "order_id"
    ) }}
{% endif %} 
---------------------------------------------------------------