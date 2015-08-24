module Sequel
  module Postgres

    def self.json_parse(s)
      JSON.parse s
    end

    PG_TYPES = {} unless defined?(PG_TYPES)

    PG_TYPES[114] = self.method(:json_parse)

    Sequel::Model.db.reset_conversion_procs

    #Sequel::Model.db.
    #
    #def fetch_rows_set_cols(res)
    #  cols = []
    #  procs = db.conversion_procs
    #  res.nfields.times do |fieldnum|
    #    p res.ftype(fieldnum)
    #    cols << [fieldnum, procs[res.ftype(fieldnum)], output_identifier(res.fname(fieldnum))]
    #  end
    #  @columns = cols.map { |c| c.at(2) }
    #  cols
    #end


  end
end
