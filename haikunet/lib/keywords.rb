module Keywords
    @keywords = {}    
    @keywords['IDENTIFIER'] = /[A-Za-z0-9_-]+/
    @keywords['INTENT'] = /\bintent\b/i
    @keywords['SELECT'] = /\bselect\b/i
    @keywords['ACTION'] = /\baction\b/i
    @keywords['CONDITION'] = /\bcondition\b/i
    @keywords['HOST'] = /\bhost\b/i
    @keywords['LINK'] = /\blink\b/i
    @keywords['DEVICE'] = /\bdevice\b/i
    @keywords['FLOW'] = /\bflow\b/i
    @keywords[':='] = ':='
    @keywords['='] = '='
    @keywords['('] = '('
    @keywords[')'] = ')'
end