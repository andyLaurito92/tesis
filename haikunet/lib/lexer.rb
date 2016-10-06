require 'byebug'
require_relative 'tokens.rb'
require_relative 'keywords.rb'

class Lexer
    include Keywords
	attr_reader :current_token, :program_lexeme, :tokens_table

	def initialize(program_lexeme)
		@program_lexeme = program_lexeme
        @program_lexeme_lines = @program_lexeme.gsub(/\r\n?/, "\n")
        @tokens = []
	end

    def tokenize_lexeme
        line_number = 0
        @program_lexeme_lines.each_line do |line|
            line_to_tokenize = line
            @tokens.push (get_next_token line_to_tokenize, line_number) while line_to_tokenize.size > 0
            line_number += 1
        end
    end

    def get_next_token(line_to_tokenize, line_number)
        current_read_entry = ''
        current_index = 0
        while not (is_a_token? current_read_entry)
            current_read_entry += line_to_tokenize[current_index]
        end
    end

    def is_a_token?(current_read_line)
        @keywords.each do |keyword, regex|
            current_read_line.scan regex
        end
    end

    def save_token(token)
        @tokens_table['token':token,  }
    end
end