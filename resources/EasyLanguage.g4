grammar EasyLanguage;

@header{
	import br.edu.cefsa.compiler.datastructures.EasySymbol;
	import br.edu.cefsa.compiler.datastructures.EasyVariable;
	import br.edu.cefsa.compiler.datastructures.EasyFunction;
	import br.edu.cefsa.compiler.datastructures.EasySymbolTable;
	import br.edu.cefsa.compiler.exceptions.EasySemanticException;
	import br.edu.cefsa.compiler.abstractsyntaxtree.EasyProgram;
	import br.edu.cefsa.compiler.abstractsyntaxtree.AbstractCommand;
	import br.edu.cefsa.compiler.abstractsyntaxtree.CommandLeitura;
	import br.edu.cefsa.compiler.abstractsyntaxtree.CommandEscrita;
	import br.edu.cefsa.compiler.abstractsyntaxtree.CommandAtribuicao;
	import br.edu.cefsa.compiler.abstractsyntaxtree.CommandDecisao;
	import java.util.ArrayList;
	import java.util.Stack;
}

@members{
	private int _tipo;
	private String _varName;
	private String _varValue;
	private EasySymbolTable symbolTable = new EasySymbolTable();
	private EasySymbol symbol;
	private EasyProgram program = new EasyProgram();
	private ArrayList<AbstractCommand> curThread;
	private Stack<ArrayList<AbstractCommand>> stack = new Stack<ArrayList<AbstractCommand>>();
	private String _readID;
	private String _writeID;
	private String _exprID;
	private String _exprContent;
	private String _exprDecision;
	private ArrayList<AbstractCommand> listaTrue;
	private ArrayList<AbstractCommand> listaFalse;
	private ArrayList<AbstractCommand> listaWhile;
	private ArrayList<AbstractCommand> listaFor;
	private String _functionName;
	private ArrayList<EasyVariable> _parameters;
	private int _returnType;
	private String _forVar;
	private String _forStart;
	private String _forEnd;
	private String _forStep;
	
	public void verificaID(String id){
		if (!symbolTable.exists(id)){
			throw new EasySemanticException("Symbol "+id+" not declared");
		}
	}
	
	public void verificaTipo(String id, int expectedType){
		if (!symbolTable.exists(id)){
			throw new EasySemanticException("Symbol "+id+" not declared");
		}
		EasyVariable var = (EasyVariable)symbolTable.get(id);
		if (var.getType() != expectedType){
			throw new EasySemanticException("Type mismatch for symbol "+id);
		}
	}
	
	public void verificaInicializacao(String id){
		if (!symbolTable.exists(id)){
			throw new EasySemanticException("Symbol "+id+" not declared");
		}
		EasyVariable var = (EasyVariable)symbolTable.get(id);
		if (!var.isInitialized()){
			throw new EasySemanticException("Variable "+id+" used before initialization");
		}
	}

	public void exibeComandos(){
		for (AbstractCommand c: program.getComandos()){
			System.out.println(c);
		}
	}
	
	public void generateCode(){
		program.generateTarget();
	}

	public EasyProgram getProgram(){
		return program;
	}
	
	public EasySymbolTable getSymbolTable(){
		return symbolTable;
	}
}

prog	: 'programa' ID { program.setName($ID.text);
          }
          (declaracao)*
          'inicio'
          bloco 
          'fim;'
          {  
              program.setVarTable(symbolTable);
              program.setComandos(stack.pop());
          } 
	;
		
decl    : declaravar
		| declarafuncao
		| declaraconst
        ;
        
        
declaravar : tipo ID {
                  _varName = $ID.text;
                  _varValue = null;
                  symbol = new EasyVariable(_varName, _tipo, _varValue);
                  if (!symbolTable.exists(_varName)){
                     symbolTable.add(symbol);	
                  }
                  else{
                  	 throw new EasySemanticException("Symbol "+_varName+" already declared");
                  }
             } 
             (ATTR 
              (NUMBER { 
                  _varValue = $NUMBER.text;
                  ((EasyVariable)symbol).setValue(_varValue);
                  ((EasyVariable)symbol).setInitialized(true);
              }
              | STRING { 
                  _varValue = $STRING.text;
                  ((EasyVariable)symbol).setValue(_varValue);
                  ((EasyVariable)symbol).setInitialized(true);
              }
              | BOOLEAN { 
                  _varValue = $BOOLEAN.text;
                  ((EasyVariable)symbol).setValue(_varValue);
                  ((EasyVariable)symbol).setInitialized(true);
              }
              | CHAR { 
                  _varValue = $CHAR.text;
                  ((EasyVariable)symbol).setValue(_varValue);
                  ((EasyVariable)symbol).setInitialized(true);
              }
              )
             )?
             (VIR 
              ID {
                  _varName = $ID.text;
                  _varValue = null;
                  symbol = new EasyVariable(_varName, _tipo, _varValue);
                  if (!symbolTable.exists(_varName)){
                     symbolTable.add(symbol);	
                  }
                  else{
                  	 throw new EasySemanticException("Symbol "+_varName+" already declared");
                  }
              }
              (ATTR 
               (NUMBER { 
                   _varValue = $NUMBER.text;
                   ((EasyVariable)symbol).setValue(_varValue);
                   ((EasyVariable)symbol).setInitialized(true);
               }
               | STRING { 
                   _varValue = $STRING.text;
                   ((EasyVariable)symbol).setValue(_varValue);
                   ((EasyVariable)symbol).setInitialized(true);
               }
               | BOOLEAN { 
                   _varValue = $BOOLEAN.text;
                   ((EasyVariable)symbol).setValue(_varValue);
                   ((EasyVariable)symbol).setInitialized(true);
               }
               | CHAR { 
                   _varValue = $CHAR.text;
                   ((EasyVariable)symbol).setValue(_varValue);
                   ((EasyVariable)symbol).setInitialized(true);
               }
               )
              )?
             )* 
             SC
           ;

