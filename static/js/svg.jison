%lex

%%

\s+                             /*skip whitespace*/
"svg"                           return 'SVG';
("rect"|"line"|"circle"|"path") return 'SHAPE';
"show"                          return 'SHOW';
[a-zA-Z_][a-zA-Z_0-9]*          return 'IDENTIFIER';
["]([^"\\\n]|\\.|\\\n)*["]      return 'STRING';
("-")?[0-9]+(\.[0-9]+)?         return 'NUMBER';
":="                            return 'ASSIGN';
("+"|"-"|"*"|"/")               return 'BIN_OP';
"("                             return '(';
")"                             return ')';
"="                             return '=';
","                             return ',';
":"                             return ':';
";"                             return ';';
"{"                             return '{';
"}"                             return '}';
"["                             return '[';
"]"                             return ']';
<<EOF>>                         return 'EOF';

/lex

%start program

%%

program
    : statements EOF {
        code.push([""]);
        let new_script = document.createElement("script");
        new_script.innerHTML = code.map(
            e => e.join(" ")
        ).join("\n");
        document.body.appendChild(new_script);
        return "";
    };

statements
    : statement ';'
    | statements statement ';'
    ;

statement
    : identifier ASSIGN expression {
        code.push(["let", $1, "=", $3]);
    }| SHOW expression {
        code.push(["document.getElementById(\""+reuse+"\").outerHTML = ", $2]);
    };

expression
    : html_exp {
        let toHTML = (t) => {
            let attr_str = Object.keys(t.attributes).map(k => {
                if ( typeof t.attributes[k] === 'string'
                  || t.attributes[k] instanceof String ) {
                    return k+"="+t.attributes[k];
                } else if ( typeof t.attributes[k] === 'number'
                  || t.attributes[k] instanceof Number ) {
                    return k+"=\""+t.attributes[k]+"\"";
                } else {
                    let p = t.attributes[k];
                    let res = k+"=\"M "+p[0][0]+" "+p[0][1];
                    for (let i=1;i<p.length;i+=2) {
                        res += " Q "+p[i][0]+" "+p[i][1];
                        res += " "+p[i+1][0]+" "+p[i+1][1];
                    }
                    res += "\"";
                    return res;
                }
            }).reduce((acc, elem) => acc + " " + elem, "");
            let child_str = t.children.map(toHTML).reduce(
                (acc, elem) => acc + "\n" + elem, "\n");
            if (t.tag === "svg" )
                return "<"+t.tag+" "+attr_str+">"+child_str+"</"+t.tag+">";
            else
                return "<"+t.tag+" "+attr_str+"/>"+child_str;
        };
        $$ = toHTML($1);
    }| expression bin_op primary_expression {
        $$ = $1 + $2 + $3;
    }| primary_expression {
        $$ = $1;
    };

primary_expression
    : const {
        $$ = $1;
    }| '(' expression ')' {
        $$ = $2;
    }| identifier {
        $$ = "\"+"+$1+"+\"";
    };

html_exp
    : node {
        $$ = $1;
    }| node '{' children '}' {
        $1.children = $1.children.concat($3);
        $$ = $1;
    };

children
    : edge ':' html_exp {
        let transform1 = (t) => {
            if (t.tag === "rect") {
                t.attributes.x += $1[0];
                t.attributes.y += $1[1];
            } else if (t.tag === "line") {
                t.attributes.x1 += $1[0];
                t.attributes.y1 += $1[1];
                t.attributes.x2 += $1[0];
                t.attributes.y2 += $1[1];
            } else if (t.tag === "circle") {
                t.attributes.cx += $1[0];
                t.attributes.cy += $1[1];
            } else if (t.tag === "path") {
                t.attributes.d = t.attributes.d.map(
                    e => [e[0]+$1[0], e[1]+$1[1]]
                );
            }
            t.children = t.children.map(transform1);
            return t;
        };
        $$ = [transform1($3)];
    }| children ',' edge ':' html_exp {
        let transform2 = (t) => {
            if (t.tag === "rect") {
                t.attributes.x += $3[0];
                t.attributes.y += $3[1];
            } else if (t.tag === "line") {
                t.attributes.x1 += $3[0];
                t.attributes.y1 += $3[1];
                t.attributes.x2 += $3[0];
                t.attributes.y2 += $3[1];
            } else if (t.tag === "circle") {
                t.attributes.cx += $3[0];
                t.attributes.cy += $3[1];
            } else if (t.tag === "path") {
                t.attributes.d = t.attributes.d.map(
                    e => [e[0]+$3[0], e[1]+$3[1]]
                );
            }
            t.children = t.children.map(transform2);
            return t;
        };
        $$ = $1;
        $$.push(transform2($5));
    };

node
    : SVG '(' attributes ')' {
        $$ = {
            tag: "svg",
            attributes: {
                xmlns: "http://www.w3.org/2000/svg",
                width: "100%",
                viewBox: "\"0 0 " + $3.width + " " + $3.height+"\""
            },
            children: []
        };
    }| shape '(' attributes ')' {
        $$ = {
            tag: $1,
            attributes: $3,
            children: []
        };
    };

shape
    : SHAPE {
        $$ = yytext;
    };

edge
    : expression {
        $$ = $1;
    };

attributes
    : identifier '=' expression {
        $$ = {};
        $$[$1] = $3;
    }| attributes ',' identifier '=' expression {
        $$ = $1;
        $$[$3] = $5;
    };

/*multiplicative_exp
    : additive_exp '*' additive_exp
    | additive_exp '/' additive_exp
    | additive_exp
    ;

additive_exp
    : numeric_exp '+' numeric_exp
    | numeric_exp '-' numeric_exp
    | numeric_exp
    ;

numeric_exp
    : NUMBER
    | identifier
    ;*/

bin_op
    : BIN_OP {
        $$ = yytext;
    };

identifier
    : IDENTIFIER {
        $$ = yytext;
    };

const
    : NUMBER {
        $$ = Number(yytext);
    }| STRING {
        $$ = yytext;
    }| '(' ')' {
        $$ = [];
    }| '(' expression ',' ')' {
        $$ = [$2];
    }| '(' exp_list ')' {
        $$ = $2;
    };

exp_list
    : expression ',' expression {
        $$ = [$1, $3];
    }| exp_list ',' expression {
        $$ = $1;
        $$.push($3);
    };