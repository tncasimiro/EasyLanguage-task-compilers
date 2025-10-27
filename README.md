🧩 EasyLanguage Compiler
==========================================================

📖 Sumário
----------

*   [✨ Visão Geral](#-visão-geral)
    
*   [⚙️ Estrutura Técnica](#-estruturas-de-controle)
    
*   [🧰 Tecnologias Utilizadas](#-tecnologias-utilizadas)
    
*   [🚀 Como Iniciar](#-como-iniciar)
    
*   [💡 Exemplos de Uso](#-exemplos-de-uso)
    
*   [📜 Licença]()
    
*   [👨‍💻 Autores]()
    

✨ Visão Geral
-------------

O **EasyLanguage Compiler** é um ambiente para experimentação prática de compiladores, permitindo a escrita, analise e execução de programas desenvolvidos em **EasyLanguage**.

### Principais Recursos

*   **🔄 Compilação Multietapas**
    
    *   Análise léxica com geração de tokens via ANTLR4
        
    *   Verificação sintática conforme regras da gramática
        
    *   Análise semântica com checagem de tipos e escopo
        
    *   Geração de código otimizada para Java
        
*   **🧩 Web IDE Interativa**
    
    *   Realce de sintaxe e feedback em tempo real
        
    *   Visualização dinâmica da tabela de símbolos
        
    *   Interface moderna e responsiva
        
*   **🧠 Recursos da Linguagem**
    
    *   Tipagem estática e detecção de erros em tempo de compilação
        
    *   Tipos suportados: inteiro, real, logico, texto
        
    *   Estruturas de controle se-senao, enquanto, para, vetores
        
    *   Suporte a funções e procedimentos com parâmetros
        

        

⚙️ Estrutura Técnica
--------------------

### Arquitetura do Compilador

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Código-Fonte → Análise Léxica → Análise Sintática → Análise Semântica → Geração de Código   `

### Definição de Gramática

A linguagem é especificada em **gramática livre de contexto**, com palavras-chave em português:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   programa → 'programa' ID ';' declaracoes 'inicio' comandos 'fimprograma'  declaracao → 'var' ID ':' tipo ';' | funcao | procedimento  tipo → 'inteiro' | 'real' | 'logico' | 'texto'  comando → atribuicao | condicional | repeticao | chamada_funcao   `

### Estrutura do Projeto

O projeto segue uma arquitetura modular dividida entre:

*   **parser/** – classes geradas pelo ANTLR
    
*   **compiler/** – núcleo do compilador (AST, semântica, símbolos)
    
*   **controller/** – endpoints da IDE web
    
*   **service/** – lógica de negócio
    
*   **resources/** – arquivos .easy, gramática .g4 e templates HTML
    

🧰 Tecnologias Utilizadas
-------------------------

CategoriaFerramenta**Backend**Spring Boot 3.x (Java 17+)**Frontend**Thymeleaf + JavaScript**Parser**ANTLR 4.x**Build**Maven 3.6+**Execução**JVM (bytecode Java)

🚀 Como Iniciar
---------------

### Pré-requisitos

*   **Java 17+**
    
*   **Maven 3.6+**
    
*   Navegador moderno para acesso ao IDE
    

### Instalação

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   git clone git@github.com:guileermio/Compilador_EasyLanguage.git  cd Compilador_EasyLanguage  mvn clean compile   `

### Execução

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   mvn spring-boot:run   `

Acesse a IDE em [http://localhost:8080](http://localhost:8080/)

💡 Exemplos de Uso
------------------

### 📝 Programa Básico

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   programa HelloWorld;  inicio      escrever("Olá, Mundo!");  fimprograma   `

### 🔁 Estruturas de Controle

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   programa LoopExample;  inicio      var i: inteiro;      var soma: inteiro;      soma = 0;      para i = 1 ate 10 faca          soma = soma + i;      fimpara      escrever("Soma de 1 a 10: ", soma);  fimprograma   `

### 🔢 Função Recursiva

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   funcao fatorial(n: inteiro): inteiro  inicio      se n <= 1 entao          retornar 1;      senao          retornar n * fatorial(n - 1);      fimse  fim   `

### 📦 Manipulação de Vetores

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   programa ArrayExample;  inicio      var numeros: vetor[10] de inteiro;      var i: inteiro;      var maior: inteiro;      para i = 0 ate 9 faca          ler(numeros[i]);      fimpara      maior = numeros[0];      para i = 1 ate 9 faca          se numeros[i] > maior entao              maior = numeros[i];          fimse      fimpara      escrever("Maior valor: ", maior);  fimprograma   `


👨‍💻 Autores
-------------

Projeto desenvolvido por estudantes da**Faculdade Engenheiro Salvador Arena**➡️ [Lista completa de colaboradores](https://chatgpt.com/c/AUTHORS)