declaraconst : 'const' tipo ID {
                   _varName = $ID.text;
               }
               ATTR 
               (NUMBER { _varValue = $NUMBER.text; }
               | STRING { _varValue = $STRING.text; }
               | BOOLEAN { _varValue = $BOOLEAN.text; }
               | CHAR { _varValue = $CHAR.text; }
               )
               SC
               {
                   symbol = new EasyVariable(_varName, _tipo, _varValue, true);
                   if (!symbolTable.exists(_varName)){
                       symbolTable.add(symbol);
                   }
                   else{
                       throw new EasySemanticException("Constant "+_varName+" already declared");
                   }
               }
             ;

declarafuncao : (tipo { _returnType = _tipo; } | 'vazio' { _returnType = EasyVariable.VOID; }) 
                'funcao' ID {
                    _functionName = $ID.text;
                    _parameters = new ArrayList<EasyVariable>();
                }
                AP 
                (parametros)?
                FP
                'inicio'
                bloco
                'fim' SC
                {
                    EasyFunction func = new EasyFunction(_functionName, _returnType, _parameters);
                    if (!symbolTable.exists(_functionName)){
                        symbolTable.add(func);
                    }
                    else{
                        throw new EasySemanticException("Function "+_functionName+" already declared");
                    }
                }
              ;


parametros : tipo ID {
                 _parameters.add(new EasyVariable($ID.text, _tipo, null));
             }
             (VIR tipo ID {
                 _parameters.add(new EasyVariable($ID.text, _tipo, null));
             })*
           ;
           
tipo       : 'numero' { _tipo = EasyVariable.NUMBER;  }
           | 'texto'  { _tipo = EasyVariable.TEXT;  }
           | 'inteiro'{ _tipo = EasyVariable.INTEGER;  }
           | 'caractere'  { _tipo = EasyVariable.CHAR;  }
           | 'logico'  { _tipo = EasyVariable.BOOLEAN;  }
           | 'vetor'  { _tipo = EasyVariable.ARRAY;  }
           ;
        
bloco	: { curThread = new ArrayList<AbstractCommand>(); 
	        stack.push(curThread);  
          }
          (cmd)+
		;
		

cmd		:  cmdleitura  
 		|  cmdescrita 
 		|  cmdattrib
 		|  cmdselecao  
        |  cmdrepeticao 
        |  cmdfor
        |  cmdretorno 
        |  cmdchamada 
		;
		
cmdleitura	: 'leia' AP
                     ID { verificaID(_input.LT(-1).getText());
                     	  _readID = _input.LT(-1).getText();
                        } 
                     FP 
                     SC 
                     
              {
              	EasyVariable var = (EasyVariable)symbolTable.get(_readID);
              	CommandLeitura cmd = new CommandLeitura(_readID, var);
              	stack.peek().add(cmd);
              }   
			;
			
cmdescrita	: 'escreva' 
                 AP 
                 (ID { verificaID(_input.LT(-1).getText());
	                  _writeID = _input.LT(-1).getText();
                     }
                     | STRING { _writeID = $STRING.text; }
                     | NUMBER { _writeID = $NUMBER.text; }
                     | expr { _writeID = _exprContent; } )
                 FP 
                 SC
               {
               	  CommandEscrita cmd = new CommandEscrita(_writeID);
               	  stack.peek().add(cmd);
               }
			;
			
cmdattrib	:  ID { verificaID(_input.LT(-1).getText());
                    _exprID = _input.LT(-1).getText();
                   } 
               ATTR { _exprContent = ""; } 
               expr 
               SC
               {
               	 CommandAtribuicao cmd = new CommandAtribuicao(_exprID, _exprContent);
               	 stack.peek().add(cmd);
               }
			;
			
			
