{%- set foods = ['radish', 'cucumber', 'chicken'] -%}

{%- for food in foods %}
    {%- if food == 'chicken' -%}
        {%- set food_type = 'snack' -%}
    {%- else -%}
        {%- set food_type = 'vegetable' -%}
    {% endif %}
    The delicious {{ food }} is my favorite {{ food_type }}
{%- endfor %}