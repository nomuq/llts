language ts(go);

lang = "ts"
package = "github.com/satishbabariya/llts"
eventBased = true
eventFields = true
eventAST = true
fileNode = "Module"
cancellable = true
recursiveLookaheads = true
reportTokens = [MultiLineComment, SingleLineComment, invalid_token]
extraTypes = ["InsertedSemicolon"]

:: lexer

# Accept end-of-input in all states.
<*> eoi: /{eoi}/

invalid_token:
error:

# LineTerminatorSequence
WhiteSpace: /[\n\r\u2028\u2029]|\r\n/ (space)

commentChars = /([^*]|\*+[^*\/])*\**/
MultiLineComment:  /\/\*{commentChars}\*\//     (space)
# Note: the following rule disables backtracking for incomplete multiline comments, which
# would otherwise be reported as '/', '*', etc.
invalid_token: /\/\*{commentChars}/
SingleLineComment: /\/\/[^\n\r\u2028\u2029]*/   (space)

# Shebang.
SingleLineComment: /#![^\n\r\u2028\u2029]*/   (space)

# Note: see http://unicode.org/reports/tr31/
IDStart = /\p{Lu}|\p{Ll}|\p{Lt}|\p{Lm}|\p{Lo}|\p{Nl}/
IDContinue = /{IDStart}|\p{Mn}|\p{Mc}|\p{Nd}|\p{Pc}/
JoinControl = /\u200c|\u200d/