cmdselecao  :  'se' AP
                    ID    { _exprDecision = _input.LT(-1).getText(); }
                    OPREL { _exprDecision += _input.LT(-1).getText(); }
                    (ID | NUMBER) {_exprDecision += _input.LT(-1).getText(); }
                    FP 
                    ACH 
                    { curThread = new ArrayList<AbstractCommand>(); 
                        stack.push(curThread);
                    }
                    (cmd)+ 
                    FCH
                    {
                       listaTrue = stack.pop();	
                    } 
                   ('senao' 
                   	ACH
                   	{
                   	 	curThread = new ArrayList<AbstractCommand>();
                   	 	stack.push(curThread);
                   	} 
                   	(cmd+) 
                   	FCH
                   	{
                   		listaFalse = stack.pop();
                   		CommandDecisao cmd = new CommandDecisao(_exprDecision, listaTrue, listaFalse);
                   		stack.peek().add(cmd);
                   	}
                   )?
            ;
			
cmdrepeticao : 'enquanto' AP
               { _exprContent = ""; }
               expr_logica { _exprDecision = _exprContent; }
               FP
               'faca'
               ACH
               {
                   curThread = new ArrayList<AbstractCommand>();
                   stack.push(curThread);
               }
               (cmd)*
               FCH
               {
                   listaWhile = stack.pop();
                   CommandRepeticao cmd = new CommandRepeticao(_exprDecision, listaWhile);
                   stack.peek().add(cmd);
               }
             ;

cmdfor : 'para' ID { 
             verificaID($ID.text);
             _forVar = $ID.text;
         }
         ATTR { _exprContent = ""; }
         expr { _forStart = _exprContent; }
         'ate' { _exprContent = ""; }
         expr { _forEnd = _exprContent; }
         ('passo' { _exprContent = ""; }
          expr { _forStep = _exprContent; }
         )?
         'faca'
         ACH
         {
             curThread = new ArrayList<AbstractCommand>();
             stack.push(curThread);
         }
         (cmd)*
         FCH
         {
             listaFor = stack.pop();
             if (_forStep == null) _forStep = "1";
             CommandFor cmd = new CommandFor(_forVar, _forStart, _forEnd, _forStep, listaFor);
             stack.peek().add(cmd);
         }
       ;

cmdretorno : 'retorna' { _exprContent = ""; }
             (expr)?
             SC
             {
                 CommandRetorno cmd = new CommandRetorno(_exprContent);
                 stack.peek().add(cmd);
             }
           ;

cmdchamada : ID { 
                 verificaID($ID.text);
                 _functionName = $ID.text;
             }
             AP 
             { _exprContent = ""; }
             (expr (VIR expr)*)?
             FP SC
             {
                 CommandChamadaFuncao cmd = new CommandChamadaFuncao(_functionName, _exprContent);
                 stack.peek().add(cmd);
             }
           ;

expr_logica : expr_relacional 
              (('e' { _exprContent += " && "; } | 'ou' { _exprContent += " || "; }) 
               expr_relacional)*
            ;

expr_relacional : expr 
                  (OPREL { _exprContent += $OPREL.text; } 
                   expr)?
                ;

expr : termo 
       (OP { _exprContent += $OP.text; }
        termo)*
     ;

termo : fator 
        (('*' { _exprContent += "*"; } 
         | '/' { _exprContent += "/"; } 
         | '%' { _exprContent += "%"; }) 
         fator)*
      ;

fator : ID { 
            verificaID($ID.text);
            verificaInicializacao($ID.text);
            _exprContent += $ID.text;
        }
      | NUMBER { _exprContent += $NUMBER.text; }
      | STRING { _exprContent += $STRING.text; }
      | BOOLEAN { _exprContent += $BOOLEAN.text; }
      | CHAR { _exprContent += $CHAR.text; }
      | AP expr FP
      | chamada_funcao
      | '-' fator { _exprContent = "-" + _exprContent; }
      | '+' fator { _exprContent = "+" + _exprContent; }
      ;

chamada_funcao : ID { 
                     verificaID($ID.text);
                     _exprContent += $ID.text + "(";
                 }
                 AP 
                 (expr 
                  (VIR { _exprContent += ","; } expr)*
                 )?
                 FP
                 { _exprContent += ")"; }
               ;
			
	
AP	: '('
	;
	
FP	: ')'
	;
	
SC	: ';'
	;
	
OP	: '+' | '-' | '*' | '/'
	;
	
ATTR : '='
     ;
	 
VIR  : ','
     ;
     
ACH  : '{'
     ;
     
FCH  : '}'
     ;
	 
	 
OPREL : '>' | '<' | '>=' | '<=' | '==' | '!='
      ;
      
ID	: [a-z] ([a-z] | [A-Z] | [0-9])*
	;
	
NUMBER	: [0-9]+ ('.' [0-9]+)?
	;
		
WS	: (' ' | '\t' | '\n' | '\r') -> skip;

STRING  : '"' (~["\r\n])* '"' 
        ;

BOOLEAN : 'verdadeiro' | 'falso' 
        ;

CHAR    : '\'' . '\'' 
        ;

COMMENT_LINE  : '//' ~[\r\n]* -> skip ;

COMMENT_BLOCK : '/*' .*? '*/' -> skip ;