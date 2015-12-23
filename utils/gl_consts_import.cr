
CONST_REGEXP = /^\s*#define\s+GL_(\w+)\s+0x([0-9a-fA-F]+)/
COMMENT_REGEXP = /\/\* (.*) \*\//

NUMBER_TO_LETTER = {
  '1' => "ONE",
  '2' => "TWO",
  '3' => "THREE",
  '4' => "FOUR",
}
def map_const_name(name)
  if NUMBER_TO_LETTER.has_key? name[0]
    NUMBER_TO_LETTER[name[0]] + name[1..-1]
  else
    name
  end
end

def map_const_value(value)
  if value.size > 8
    "0x#{value}_u64"
  else
    "0x#{value}_u32"
  end
end

if ARGV.size == 0
  puts "Usage: gl_const_import path/to/gl.h [...]"
  exit 1
end

output = [
  "# This file has been generated with gl_consts_imports.cr",
  "# DO NOT EDIT !", "",
  "module GL"
]
comment = nil
last_line_empty = false

ARGV.each do |path|
  output << "  #----------------------------------------------------"
  output << "  # Imported from #{File.basename path}"
  output << "  #----------------------------------------------------"
  output << "" << ""

  lines = File.read_lines(path)
  lines.each do |line|
    if line.strip == ""
      output << "" unless last_line_empty
      last_line_empty = true
    end

    md = COMMENT_REGEXP.match(line)
    if md
      comment = md[1]
    end

    md = CONST_REGEXP.match(line)
    if md
      if comment
        output << "  # #{comment}"
        comment = nil
      end
      const = "  #{map_const_name md[1]} = #{map_const_value md[2]}"
      unless output.index(const)
        output << const
        last_line_empty = false
      end
    end
  end
end

output.each { |line| puts line }

puts "end"