hex = /[0-9a-fA-F]/
unicodeEscapeSequence = /u(\{{hex}+\}|{hex}{4})/
brokenEscapeSequence = /\\(u({hex}{0,3}|\{{hex}*))?/

identifierStart = /{IDStart}|$|_|\\{unicodeEscapeSequence}/
identifierPart =  /{identifierStart}|{IDContinue}|{JoinControl}/

Identifier: /{identifierStart}{identifierPart}*/    (class)
PrivateIdentifier: /#{identifierStart}{identifierPart}*/
# Note: the following rule disables backtracking for incomplete identifiers.
invalid_token: /#?({identifierStart}{identifierPart}*)?{brokenEscapeSequence}/

# Keywords.
'await':      /await/
'break':      /break/
'case':       /case/
'catch':      /catch/
'class':      /class/
'const':      /const/
'continue':   /continue/
'debugger':   /debugger/
'default':    /default/
'delete':     /delete/
'do':         /do/
'else':       /else/
'export':     /export/
'extends':    /extends/
'finally':    /finally/
'for':        /for/
'function':   /function/
'if':         /if/
'import':     /import/
'in':         /in/
'instanceof': /instanceof/
'new':        /new/
'return':     /return/
'super':      /super/
'switch':     /switch/
'this':       /this/
'throw':      /throw/
'try':        /try/
'typeof':     /typeof/
'var':        /var/
'void':       /void/
'while':      /while/
'with':       /with/
'yield':      /yield/

# Future-reserved.
'enum':  /enum/

# Literals.
'null':  /null/
'true':  /true/
'false': /false/

# Soft (contextual) keywords.
'as':      /as/
'asserts': /asserts/
'async':   /async/
'from':    /from/
'get':     /get/
'let':     /let/
'of':      /of/
'set':     /set/
'static':  /static/
'target':  /target/

# Strict mode keywords:
#   implements interface package private protected public

# Typescript. A.0 Keywords

# The following keywords cannot be used as identifiers in strict mode code, but
# are otherwise not restricted:
'implements':   /implements/
'interface':    /interface/
'private':      /private/
'protected':    /protected/
'public':       /public/

# The following keywords cannot be used as user defined type names, but are
# otherwise not restricted:
'any':     /any/
'unknown': /unknown/
'boolean': /boolean/
'number':  /number/
'string':  /string/
'symbol':  /symbol/

# The following keywords have special meaning in certain contexts, but are
# valid identifiers:
'abstract':    /abstract/
'constructor': /constructor/
'declare':     /declare/
'global':      /global/
'is':          /is/
'module':      /module/
'namespace':   /namespace/
'require':     /require/
'type':        /type/

# Typescript 2.0+
'readonly': /readonly/
'keyof': /keyof/
'unique': /unique/
'infer': /infer/

# End of typescript keywords.

# Punctuation
'{': /\{/
'}':          /* See below */
'(': /\(/
')': /\)/
'[': /\[/
']': /\]/
'.': /\./
invalid_token: /\.\./
'...': /\.\.\./
';': /;/
',': /,/
'<': /</
'>': />/
'<=': /<=/
'>=': />=/
'==': /==/
'!=': /!=/
'===': /===/
'!==': /!==/
'@': /@/
'+': /\+/
'-': /-/
'*': /\*/
'/':          /* See below */
'%': /%/
'++': /\+\+/
'--': /--/
'<<': /<</
'>>': />>/
'>>>': />>>/
'&': /&/
'|': /\|/
'^': /^/
'!': /!/
'~': /~/
'&&': /&&/
'||': /\|\|/
'?': /\?/
'??': /\?\?/
invalid_token: /\?\.[0-9]/   { l.rewind(l.tokenOffset+1); token = QUEST }
'?.': /\?\./
':': /:/
'=': /=/
'+=': /\+=/
'-=': /-=/
'*=': /\*=/
'/=':         /* See below */
'%=': /%=/
'<<=': /<<=/
'>>=': />>=/
'>>>=': />>>=/
'&=': /&=/
'|=': /\|=/
'^=': /^=/
'=>': /=>/
'**': /\*\*/
'**=': /\*\*=/

# Numeric literals starting with zero in V8:
#   00000 == 0, 00001 = 1, 00.0 => error
#   055 == 45, 099 == 99
#   09.5 == 9.5, 059.5 == 59.5, 05.5 => error, 05.9 => error

int = /(0+(([1-7](_*{oct})*_*)?[89](_*[0-9])*)?|[1-9](_*[0-9])*)/
frac = /\.([0-9](_*[0-9])*)?/
exp = /[eE][+-]?[0-9](_*[0-9])*/
bad_exp = /[eE][+-]?([0-9](_*[0-9])*_+)?/
oct = /[0-7]/
NumericLiteral: /{int}{frac}?{exp}?/
NumericLiteral: /\.[0-9](_*[0-9])*{exp}?/
NumericLiteral: /0[xX]{hex}(_*{hex})*/
NumericLiteral: /0[oO]{oct}(_*{oct})*/
NumericLiteral: /0+[1-7](_*{oct})*/
NumericLiteral: /0[bB][01](_*[01])*/

invalid_token: /0[xXbBoO]/
invalid_token: /0[xX]{hex}(_*{hex})*_+/
invalid_token: /0[oO]{oct}(_*{oct})*_+([89a-fA-F][0-9a-fA-F_]*)?/
invalid_token: /0[bB][01](_*[01])*_+([2-9a-fA-F][0-9a-fA-F_]*)?/
invalid_token: /{int}{frac}?({bad_exp}|_+)|0+_+[0-9a-fA-F_]*|{int}_+{frac}_*({exp}|{bad_exp})?/
invalid_token: /\.[0-9](_*[0-9])*({bad_exp}|_+)/
invalid_token: /0+[1-7](_*{oct})*_+/

escape = /\\([^1-9xu\n\r\u2028\u2029]|x{hex}{2}|{unicodeEscapeSequence})/
lineCont = /\\([\n\r\u2028\u2029]|\r\n)/
dsChar = /[^\n\r"\\\u2028\u2029]|{escape}|{lineCont}/
ssChar = /[^\n\r'\\\u2028\u2029]|{escape}|{lineCont}/

# TODO check \0 is valid if [lookahead != DecimalDigit]

StringLiteral: /"{dsChar}*"/
StringLiteral: /'{ssChar}*'/

# For precedence resolution.
resolveShift:





:: parser

%input Module;

%assert empty set(follow error & ~('}' | ')' | ',' | ';' | ']'));

%generate afterErr = set(follow error);
%generate beforeSemi = set(precede ';');

%flag In;
%flag Yield;
%flag Await;
%flag NoAsync = false;

%flag WithoutNew = false;
%flag WithoutAsserts = false;
%flag WithoutKeywords = false;
%flag WithoutPredefinedTypes = false;
%flag WithoutImplements = false;
%flag WithoutFrom = false;

%lookahead flag NoLet = false;
%lookahead flag NoLetSq = false;
%lookahead flag NoObjLiteral = false;
%lookahead flag NoFuncClass = false;
%lookahead flag NoAs = false;
%lookahead flag StartWithLet = false;

SyntaxError -> SyntaxProblem :
    error ;

IdentifierName<WithoutNew, WithoutAsserts, WithoutKeywords, WithoutFrom> :
    Identifier

# Keywords
  | [!WithoutNew] 'new'
  | [!WithoutAsserts] 'asserts'
  | [!WithoutKeywords] ('await'
    | 'break'      | 'do'         | 'in'         | 'typeof'
    | 'case'       | 'else'       | 'instanceof' | 'var'
    | 'catch'      | 'export'     | 'void'
    | 'class'      | 'extends'    | 'return'     | 'while'
    | 'const'      | 'finally'    | 'super'      | 'with'
    | 'continue'   | 'for'        | 'switch'     | 'yield'
    | 'debugger'   | 'function'   | 'this'
    | 'default'    | 'if'         | 'throw'
    | 'delete'     | 'import'     | 'try'

    # Future-reserved.
    | 'enum'

    # NullLiteral | BooleanLiteral
    | 'null' | 'true' | 'false')

  # Soft keywords
  | 'as' | [!WithoutFrom] 'from' | 'get' | 'let' | 'of' | 'set' | 'static' | 'target' | 'async'

  # Typescript.
  | 'implements' | 'interface' | 'private' | 'protected' | 'public'
  | 'any' | 'unknown' | 'boolean' | 'number' | 'string' | 'symbol'
  | 'abstract' | 'constructor' | 'declare' | 'is' | 'module' | 'namespace' | 'require' | 'type' | 'global'
  | 'readonly' | 'keyof' | 'unique' | 'infer'
;

IdentifierNameDecl<WithoutNew> -> NameIdent:
    IdentifierName ;

IdentifierNameRef<WithoutAsserts> -> ReferenceIdent :
    IdentifierName ;

ClassPrivateRef -> ReferenceIdent:
    PrivateIdentifier ;

# A.2 Expressions

IdentifierReference<Yield, Await, NoAsync, WithoutPredefinedTypes> -> ReferenceIdent :
# V8 runtime functions start with a percent sign.
# See http://stackoverflow.com/questions/11202824/what-is-in-javascript
    '%'? Identifier
  | [!Yield] 'yield'
  | [!Await] 'await'
  | [!NoLet] 'let'
  | [!NoAsync] 'async' (?= !StartOfArrowFunction)

  # Soft keywords
  | 'as' | 'asserts' | 'from' | 'get' | 'of' | 'set' | 'static' | 'target'

  # Typescript.
  | 'implements' | 'interface' | 'private' | 'protected' | 'public'
  | [!WithoutPredefinedTypes] ('any' | 'unknown' | 'boolean' | 'number' | 'string' | 'symbol')
  | 'abstract' | 'constructor' | 'declare' | 'is' | 'module' | 'namespace' | 'require' | 'type' | 'global'
  | [!WithoutPredefinedTypes] ('keyof' | 'unique' | 'readonly' | 'infer')
;

BindingIdentifier<WithoutImplements> -> NameIdent :
    Identifier

  # These are allowed or not, depending on the context.
  | 'yield' | 'await'

  # Soft keywords
  | 'as' | 'asserts' | 'from' | 'get' | 'let' | 'of' | 'set' | 'static' | 'target' | 'async'

  # Typescript.
  | [!WithoutImplements] 'implements'
  | 'interface' | 'private' | 'protected' | 'public'
  | 'any' | 'unknown' | 'boolean' | 'number' | 'string' | 'symbol'
  | 'abstract' | 'constructor' | 'declare' | 'is' | 'module' | 'namespace' | 'require' | 'type' | 'global'
  | 'readonly' | 'keyof' | 'unique' | 'infer'
;

LabelIdentifier -> LabelIdent :
    Identifier

  # These are allowed or not, depending on the context.
  | 'yield' | 'await'

  # Soft keywords
  | 'as' | 'asserts' | 'from' | 'get' | 'let' | 'of' | 'set' | 'static' | 'target' | 'async'

  # Typescript.
  | 'implements' | 'interface' | 'private' | 'protected' | 'public'
  | 'any' | 'unknown' | 'boolean' | 'number' | 'string' | 'symbol'
  | 'abstract' | 'constructor' | 'declare' | 'is' | 'module' | 'namespace' | 'require' | 'type' | 'global'
  | 'readonly' | 'keyof' | 'unique' | 'infer'
;

PrimaryExpression<Yield, Await, NoAsync> -> Expr /* interface */:
    'this'                                                 -> This
  | IdentifierReference                                    -> IdentExpr
  | Literal
  | ArrayLiteral
  | [!NoObjLiteral] ObjectLiteral
  | [!NoFuncClass] FunctionExpression
  | [!NoFuncClass] ClassExpression
  | [!NoFuncClass] GeneratorExpression
  | [!NoFuncClass] AsyncFunctionExpression
  | (?= !StartOfArrowFunction) Parenthesized
;

Parenthesized<Yield, Await> -> Parenthesized:
    '(' Expression<+In> ')'
  | '(' SyntaxError ')'
;


Literal -> Literal :
    'null'
  | 'true'
  | 'false'
  | NumericLiteral
  | StringLiteral
;

ArrayLiteral<Yield, Await> -> ArrayLiteral :
    '[' Elisionopt ']'
  | '[' ElementList ']'
  | '[' ElementList ',' Elisionopt ']'
;

ElementList<Yield, Await> :
    Elisionopt list+=AssignmentExpression<+In>
  | Elisionopt list+=SpreadElement
  | ElementList ',' Elisionopt list+=AssignmentExpression<+In>
  | ElementList ',' Elisionopt list+=SpreadElement
;

Elision :
    list+=(',' -> NoElement as Expr)
  | Elision list+=(',' -> NoElement as Expr)
;

SpreadElement<Yield, Await> -> Expr /* interface */:
    '...' AssignmentExpression<+In>   -> SpreadElement
;

ObjectLiteral<Yield, Await> -> ObjectLiteral :
    '{' '}'
  | '{' .recoveryScope PropertyDefinitionList '}'
  | '{' .recoveryScope PropertyDefinitionList ',' '}'
;

PropertyDefinitionList<Yield, Await> :
    PropertyDefinition
  | PropertyDefinitionList ',' PropertyDefinition
;

%interface PropertyName, PropertyDefinition;

PropertyDefinition<Yield, Await> -> PropertyDefinition /* interface */:
    IdentifierReference                                   -> ShorthandProperty
  | Modifiers? PropertyName ':' value=AssignmentExpression<+In>      -> Property
  | Modifiers? MethodDefinition                           -> ObjectMethod
  | CoverInitializedName                                  -> SyntaxProblem
  | SyntaxError
  | '...' AssignmentExpression<+In>                       -> SpreadProperty
;

PropertyName<Yield, Await, WithoutNew> -> PropertyName /* interface */:
    LiteralPropertyName
  | ComputedPropertyName
;

LiteralPropertyName<WithoutNew> -> LiteralPropertyName :
    IdentifierNameDecl
  | (PrivateIdentifier -> NameIdent)
  | StringLiteral
  | NumericLiteral
;

ComputedPropertyName<Yield, Await> -> ComputedPropertyName :
    '[' AssignmentExpression<+In> ']' ;

CoverInitializedName<Yield, Await> :
    IdentifierReference Initializer<+In> ;

Initializer<In, Yield, Await> -> Initializer :
    '=' AssignmentExpression
;


MemberExpression<Yield, Await, NoAsync, flag NoLetOnly = false> -> Expr /* interface */:
    [!NoLetOnly && !StartWithLet] PrimaryExpression
  | [NoLetOnly && !StartWithLet] PrimaryExpression<+NoLet>
  | [StartWithLet && !NoLetOnly] ('let' -> ReferenceIdent) -> IdentExpr
  | [StartWithLet] expr=MemberExpression<+NoLetOnly, ~NoAsync> '[' index=Expression<+In> ']'            -> IndexAccess
  | [!StartWithLet] expr=MemberExpression<NoLetOnly: NoLetSq, ~NoAsync> '[' index=Expression<+In> ']'   -> IndexAccess
  | expr=MemberExpression<~NoAsync> '.' selector=IdentifierNameRef        -> PropertyAccess
  | expr=MemberExpression<~NoAsync> '.' selector=ClassPrivateRef          -> PropertyAccess
  | expr=MemberExpression<~NoAsync> .noLineBreak '!'                      -> TsNonNull
  | [!StartWithLet] SuperProperty
  | [!StartWithLet] MetaProperty
  | [!StartWithLet] 'new' expr=MemberExpression<~NoAsync> Arguments       -> NewExpr
;

SuperExpression -> Expr /* interface */:
    'super' -> SuperExpr
;

SuperProperty<Yield, Await> -> Expr /* interface */:
    expr=SuperExpression '[' index=Expression<+In> ']'          -> IndexAccess
  | expr=SuperExpression '.' selector=IdentifierNameRef         -> PropertyAccess
;

MetaProperty :
    NewTarget ;

NewTarget -> NewTarget :
    'new' '.' 'target' ;

NewExpression<Yield, Await, NoAsync> -> Expr /* interface */:
    MemberExpression  (?= !StartOfParametrizedCall)
  | [!StartWithLet] 'new' expr=NewExpression<~NoAsync>      -> NewExpr
;

CallExpression<Yield, Await> -> Expr /* interface */:
    expr=MemberExpression Arguments                             -> CallExpr
  | [!StartWithLet] SuperCall                                   -> CallExpr
  | [!StartWithLet] 'import' Arguments                          -> TsDynamicImport
  | expr=CallExpression Arguments                               -> CallExpr
  | expr=CallExpression '[' index=Expression<+In> ']'           -> IndexAccess
  | expr=CallExpression '.' selector=IdentifierNameRef          -> PropertyAccess
  | expr=CallExpression '.' selector=ClassPrivateRef            -> PropertyAccess
  | expr=CallExpression .noLineBreak '!'                        -> TsNonNull
;

SuperCall<Yield, Await> :
    expr=SuperExpression Arguments
;

Arguments<Yield, Await> -> Arguments :
    (?= StartOfParametrizedCall) TypeArguments '(' (list=ArgumentList ','?)? ')'
  | '(' (list=ArgumentList ','?)? ')'
;

StartOfParametrizedCall:
    TypeArguments '(' ;

ArgumentList<Yield, Await> :
    AssignmentExpression<+In>
  | SpreadElement
  | ArgumentList ',' AssignmentExpression<+In>
  | ArgumentList ',' SpreadElement
;

OptionalLHS<Yield, Await> :
    MemberExpression  | CallExpression | OptionalExpression ;

OptionalExpression<Yield, Await> -> Expr /* interface */:
    expr=OptionalLHS '?.' '[' index=Expression<+In> ']'      -> OptionalIndexAccess
  | expr=OptionalLHS '?.' selector=IdentifierNameRef         -> OptionalPropertyAccess
  | expr=OptionalLHS '?.' selector=ClassPrivateRef           -> OptionalPropertyAccess
  | expr=OptionalLHS '?.' Arguments                          -> OptionalCallExpr
  | expr=OptionalExpression '[' index=Expression<+In> ']'    -> IndexAccess
  | expr=OptionalExpression '.' selector=IdentifierNameRef   -> PropertyAccess
  | expr=OptionalExpression '.' selector=ClassPrivateRef     -> PropertyAccess
  | expr=OptionalExpression Arguments                        -> CallExpr
  | expr=OptionalExpression .noLineBreak '!'                 -> TsNonNull
;

LeftHandSideExpression<Yield, Await, NoAsync> -> Expr /* interface */:
    NewExpression
  | CallExpression (?= !StartOfParametrizedCall)
  | OptionalExpression (?= !StartOfParametrizedCall)
;

UpdateExpression<Yield, Await> -> Expr /* interface */:
    LeftHandSideExpression
  | LeftHandSideExpression .noLineBreak '++'          -> PostInc
  | LeftHandSideExpression .noLineBreak '--'          -> PostDec
  | [!StartWithLet] '++' UnaryExpression              -> PreInc
  | [!StartWithLet] '--' UnaryExpression              -> PreDec
;

UnaryExpression<Yield, Await> -> Expr /* interface */:
    UpdateExpression
  | [!StartWithLet] 'delete' UnaryExpression          -> UnaryExpr
  | [!StartWithLet] 'void' UnaryExpression            -> UnaryExpr
  | [!StartWithLet] 'typeof' UnaryExpression          -> UnaryExpr
  | [!StartWithLet] '+' UnaryExpression               -> UnaryExpr
  | [!StartWithLet] '-' UnaryExpression               -> UnaryExpr
  | [!StartWithLet] '~' UnaryExpression               -> UnaryExpr
  | [!StartWithLet] '!' UnaryExpression               -> UnaryExpr
  | [!StartWithLet && Await] AwaitExpression
  | [!StartWithLet] (?= !StartOfArrowFunction) '<' Type '>' UnaryExpression -> TsCastExpr
;

%left resolveShift;

%left '||';
%left '&&';
%left '??';
%left '|';
%left '^';
%left '&';
%left '==' '!=' '===' '!==';
%left '<' '>' '<=' '>=' 'instanceof' 'in' 'as';
%left '<<' '>>' '>>>';
%left '-' '+';
%left '*' '/' '%';
%right '**';

ArithmeticExpression<Yield, Await> -> Expr /* interface */:
    UnaryExpression
  | left=ArithmeticExpression '+' right=ArithmeticExpression        -> AdditiveExpr
  | left=ArithmeticExpression '-' right=ArithmeticExpression        -> AdditiveExpr
  | left=ArithmeticExpression '<<' right=ArithmeticExpression       -> ShiftExpr
  | left=ArithmeticExpression '>>' right=ArithmeticExpression       -> ShiftExpr
  | left=ArithmeticExpression '>>>' right=ArithmeticExpression      -> ShiftExpr
  | left=ArithmeticExpression '*' right=ArithmeticExpression        -> MultiplicativeExpr
  | left=ArithmeticExpression '/' right=ArithmeticExpression        -> MultiplicativeExpr
  | left=ArithmeticExpression '%' right=ArithmeticExpression        -> MultiplicativeExpr
  | left=UpdateExpression '**' right=ArithmeticExpression           -> ExponentiationExpr
;

BinaryExpression<In, Yield, Await> -> Expr /* interface */:
    ArithmeticExpression
  | left=BinaryExpression '<' right=BinaryExpression                -> RelationalExpr
  | left=BinaryExpression '>' right=BinaryExpression                -> RelationalExpr
  | left=BinaryExpression '<=' right=BinaryExpression               -> RelationalExpr
  | left=BinaryExpression '>=' right=BinaryExpression               -> RelationalExpr
  | left=BinaryExpression 'instanceof' right=BinaryExpression       -> InstanceOfExpr
  | [In] left=BinaryExpression 'in' right=BinaryExpression          -> InExpr
  | [!NoAs] left=BinaryExpression .noLineBreak 'as' Type<~AllowQuest>    -> TsAsExpr
  | [!NoAs] left=BinaryExpression .noLineBreak 'as' ('const' -> TsConst) -> TsAsConstExpr   # TS 3.4
  | left=BinaryExpression '==' right=BinaryExpression               -> EqualityExpr
  | left=BinaryExpression '!=' right=BinaryExpression               -> EqualityExpr
  | left=BinaryExpression '===' right=BinaryExpression              -> EqualityExpr
  | left=BinaryExpression '!==' right=BinaryExpression              -> EqualityExpr
  | left=BinaryExpression '&' right=BinaryExpression                -> BitwiseAND
  | left=BinaryExpression '^' right=BinaryExpression                -> BitwiseXOR
  | left=BinaryExpression '|' right=BinaryExpression                -> BitwiseOR
  | left=BinaryExpression '&&' right=BinaryExpression               -> LogicalAND
  | left=BinaryExpression '||' right=BinaryExpression               -> LogicalOR
  | left=BinaryExpression '??' right=BinaryExpression               -> CoalesceExpr
;

ConditionalExpression<In, Yield, Await> -> Expr /* interface */:
    BinaryExpression
  | cond=BinaryExpression '?' then=AssignmentExpression<+In> ':' else=AssignmentExpression
        -> ConditionalExpr
;

AssignmentExpression<In, Yield, Await> -> Expr /* interface */:
    ConditionalExpression
  | [Yield && !StartWithLet] YieldExpression
  | [!StartWithLet] ArrowFunction
  | [!StartWithLet] AsyncArrowFunction
  | left=LeftHandSideExpression '=' right=AssignmentExpression                -> AssignmentExpr
  | left=LeftHandSideExpression AssignmentOperator right=AssignmentExpression -> AssignmentExpr
;

AssignmentOperator -> AssignmentOperator :
    '*=' | '/=' | '%=' | '+=' | '-=' | '<<=' | '>>=' | '>>>=' | '&=' | '^=' | '|=' | '**=' ;

CommaExpression<In, Yield, Await> -> CommaExpr :
    left=Expression ',' right=AssignmentExpression ;

%interface Expr;

Expression<In, Yield, Await> -> Expr /* interface */:
    AssignmentExpression
  | CommaExpression
;

# A.3 Statements

%interface Stmt, Decl;

Statement<Yield, Await> -> Stmt /* interface */:
    BlockStatement
  | VariableStatement
  | EmptyStatement
  | ExpressionStatement
  | IfStatement
  | BreakableStatement
  | ContinueStatement
  | BreakStatement
  | ReturnStatement
  | WithStatement
  | LabelledStatement
  | ThrowStatement
  | TryStatement
  | DebuggerStatement
;

Declaration<Yield, Await> -> Decl /* interface */:
    HoistableDeclaration
  | ClassDeclaration
  | LexicalDeclaration<+In>
  | TypeAliasDeclaration
  | NamespaceDeclaration
  | InterfaceDeclaration
  | EnumDeclaration
  | ImportAliasDeclaration
  | AmbientDeclaration
;

HoistableDeclaration<Await> -> Decl /* interface */:
    FunctionDeclaration
  | GeneratorDeclaration
  | AsyncFunctionDeclaration
;

BreakableStatement<Yield, Await> -> Stmt /* interface */:
    IterationStatement
  | SwitchStatement
;

BlockStatement<Yield, Await> :
    Block ;

Block<Yield, Await> -> Block :
    '{' .recoveryScope StatementList? '}' ;

StatementList<Yield, Await> :
    StatementListItem
  | StatementList StatementListItem
;

%interface StmtListItem, BindingPattern, PropertyPattern, ElementPattern, CaseClause;

StatementListItem<Yield, Await> -> StmtListItem /* interface */:
    Statement
  | Declaration
  | error ';'                                         -> SyntaxProblem
;

LexicalDeclaration<In, Yield, Await> -> LexicalDecl :
    LetOrConst BindingList ';' ;

LetOrConst -> LetOrConst :
    'let'
  | 'const'
;

BindingList<In, Yield, Await> :
    LexicalBinding
  | BindingList ',' LexicalBinding
;

ExclToken -> TsExclToken:
    '!' ;

LexicalBinding<In, Yield, Await> -> LexicalBinding :
    BindingIdentifier ExclToken? TypeAnnotationopt Initializeropt
  | BindingPattern ExclToken? TypeAnnotationopt Initializer
;

VariableStatement<Yield, Await> -> VarStmt :
    'var' VariableDeclarationList<+In> ';'
;

VariableDeclarationList<In, Yield, Await> :
    VariableDeclaration
  | VariableDeclarationList ',' VariableDeclaration
;

VariableDeclaration<In, Yield, Await> -> VarDecl :
    BindingIdentifier ExclToken? TypeAnnotationopt Initializeropt
  | BindingPattern ExclToken? TypeAnnotationopt Initializer
;

BindingPattern<Yield, Await> -> BindingPattern /* interface */:
    ObjectBindingPattern
  | ArrayBindingPattern
;

ObjectBindingPattern<Yield, Await> -> ObjectPattern :
    '{' .recoveryScope BindingRestElementopt '}'
  | '{' .recoveryScope (PropertyPattern separator ',')+ (',' BindingRestElementopt)? '}'
;

ElementElision :
    list+=(',' -> NoElement as ElementPattern)
  | Elision list+=(',' -> NoElement as ElementPattern)
;

ArrayBindingPattern<Yield, Await> -> ArrayPattern :
    '[' ElementElisionopt BindingRestElementopt ']'
  | '[' ElementPatternList ']'
  | '[' ElementPatternList ',' ElementElisionopt BindingRestElementopt ']'
;

ElementPatternList<Yield, Await> :
    BindingElisionElement
  | ElementPatternList ',' BindingElisionElement
;

BindingElisionElement<Yield, Await> :
    Elision? list+=ElementPattern ;

PropertyPattern<Yield, Await> -> PropertyPattern /* interface */:
    SingleNameBinding
  | PropertyName ':' ElementPattern                   -> PropertyBinding
  | SyntaxError
;

ElementPattern<Yield, Await> -> ElementPattern /* interface */:
    SingleNameBinding
  | BindingPattern Initializeropt<+In>                -> ElementBinding
  | SyntaxError
;

SingleNameBinding<Yield, Await> -> SingleNameBinding :
    BindingIdentifier Initializeropt<+In>
;

BindingRestElement -> BindingRestElement :
    '...' BindingIdentifier
;

EmptyStatement -> EmptyStmt :
    ';' .emptyStatement ;

ExpressionStatement<Yield, Await> -> ExprStmt :
    Expression<+In, +NoFuncClass, +NoAs, +NoObjLiteral, +NoLetSq> ';' ;

%right 'else';

IfStatement<Yield, Await> -> IfStmt :
    'if' '(' Expression<+In> ')' then=Statement 'else' else=Statement
  | 'if' '(' Expression<+In> ')' then=Statement %prec 'else'
;

%interface IterationStmt;

IterationStatement<Yield, Await> -> IterationStmt /* interface */:
    'do' Statement 'while' '(' Expression<+In> ')' ';' .doWhile       -> DoWhileStmt
  | 'while' '(' Expression<+In> ')' Statement                         -> WhileStmt
  | 'for' '(' var=Expressionopt<~In,+NoLet> ';' .forSC ForCondition
          ';' .forSC ForFinalExpression ')' Statement                 -> ForStmt
  | 'for' '(' var=Expression<~In,+StartWithLet, +NoAs> ';' .forSC ForCondition
          ';' .forSC ForFinalExpression ')' Statement                 -> ForStmt
  | 'for' '(' ('var' -> Var) VariableDeclarationList<~In> ';' .forSC ForCondition
          ';' .forSC ForFinalExpression ')' Statement                 -> ForStmtWithVar
  | 'for' '(' LetOrConst BindingList<~In> ';' .forSC ForCondition
          ';' .forSC ForFinalExpression ')' Statement                 -> ForStmtWithVar
  | 'for' '(' var=LeftHandSideExpression<+NoLet>
          'in' object=Expression<+In> ')' Statement                   -> ForInStmt
  | 'for' '(' var=LeftHandSideExpression<+StartWithLet>
          'in' object=Expression<+In> ')' Statement                   -> ForInStmt
  | 'for' '(' ('var' -> Var) ForBinding
          'in' object=Expression<+In> ')' Statement                   -> ForInStmtWithVar
  | 'for' '(' ForDeclaration
          'in' object=Expression<+In> ')' Statement                   -> ForInStmtWithVar
  | 'for' '(' var=LeftHandSideExpression<+NoLet, +NoAsync>
          'of' iterable=AssignmentExpression<+In> ')' Statement       -> ForOfStmt
  | 'for' '(' var=((('async' -> ReferenceIdent) -> IdentExpr) -> Expr /* interface */) (?= !StartOfArrowFunction)
          'of' iterable=AssignmentExpression<+In> ')' Statement       -> ForOfStmt
  | 'for' '(' ('var' -> Var) ForBinding
          'of' iterable=AssignmentExpression<+In> ')' Statement       -> ForOfStmtWithVar
  | 'for' '(' ForDeclaration
          'of' iterable=AssignmentExpression<+In> ')' Statement       -> ForOfStmtWithVar
;

ForDeclaration<Yield, Await> :
    LetOrConst ForBinding
;

ForBinding<Yield, Await> -> ForBinding :
    BindingIdentifier
  | BindingPattern
;

ForCondition<Yield, Await> -> ForCondition :
    Expressionopt<+In> ;

ForFinalExpression<Yield, Await> -> ForFinalExpr :
    Expressionopt<+In> ;

ContinueStatement -> ContinueStmt :
    'continue' ';'
  | 'continue' .noLineBreak LabelIdentifier ';'
;

BreakStatement -> BreakStmt :
    'break' ';'
  | 'break' .noLineBreak LabelIdentifier ';'
;

ReturnStatement<Yield, Await> -> ReturnStmt :
    'return' ';'
  | 'return' .noLineBreak Expression<+In> ';'
;

WithStatement<Yield, Await> -> WithStmt :
    'with' '(' Expression<+In> ')' Statement
;

SwitchStatement<Yield, Await> -> SwitchStmt :
    'switch' '(' Expression<+In> ')' CaseBlock
;

CaseBlock<Yield, Await> -> Block :
    '{' .recoveryScope CaseClausesopt '}'
;

CaseClauses<Yield, Await> :
    CaseClause
  | CaseClauses CaseClause
;

CaseClause<Yield, Await> -> CaseClause /* interface */:
    'case' Expression<+In> ':' StatementList?         -> Case
  | 'default' ':' StatementList?                      -> Default
;

LabelledStatement<Yield, Await> -> LabelledStmt :
    LabelIdentifier ':' LabelledItem ;

LabelledItem<Yield, Await> :
    Statement
  | FunctionDeclaration
;

ThrowStatement<Yield, Await> -> ThrowStmt :
    'throw' .noLineBreak Expression<+In> ';'
;

TryStatement<Yield, Await> -> TryStmt :
    'try' Block Catch
  | 'try' Block Catch? Finally
;

Catch<Yield, Await> -> Catch :
    'catch' ('(' CatchParameter ')')? Block
;

Finally<Yield, Await> -> Finally :
    'finally' Block
;

CatchParameter<Yield, Await> :
    BindingIdentifier
  | BindingPattern
;

DebuggerStatement -> DebuggerStmt :
    'debugger' ';'
;

# A.4 Functions and Classes

%interface ClassElement, MethodDefinition;

FunctionDeclaration -> Func :
    'function' BindingIdentifier? FormalParameters<~Yield, ~Await> FunctionBody<~Yield, ~Await> ;

FunctionExpression -> FuncExpr :
    'function' BindingIdentifier? FormalParameters<~Yield, ~Await> FunctionBody<~Yield, ~Await> ;

UniqueFormalParameters<Yield, Await> :
    FormalParameters ;

FunctionBody<Yield, Await> -> Body :
    '{' .recoveryScope StatementList? '}'
  | ';'
;

ArrowFunction<In> -> ArrowFunc :
    BindingIdentifier .noLineBreak '=>' ConciseBody
  | (?= StartOfArrowFunction) FormalParameters<~Yield, ~Await> .noLineBreak '=>' ConciseBody
;

ArrowParameters:
    BindingIdentifier
  | FormalParameters<~Yield, ~Await>
;

ConciseBody<In> :
    AssignmentExpression<~Yield, ~Await, +NoObjLiteral>           -> ConciseBody
  | FunctionBody<~Yield, ~Await>
;

StartOfArrowFunction:
    BindingIdentifier '=>'
  | TypeParameters? ParameterList<~Yield, ~Await> TypeAnnotation? '=>'
;

AsyncArrowFunction<In> -> AsyncArrowFunc :
    'async' .afterAsync .noLineBreak (?= StartOfArrowFunction) ArrowParameters .noLineBreak '=>' AsyncConciseBody ;

# AsyncArrowHead :
#      'async' .noLineBreak ArrowFormalParameters<~Yield, +Await> ;

AsyncConciseBody<In> :
    AssignmentExpression<~Yield, +Await, +NoObjLiteral>           -> ConciseBody
  | AsyncFunctionBody
;

MethodDefinition<Yield, Await> -> MethodDefinition /* interface */:
    PropertyName '?'? UniqueFormalParameters<~Yield, ~Await> FunctionBody<~Yield, ~Await> -> Method
  | GeneratorMethod
  | AsyncMethod
  | 'get' PropertyName '(' ')' TypeAnnotationopt FunctionBody<~Yield, ~Await>             -> Getter
  | 'set' PropertyName '(' PropertySetParameterList ')'  FunctionBody<~Yield, ~Await>     -> Setter
;

PropertySetParameterList :
    Parameter<~Yield, ~Await> ;

GeneratorMethod<Yield, Await> -> GeneratorMethod :
    '*' PropertyName UniqueFormalParameters<+Yield, ~Await> GeneratorBody ;

GeneratorDeclaration -> Generator :
    'function' '*' BindingIdentifier? FormalParameters<+Yield, ~Await> GeneratorBody ;

GeneratorExpression -> GeneratorExpr :
    'function' '*' BindingIdentifier/* no yield*/? FormalParameters<+Yield, ~Await> GeneratorBody ;

GeneratorBody :
    FunctionBody<+Yield, ~Await> ;

YieldExpression<In, Await> -> Yield :
    'yield'
  | 'yield' .afterYield .noLineBreak AssignmentExpression<+Yield>
  | 'yield' .afterYield .noLineBreak '*' AssignmentExpression<+Yield>
;

AsyncMethod<Yield, Await> -> AsyncMethod :
    'async' .afterAsync .noLineBreak PropertyName UniqueFormalParameters<~Yield, +Await> AsyncFunctionBody ;

AsyncFunctionDeclaration<Await> -> AsyncFunc :
    'async' .afterAsync .noLineBreak 'function' BindingIdentifier? FormalParameters<~Yield> AsyncFunctionBody ;

AsyncFunctionExpression -> AsyncFuncExpr :
    'async' .afterAsync .noLineBreak 'function' BindingIdentifier/* no await*/? FormalParameters<~Yield, +Await> AsyncFunctionBody ;

AsyncFunctionBody :
    FunctionBody<~Yield, +Await> ;

AwaitExpression<Yield> -> AwaitExpr :
    'await' UnaryExpression<+Await> ;

ClassDeclaration<Yield, Await> -> Decl /* interface */:
    Modifiers? 'class' BindingIdentifier<+WithoutImplements>? TypeParametersopt ClassTail   -> Class
;

ClassExpression<Yield, Await> -> ClassExpr :
    Modifiers? 'class' BindingIdentifier<+WithoutImplements>? TypeParameters? ClassTail
;

ClassTail<Yield, Await> :
    ClassHeritage ClassBody ;

ClassHeritage<Yield, Await>:
    ClassExtendsClause? ImplementsClause? ;

StartOfExtendsTypeRef:
    TypeReference ('implements' | '{') ;

ClassExtendsClause<Yield, Await> -> Extends:
    'extends' (?= StartOfExtendsTypeRef) TypeReference
  | 'extends' (?= !StartOfExtendsTypeRef) LeftHandSideExpression
;

ImplementsClause -> TsImplementsClause:
    'implements' (TypeReference separator ',')+ ;

ClassBody<Yield, Await> -> ClassBody :
    '{' .recoveryScope ClassElementList? '}' ;

ClassElementList<Yield, Await> :
    ClassElement
  | ClassElementList ClassElement
;

%interface Modifier;

%flag WithDeclare = false;

Modifier<WithDeclare> -> Modifier /* interface */:
    AccessibilityModifier
  | Decorator<~Await, ~Yield>
  | 'static'                 -> Static
  | 'abstract'               -> Abstract
  | 'readonly'               -> Readonly
  | [WithDeclare] 'declare'  -> Declare
;

Modifiers<WithDeclare>:
    Modifier
  | Modifiers Modifier
;

ClassElement<Yield, Await> -> ClassElement /* interface */:
    Modifiers<+WithDeclare>? MethodDefinition   -> MemberMethod
  | Modifiers<+WithDeclare>? PropertyName ('?'|'!')? TypeAnnotationopt Initializeropt<+In> ';' -> MemberVar
  | IndexSignature<+WithDeclare> ';'            -> TsIndexMemberDecl
  | ';'                                         -> EmptyDecl
;

# A.5 Scripts and Modules

%interface ModuleItem, NamedImport, ExportElement;

Module -> Module :
    ModuleBodyopt ;

ModuleBody :
    ModuleItemList ;

ModuleItemList :
    ModuleItem
  | ModuleItemList ModuleItem
;

ModuleItem -> ModuleItem /* interface */:
    ImportDeclaration
  | ImportRequireDeclaration
  | ExportDeclaration
  | StatementListItem<~Yield, ~Await>
;

ImportDeclaration -> ImportDecl :
    'import' (?= !StartOfTypeImport) ImportClause FromClause ';'
  | 'import' (?= StartOfTypeImport) ('type' -> TsTypeOnly)  ImportClause FromClause ';'
  | 'import' ModuleSpecifier ';'
;

StartOfTypeImport:
      'type' ('*' | '{' | IdentifierName<+WithoutFrom>) ;

ImportRequireDeclaration -> TsImportRequireDecl:
    ('export' -> TsExport)? 'import' (?= !StartOfTypeImport) BindingIdentifier '=' 'require' '(' StringLiteral ')' ';' ;

ImportClause :
    ImportedDefaultBinding
  | NameSpaceImport
  | NamedImports
  | ImportedDefaultBinding ',' NameSpaceImport
  | ImportedDefaultBinding ',' NamedImports
;

ImportedDefaultBinding :
    ImportedBinding ;

NameSpaceImport -> NameSpaceImport :
    '*' 'as' ImportedBinding ;

FromClause :
    'from' ModuleSpecifier ;

NamedImports -> NamedImports :
    '{' '}'
  | '{' (NamedImport separator ',')+ ','? '}'
;

NamedImport -> NamedImport /* interface */:
    ImportedBinding                                   -> ImportSpec
  | IdentifierNameRef 'as' ImportedBinding            -> ImportSpec
  | error                                             -> SyntaxProblem
;

ModuleSpecifier -> ModuleSpec :
    StringLiteral ;

ImportedBinding :
    BindingIdentifier ;

ExportDeclaration -> ModuleItem /* interface */:
    'export' ('type' -> TsTypeOnly)? '*' ('as' ImportedBinding)? FromClause ';' -> ExportDecl
  | 'export' ('type' -> TsTypeOnly)? ExportClause FromClause ';'                -> ExportDecl
  | 'export' ('type' -> TsTypeOnly)? ExportClause ';'                           -> ExportDecl
  | 'export' VariableStatement<~Yield, ~Await>        -> ExportDecl
  | Modifiers? 'export' Declaration<~Yield, ~Await>              -> ExportDecl
  | 'export' 'default' HoistableDeclaration<~Await>                                -> ExportDefault
  | Modifiers? 'export' 'default' ClassDeclaration<~Yield, ~Await>                            -> ExportDefault
  | 'export' 'default' AssignmentExpression<+In, ~Yield, ~Await, +NoFuncClass> ';' -> ExportDefault
  | 'export' '=' AssignmentExpression<+In, ~Yield, ~Await, +NoFuncClass> ';'     -> TsExportAssignment
  | 'export' 'as' 'namespace' BindingIdentifier ';'   -> TsNamespaceExportDecl
;

ExportClause -> ExportClause :
    '{' '}'
  | '{' (ExportElement separator ',')+ ','? '}'
;

ExportElement -> ExportElement /* interface */:
    IdentifierNameRef                                 -> ExportSpec
  | IdentifierNameRef 'as' IdentifierNameDecl         -> ExportSpec
  | error                                             -> SyntaxProblem
;

# ES next: https://github.com/tc39/proposal-decorators

%interface Decorator;

Decorator<Yield, Await> -> Decorator /* interface */:
    '@' DecoratorMemberExpression       -> DecoratorExpr
  | '@' DecoratorCallExpression         -> DecoratorCall
;

DecoratorMemberExpression<Yield, Await>:
    IdentifierReference
  | DecoratorMemberExpression '.' (IdentifierName -> ReferenceIdent)
;

DecoratorCallExpression<Yield, Await>:
  DecoratorMemberExpression Arguments ;

# Typescript

# Note: yield and await do not apply to type contexts.

# A.1 Types

%interface TsType, TypeMember;

%flag AllowQuest = true;

Type<AllowQuest> -> TsType /* interface */:
    UnionOrIntersectionOrPrimaryType %prec resolveShift
  | [AllowQuest] check=UnionOrIntersectionOrPrimaryType 'extends' ext=Type<~AllowQuest> '?' truet=Type ':' falset=Type  -> TsConditional
  | FunctionType
  | ConstructorType
  | [AllowQuest] AssertsType
  | TypePredicate
;

TypePredicate<AllowQuest> -> TypePredicate:
    paramref=IdentifierNameRef<+WithoutAsserts> 'is' Type -> TypePredicate
  | paramref=('asserts' -> ReferenceIdent) (?= StartOfIs) 'is' Type<~AllowQuest> -> TypePredicate
;

# 3.7
AssertsType<AllowQuest> -> AssertsType:
    'asserts' .noLineBreak (?= !StartOfIs) ('this' -> This | IdentifierName<+WithoutKeywords> -> ReferenceIdent) ('is' Type)? ;

StartOfIs:
      'is' ;

TypeParameters -> TypeParameters :
    '<' (TypeParameter separator ',')+ '>' ;

TypeParameter -> TypeParameter :
    BindingIdentifier Constraint? ('=' Type)?;

Constraint -> TypeConstraint :
    'extends' Type ;

TypeArguments -> TypeArguments :
    '<' (Type separator ',')+ '>' ;

UnionOrIntersectionOrPrimaryType<AllowQuest> -> TsType /* interface */:
    inner+=UnionOrIntersectionOrPrimaryType? '|' inner+=IntersectionOrPrimaryType -> UnionType
  | IntersectionOrPrimaryType %prec resolveShift
;

IntersectionOrPrimaryType<AllowQuest> -> TsType /* interface */:
    inner+=IntersectionOrPrimaryType? '&' inner+=TypeOperator -> IntersectionType
  | TypeOperator
;

TypeOperator<AllowQuest> -> TsType /* interface */:
    PrimaryType
  | 'keyof' TypeOperator      -> KeyOfType
  | 'unique' TypeOperator     -> UniqueType
  | 'readonly' TypeOperator   -> ReadonlyType
  | 'infer' (IdentifierName -> ReferenceIdent) -> TypeVar
;

PrimaryType<AllowQuest> -> TsType /* interface */:
    ParenthesizedType
  | PredefinedType
  | TypeReference
  | ObjectType
  | MappedType
  | ArrayType
  | IndexedAccessType
  | LiteralType
  | TupleType
  | TypeQuery
  | ImportType
  | 'this'                                        -> ThisType
  | PrimaryType .noLineBreak '!'                  -> NonNullableType
  | [AllowQuest] PrimaryType .noLineBreak '?'     -> NullableType
;

ParenthesizedType -> ParenthesizedType :
    '(' (?= !StartOfFunctionType) Type ')' ;

# 2.0
LiteralType -> LiteralType :
    StringLiteral
  | '-'? NumericLiteral
  | 'null'
  | 'true'
  | 'false'
;

PredefinedType -> PredefinedType :
    'any'
  | 'unknown'
  | 'number'
  | 'boolean'
  | 'string'
  | 'symbol'
  | 'void'
  # TODO add bigint, undefined, never, object
;

TypeReference -> TypeReference :
    TypeName .noLineBreak TypeArguments? %prec resolveShift ;

TypeName -> TypeName :
    ref+=IdentifierReference<+WithoutPredefinedTypes, ~Yield, ~Await>
  | NamespaceName '.' ref+=IdentifierReference<~Yield, ~Await>
;

NamespaceName :
    ref+=IdentifierReference<~Yield, ~Await>
  | NamespaceName '.' ref+=IdentifierReference<~Yield, ~Await>
;

ObjectType -> ObjectType :
    '{' .recoveryScope (?= !StartOfMappedType) TypeBody? '}' ;

TypeBody :
    TypeMemberList
  | TypeMemberList ','
  | TypeMemberList ';'
;

TypeMemberList :
    TypeMember
  | TypeMemberList ';' TypeMember
  | TypeMemberList ',' TypeMember
;

TypeMember -> TypeMember /* interface */:
    PropertySignature
  | MethodSignature
  | CallSignature
  | ConstructSignature
  | IndexSignature
;

ArrayType<AllowQuest> -> ArrayType :
    PrimaryType .noLineBreak '[' ']' ;

# 2.1
IndexedAccessType<AllowQuest> -> IndexedAccessType :
    left=PrimaryType .noLineBreak '[' index=Type ']' ;

# 2.1
StartOfMappedType :
    ('+' | '-') 'readonly'
  | 'readonly'? '[' IdentifierName 'in'
;

# 2.1
MappedType -> MappedType :
    '{' .recoveryScope (?= StartOfMappedType) (('+'|'-')? 'readonly')? '[' BindingIdentifier 'in' Type ']' (('+'|'-')? '?')? TypeAnnotation ';'? '}' ;

TupleType -> TupleType :
    '[' (TupleElementType separator ',')+? ']' ;

TupleElementType -> TsType:
    Type
  | '...' Type  -> RestType
;

# This lookahead rule disambiguates FunctionType vs ParenthesizedType
# productions by enumerating all prefixes of FunctionType that would
# lead to parse failure if interpreted as Type.
# (partially inspired by isUnambiguouslyStartOfFunctionType() in
# src/compiler/parser.ts)
StartOfFunctionType :
    Modifiers? BindingIdentifier (':' | ',' | '?' | '=' | ')' '=>')
  | Modifiers? BindingPattern<~Yield, ~Await> (':' | ',' | '?' | '=' | ')' '=>')
  | '...'
  | 'this' ':'
  | ')'
;

FunctionType<AllowQuest> -> FuncType :
    TypeParameters? FunctionTypeParameterList '=>' Type ;

FunctionTypeParameterList -> Parameters :
    '(' (?= StartOfFunctionType) (Parameter<~Yield, ~Await> separator ',')+? ','? ')' ;

ConstructorType<AllowQuest> -> ConstructorType :
    'new' TypeParameters? ParameterList<~Yield, ~Await> '=>' Type ;

%left 'keyof' 'typeof' 'unique' 'readonly' 'infer';
%nonassoc 'is';

TypeQuery -> TypeQuery :
    'typeof' TypeQueryExpression ;

# 2.9
ImportType -> ImportType :
    'typeof'? 'import' '(' Type ')' ('.' IdentifierReference<~Yield, ~Await> )+? .noLineBreak TypeArguments? %prec resolveShift ;

TypeQueryExpression :
    IdentifierReference<~Yield, ~Await>
  | TypeQueryExpression '.' (IdentifierName -> ReferenceIdent)
;

PropertySignature -> PropertySignature :
    Modifiers? PropertyName<+WithoutNew, ~Yield, ~Await> '?'? TypeAnnotation? ;

TypeAnnotation -> TypeAnnotation :
    ':' Type ;

FormalParameters<Yield, Await> :
    TypeParameters? ParameterList TypeAnnotation? ;

CallSignature -> CallSignature :
    TypeParameters? ParameterList<~Yield, ~Await> TypeAnnotation? ;

ParameterList<Yield, Await> -> Parameters :
    '(' (Parameter separator ',')+? ','? ')' ;

%interface Parameter;

Parameter<Yield, Await> -> Parameter :
    Modifiers? BindingIdentifier '?'? TypeAnnotation?              -> DefaultParameter
  | Modifiers? BindingPattern '?'? TypeAnnotation?                 -> DefaultParameter
  | Modifiers? BindingIdentifier TypeAnnotation? Initializer<+In>  -> DefaultParameter
  | Modifiers? BindingPattern TypeAnnotation? Initializer<+In>     -> DefaultParameter
  | '...' BindingIdentifier TypeAnnotation?                        -> RestParameter
  | 'this' TypeAnnotation                                          -> TsThisParameter
  | SyntaxError
;

AccessibilityModifier -> AccessibilityModifier :
    'public'
  | 'private'
  | 'protected'
;

BindingIdentifierOrPattern<Yield, Await> :
    BindingIdentifier
  | BindingPattern
;

ConstructSignature -> ConstructSignature :
    Modifiers? 'new' TypeParameters? ParameterList<~Yield, ~Await> TypeAnnotation? ;

# Note: using IdentifierName instead of BindingIdentifier to avoid r/r
# conflicts with ComputedPropertyName.
IndexSignature<WithDeclare> -> IndexSignature :
    Modifiers? '[' (IdentifierName -> NameIdent) ':' ('string' -> PredefinedType) ']' TypeAnnotation
  | Modifiers? '[' (IdentifierName -> NameIdent) ':' ('number' -> PredefinedType) ']' TypeAnnotation
;

MethodSignature -> MethodSignature :
    Modifiers? PropertyName<+WithoutNew, ~Yield, ~Await> '?'? FormalParameters<~Yield, ~Await> ;

TypeAliasDeclaration -> TypeAliasDecl :
    'type' BindingIdentifier TypeParameters? '=' Type ';' ;

# A.5 Interfaces

InterfaceDeclaration -> TsInterface:
    'interface' BindingIdentifier TypeParametersopt InterfaceExtendsClause? ObjectType ;

InterfaceExtendsClause -> TsInterfaceExtends:
    'extends' (TypeReference separator ',')+ ;

# A.7 Enums

EnumDeclaration -> TsEnum:
    ('const' -> TsConst)? 'enum' BindingIdentifier EnumBody ;

EnumBody -> TsEnumBody:
    '{' .recoveryScope ((EnumMember separator ',')+ ','?)? '}' ;

EnumMember -> TsEnumMember:
    PropertyName<~Yield, ~Await>
  | PropertyName<~Yield, ~Await> '=' AssignmentExpression<+In, ~Yield, ~Await>
;

# A.8 Namespaces

NamespaceDeclaration -> TsNamespace:
    ('namespace' | 'module') IdentifierPath NamespaceBody ;

IdentifierPath:
    BindingIdentifier
  | IdentifierPath '.' BindingIdentifier
;

NamespaceBody -> TsNamespaceBody:
    '{' .recoveryScope ModuleItemList? '}' ;

ImportAliasDeclaration -> TsImportAliasDecl:
    'import' (?= !StartOfTypeImport) BindingIdentifier '=' EntityName ';' ;

EntityName:
    NamespaceName ;

# A.10 Ambients

%interface TsAmbientElement, TsAmbientClassElement;

AmbientDeclaration -> TsAmbientElement /* interface */:
    'declare' AmbientVariableDeclaration        -> TsAmbientVar
  | 'declare' AmbientFunctionDeclaration        -> TsAmbientFunc
  | 'declare' AmbientClassDeclaration           -> TsAmbientClass
  | 'declare' AmbientInterfaceDeclaration       -> TsAmbientInterface
  | 'declare' AmbientEnumDeclaration            -> TsAmbientEnum
  | 'declare' AmbientNamespaceDeclaration       -> TsAmbientNamespace
  | 'declare' AmbientModuleDeclaration          -> TsAmbientModule
  | 'declare' AmbientGlobalDeclaration          -> TsAmbientGlobal
  | 'declare' TypeAliasDeclaration              -> TsAmbientTypeAlias
;

AmbientVariableDeclaration:
    ('var' -> Var) AmbientBindingList ';'
  | ('let' -> LetOrConst) AmbientBindingList ';'
  | ('const' -> LetOrConst) AmbientBindingList ';'
;

AmbientBindingList:
    AmbientBinding
  | AmbientBindingList ',' AmbientBinding
;

AmbientBinding -> TsAmbientBinding:
    BindingIdentifier TypeAnnotation? Initializer<+In, ~Yield, ~Await>? ;

AmbientFunctionDeclaration:
    'function' BindingIdentifier FormalParameters<~Yield, ~Await> ';' ;

AmbientClassDeclaration:
    Modifiers? 'class' BindingIdentifier TypeParametersopt ClassTail<~Yield, ~Await> ;

AmbientInterfaceDeclaration:
    Modifiers? 'interface' BindingIdentifier TypeParametersopt InterfaceExtendsClause? ObjectType ;

AmbientEnumDeclaration:
    ('const' -> TsConst)? 'enum' BindingIdentifier EnumBody ;

AmbientNamespaceDeclaration:
    'namespace' IdentifierPath AmbientNamespaceBody ;

AmbientModuleDeclaration:
    'module' (StringLiteral | IdentifierPath) ('{' .recoveryScope ModuleBodyopt '}' | ';') ;

AmbientGlobalDeclaration:
    'global' ('{' .recoveryScope ModuleBodyopt '}' | ';') ;

AmbientNamespaceBody:
    '{' .recoveryScope AmbientNamespaceElement+? '}' ;

AmbientNamespaceElement -> TsAmbientElement /* interface */:
    'export'? AmbientVariableDeclaration    -> TsAmbientVar
  | 'export'? AmbientFunctionDeclaration    -> TsAmbientFunc
  | 'export'? AmbientClassDeclaration       -> TsAmbientClass
  | 'export'? AmbientInterfaceDeclaration   -> TsAmbientInterface
  | 'export'? AmbientEnumDeclaration        -> TsAmbientEnum
  | 'export'? AmbientNamespaceDeclaration   -> TsAmbientNamespace
  | 'export'? AmbientModuleDeclaration      -> TsAmbientModule
  | 'export'? ImportAliasDeclaration        -> TsAmbientImportAlias
  | 'export'? TypeAliasDeclaration          -> TsAmbientTypeAlias
  | 'export' ExportClause ';'               -> TsAmbientExportDecl
;


