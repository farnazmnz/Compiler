 /*compiler project (phase 1)
 
  
  */

%%

%public

%{
  private int comment_count = 0;
%}

%line
%column
%state COMMENT
%unicode

%debug

ALPHA=[A-Za-z]
DIGIT=[\+\-][0-9]|[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
NEWLINE=\r|\n|\r\n
WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+
Reservedword = "EOF"|"compiler"|"dxt.init()"
KEYWORD= "abstract"|"ABSTRACT"|"BOOLEAN"|"boolean"|"break"|"BREAK"|"byte"|"BYTE"|"case"|"CASE"|"catch"|"CATCH"|"char"|"CHAR"|"class"|"CLASS"|"const"|"CONST"
|"continue"|"CONTINUE"|"do"|"DO"|"double"|"DOUBLE"|"else"|"ELSE"|"extends"|"EXTENDS"|"final"|"FINAL"|"finally"|"FINALLY"|"float"|"FLOAT"|"for"|"FOR"|"default"|"DEFAULT"
|"implements"|"IMPLEMENTS"|"import"|"IMPORT"|"instanceof"|"INSTANCEOF"|"int"|"INT"|"interface"|"INTERFACE"|"long"|"LONG"|"native"|"NATIVE"|"new"|"NEW"|"goto"|"GOOTO"
|"if"|"IF"|"public"|"PUBLIC"|"short"|"SHORT"|"super"|"SUPER"|"switch"|"SWITCH"|"synchronized"|"SYNCHRONIZED"|"package"|"PACKAGE"|"private"|"PRIVATE"
|"protected"|"PROTECTED"|"transient"|"TRANSIENT"|"return"|"RETURN"|"void"|"VOID"|"static"|"STATIC"|"while"|"WHILE"|"this"|"THIS"|"throw"|"THROW"
|"throws"|"THROWS"|"try"|"TRY"|"volatile"|"VOLATILE"|"strictfp"|"STRICTFP" 
Ident = {ALPHA}({ALPHA}|{DIGIT}|_)*
FloatLiteral  = ({FLt1}|{FLt2}) 
FLt1    = [\+\-][0-9]+ \. [0-9]* | [0-9]+ \. [0-9]*
FLt2    = [\+\-]\. [0-9]+ | \. [0-9]+
UNARY = ("++"|"--"){Ident} | {Ident}("++"|"--")
BOOLEAN = "true"|"false"|"TRUE"|"FALSE" 
%%

<YYINITIAL> {
  "," { return (new Yytoken(0,yytext(),"Separators",yyline+1,yycolumn+1) ); }
  ":" { return (new Yytoken(1,yytext(),"Separators",yyline+1,yycolumn+1 )); }
  ";" { return (new Yytoken(2,yytext(),"Separators",yyline+1,yycolumn+1)); }
  "(" { return (new Yytoken(3,yytext(),"Separators",yyline+1,yycolumn+1)); }
  ")" { return (new Yytoken(4,yytext(),"Separators",yyline+1,yycolumn+1 )); }
  "[" { return (new Yytoken(5,yytext(),"Separators",yyline+1,yycolumn+1)); }
  "]" { return (new Yytoken(6,yytext(),"Separators",yyline+1,yycolumn+1)); }
  "{" { return (new Yytoken(7,yytext(),"Separators",yyline+1,yycolumn+1 )); }
  "}" { return (new Yytoken(8,yytext(),"Separators",yyline+1,yycolumn+1)); }
  "." { return (new Yytoken(9,yytext(),"Separators",yyline+1,yycolumn+1 )); }
  "+" { return (new Yytoken(10,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  "-" { return (new Yytoken(11,yytext(),"Operators",yyline+1,yycolumn+1)); }
  "*" { return (new Yytoken(12,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  "/" { return (new Yytoken(13,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  "=" { return (new Yytoken(14,yytext(),"Operators",yyline+1,yycolumn+1)); }
  "<>" { return (new Yytoken(15,yytext(),"Separators",yyline+1,yycolumn+1)); }
  "<"  { return (new Yytoken(16,yytext(),"Operators",yyline+1,yycolumn+1)); }
  "<=" { return (new Yytoken(17,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  ">"  { return (new Yytoken(18,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  ">=" { return (new Yytoken(19,yytext(),"Operators",yyline+1,yycolumn+1)); }
  "&&"  { return (new Yytoken(20,yytext(),"Logical Operators",yyline+1,yycolumn+1)); }
  "||"  { return (new Yytoken(21,yytext(),"Logical Operators",yyline+1,yycolumn+1 )); }
  ":=" { return (new Yytoken(22,yytext(),"Operators",yyline+1,yycolumn+1)); }
  "%"  { return (new Yytoken(23,yytext(),"Operators",yyline+1,yycolumn+1 )); }
  
  {NONNEWLINE_WHITE_SPACE_CHAR}+ { }

  "/*" { yybegin(COMMENT); comment_count++; }

  \"{STRING_TEXT}\" {
    String str =  yytext().substring(1,yylength()-1);
    return (new Yytoken(24,str,"String",yyline+1,yycolumn+1 ));
  }

  \"{STRING_TEXT} {
    String str =  yytext().substring(1,yytext().length());
    Utility.error(Utility.E_UNCLOSEDSTR);
    return (new Yytoken(25,str,"String",yyline+1,yycolumn+1));
  }
  
  {DIGIT}+ { return (new Yytoken(26,yytext(),"number",yyline+1,yycolumn+1 )); }

  {FloatLiteral} { return (new Yytoken(27,yytext(),"float number",yyline+1,yycolumn+1 )); } 
  
  {BOOLEAN} { return (new Yytoken(28,yytext(),"Boolean",yyline+1,yycolumn+1 )); } 


  {Reservedword} { 
    String str =  yytext().substring(0,yylength());
    return (new Yytoken(29,str,"Reserved",yyline+1,yycolumn+1 ));
  } 

  {KEYWORD} { 
     String str =  yytext().substring(0,yylength());
     return (new Yytoken(30,str,"KEYWORD",yyline+1,yycolumn+1 ));
     
  } 

  {Ident} { return (new Yytoken(31,yytext(),"Ident",yyline+1,yycolumn+1)); }

  {UNARY}  { return (new Yytoken(32,yytext(),"Incremental/Decremental",yyline+1,yycolumn+1 )); }

}

<COMMENT> {
  "/*" { comment_count++; }
  "*/" { if (--comment_count == 0) yybegin(YYINITIAL); }
  {COMMENT_TEXT} { }
}


{NEWLINE} { }

. {
  System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}

