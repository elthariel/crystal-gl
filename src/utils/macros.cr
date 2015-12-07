# Helpers macros

# macro import_const(libname, keyword, prefix, *consts)
#   {% for c, index in consts %}
#     {{keyword.id}} {{prefix.id}}{{c.id}} = {{libname.id}}::{{prefix.id}}{{c.id}}
#   {% end %}
# end

# Import functions from a lib/module to the current module
macro import_fun(libname, *functions)
  {% for f, index in functions %}
    @[AlwaysInline]
    def self.{{f.id}}(*args)
      {{libname.id}}.{{f.id}}(*args)
    end
  {% end %}
end

macro import_fun_out(libname, func, tuple, return_value, args)
  @[AlwaysInline]
  def self.{{func.id}}(
       {% for key, value in args %}
         {% if !value %}
           {{key.id}},
         {% end %}
       {% end %}
     )
    result = {{libname}}.{{func}}(
      {% for key, value in args %}
        {% if value %}
          out
        {% end %}
        {{key.id}},
      {% end %}
    )

    {% if tuple %} { {% end %}
      {% if return_value %}
        result {% if tuple %},{% end %}
      {% end %}
      {% for key, value in args %}
        {% if value %}
          {{key.id}} {% if tuple %},{% end %}
        {% end %}
      {% end %}
    {% if tuple %} } {% end %}
  end
end
