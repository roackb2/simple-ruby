# frozen_string_literal: true

require 'pg'

# assumes that database 'blog_development' with table 'articles' and columns listed are already created
conn = PG.connect(dbname: 'blog_development')
conn.exec('SELECT * FROM articles') do |result|
  sep = "\t"
  col_names = %w[id title body created_at updated_at status]
  puts col_names.join(sep)
  result.each do |row|
    vals = row.values_at(*col_names)
    puts vals.join(sep)
  end
end
