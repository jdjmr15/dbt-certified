-- dbt run-operation grant_select

{% macro grant_select (schema=target.schema, role=target.role) %}
    {% set sql %}
        grant usage on schema {{ schema }} to role {{ role }};
        grant select on all tables in schema {{ schema }} to role {{ role }};
        grant select on all views in schema {{ schema }} to role {{ role }};
    {% endset %}

    {{ log("Running sql: " ~ sql, info=true ) }}
    --{% do run_query(sql) %}
    {{ log("Completed sql: " ~ sql, info=true ) }}
{% endmacro %}