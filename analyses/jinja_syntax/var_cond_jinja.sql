{% set temperature = 80.0 %}                                              -- En el contexto del jinja es una variable

{% if temperature > 70 %}
    Limonada
{% else %}
    Chocalete
{% endif %}




