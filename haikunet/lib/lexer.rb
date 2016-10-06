require 'byebug'
require_relative 'token.rb'
require_relative 'keywords.rb'

class Lexer
    include Keywords
	attr_reader :current_token, :program_lexeme, :tokens_table

	def initialize(program_lexeme)
		@program_lexeme = program_lexeme
        @program_lexeme_lines = @program_lexeme.gsub(/\r\n?/, "\n")
        @tokens = []
        @line_to_tokenize = ''
        @line_number = 0
        @current_index = 0
	end

    def tokenize_lexeme
        @line_number = 0
        @program_lexeme_lines.each_line do |line|
            @line_to_tokenize = line
            while @line_to_tokenize.size > @current_index
                byebug
                @tokens.push get_next_token
            end
            @line_number += 1
        end
    end

    def get_next_token
        current_read_entry = ''
        while not (is_a_token? current_read_entry)
            raise StandardError, "In line number #{@line_number}: No token could be found in the program, please correct the syntax error." if @current_index >= @line_number.size
            current_read_entry += read_one_more_character
        end
        keyword = is_a_token? current_read_entry
        Token.new keyword, current_read_entry
    end

    def read_one_more_character
        next_character = ' '
        while next_character == ' '
            next_character = @line_to_tokenize[@current_index]
            @current_index += 1
        end
        next_character
    end

    def is_a_token?(current_read_line)
        keywords_list.each do |keyword, regex|
            current_read_line_scaned = current_read_line.scan regex
            return keyword if (current_read_line_scaned.size > 0) && current_read_line_scaned.first == current_read_line
        end
        false
    end
end