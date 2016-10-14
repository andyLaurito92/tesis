class Parser

    def initialize
        @lexeme_to_tokenize = nil
        @index_actual_token = 0
        @line_number = 0
        @abstract_syntax_tree = []
    end

    def parse(lexeme_tokenize)
        @lexeme_to_tokenize = lexeme_tokenize
        lookahead_token = get_lookahead
        while lookahead_token
            initial_symbol
            lookahead_token = get_lookahead
        end
        @abstract_syntax_tree
    end

    def initial_symbol
        @abstract_syntax_tree.push 'INITIAL_SYMBOL'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'IDENTIFIER'
            match 'IDENTIFIER'
            match 'ASSIGN'
            network_elem_definition
        when 'INTENT'
            match 'INTENT'
            match 'IDENTIFIER'
            match 'SELECT'
            match 'IDENTIFIER'
            intent_production_with_action
        else
            raise_syntaxis_error "it was suppossed to found either an identifier or an intent, but instead was found #{lookahead_token.value}"
        end
    end

    def intent_production_with_action
        @abstract_syntax_tree.push 'INTENT_PRODUCTION_WITH_ACTION'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'ACTION'
            match 'ACTION'
            match 'IDENTIFIER'
            intent_production_with_condition
        end  
    end

    def intent_production_with_condition
        @abstract_syntax_tree.push 'INTENT_PRODUCTION_WITH_CONDITION'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'CONDITION'
            match 'CONDITION'
            match 'IDENTIFIER'
        end
    end

    def network_elem_definition
        @abstract_syntax_tree.push 'NETWORK_ELEM_DEFINITION'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'HOST'
            match 'HOST'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        when 'LINK'
            match 'LINK'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        when 'DEVICE'
            match 'DEVICE'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        when 'ACTION'
            match 'ACTION'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        when 'FLOW'
            match 'FLOW'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        when 'CONDITION'
            match 'CONDITION'
            match 'LEFT_PARENTHESIS'
            params
            match 'RIGHT_PARENTHESIS'
        else
            raise_syntaxis_error "It was suppossed to found either a Host, or a Link, or a Device, bleh.. but instead #{lookahead_token.value} was found."
        end
    end

    def params
        @abstract_syntax_tree.push 'PARAMS'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'IDENTIFIER'
            match 'IDENTIFIER'
            match 'EQUAL_PARAMETERS'
            second_part_equal
        end
    end

    def second_part_equal
        @abstract_syntax_tree.push 'SECOND_PART_EQUAL'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'DOUBLE_QUOTE'
            match 'DOUBLE_QUOTE'
            match 'IDENTIFIER'
            match 'DOUBLE_QUOTE'
            add_more_parameters
        when 'IDENTIFIER'
            match 'IDENTIFIER'
            add_more_parameters
        when 'LEFT_BRACE'
            match 'LEFT_BRACE'
            elems_of_array
            match 'RIGHT_BRACE'
            add_more_parameters
        else
            raise_syntaxis_error "It was suppossed to found either a \" or [ or and identifier, but instead #{lookahead_token.value} was found."
        end
    end

    def add_more_parameters
        @abstract_syntax_tree.push 'ADD_MORE_PARAMETERS'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'COMMA'
            match 'COMMA'
            params
        end
    end

    def elems_of_array
        @abstract_syntax_tree.push 'ELEMS_OF_ARRAY'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'IDENTIFIER' 
            match 'IDENTIFIER'
            add_more_elements_to_array
        else
            raise_syntaxis_error "It was suppossed to found an identifier inside the array, but instead #{lookahead_token.value} was found."
        end
    end

    def add_more_elements_to_array
        @abstract_syntax_tree.push 'ADD_MORE_ELEMENTS_TO_ARRAY'
        lookahead_token = get_lookahead
        case lookahead_token.keyword
        when 'COMMA' 
            match 'COMMA'
            elems_of_array
        end 
    end

    def get_lookahead
        @lexeme_to_tokenize[@index_actual_token]
    end

    def match(keyword)
       token = @lexeme_to_tokenize[@index_actual_token] 
       if token.keyword == keyword
            @index_actual_token += 1
       else
            raise_syntaxis_error "It was suppossed to match token #{keyword}, but instead #{token.keyword} was found."
       end
       if @lexeme_to_tokenize[@index_actual_token].keyword == 'END_OF_LINE'
            @line_number += 1 
            @index_actual_token += 1
       end
    end

    def raise_syntaxis_error(message)
        raise "A syntactical error was found on line:#{@line_number}. The problem is #{message}\n Please correct this error in order to run the program ;)."
    end
end