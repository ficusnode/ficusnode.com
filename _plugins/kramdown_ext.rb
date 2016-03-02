# Tweak the Kramdown::Converter::Base#generate_id
# Enable all charaters unless space in header ID

require "kramdown"

module Kramdown
  module Converter
    class Base
      def generate_id(str)
        gen_id = str
        gen_id.tr!(' ', '-')
        gen_id.downcase!
        gen_id = 'section' if gen_id.length == 0
        @used_ids ||= {}
        if @used_ids.has_key?(gen_id)
          gen_id += '-' << (@used_ids[gen_id] += 1).to_s
        else
          @used_ids[gen_id] = 0
        end
        @options[:auto_id_prefix] + gen_id
      end
    end
  end
end
