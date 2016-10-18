class CodeGenerator
    def generate_code(context, destiny)
        @identifiers = context['identifiers']
        @intents = context['intents']
        
        require_relative "code_generators/#{destiny.downcase}_code_generator.rb"
        self.class.send(:include, Object.const_get("#{destiny.capitalize}CodeGenerator"))
        generate_output
    end

end