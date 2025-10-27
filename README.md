# 🧩 EasyLanguage

O **EasyLanguage** é um projeto acadêmico que simula a criação completa de uma linguagem de programação própria, servindo como um **mini-compilador/interpretador**. Ele é um laboratório prático que integra conceitos de **Estruturas de Dados**, **Linguagens Formais e Autômatos** e **Compiladores**.

## 📖 Sumário
* [✨ Visão Geral](#-visão-geral)
* [🧠 Recursos da Linguagem](#-recursos-da-linguagem)
* [⚙️ Estrutura Técnica e Fases do Compilador](#-estrutura-técnica-e-fases-do-compilador)
* [🧰 Tecnologias Utilizadas](#-tecnologias-utilizadas)
* [🚀 Como Iniciar](#-como-iniciar)
* [💡 Exemplos de Uso](#-exemplos-de-uso)
* [👨‍💻 Autores](#-autores)

---

## ✨ Visão Geral

O objetivo principal do projeto é demonstrar o funcionamento interno de uma linguagem, desde a análise do código-fonte (`.easy`) até a sua execução.

### Principais Fases de Processamento

O EasyLanguage segue o fluxo de processamento completo de um compilador:

1.  **Análise Léxica:** Quebra o código-fonte em tokens (via `EasyLanguageLexer`).
2.  **Análise Sintática:** Constrói a **Árvore Sintática (Parse Tree)** a partir da gramática.
3.  **Análise Semântica:** Verifica tipos, escopo e coerência das operações.
4.  **Geração de Código Intermediário:** Cria uma lista de objetos `AbstractCommand`s.
5.  **Execução/Geração de Código Alvo:** Executa o programa (`EasyProgram`) ou gera código para linguagens como Java.

---

## 🧠 Recursos da Linguagem

O EasyLanguage implementa um conjunto expandido de funcionalidades, conforme a especificação do projeto.

### Tipos de Dados Suportados

[cite_start]A linguagem suporta **tipagem estática** e inclui os seguintes tipos[cite: 225]:

* **Numéricos:** `inteiro`, `real`
* **Texto:** `texto`, `caractere`
* [cite_start]**Lógico (Booleano):** `logico` (valores: `verdadeiro` e `falso`) [cite: 440]

### Estruturas de Controle Expandidas

A gramática (`EasyLanguage.g4`) implementa as seguintes estruturas, demonstrando controle de fluxo complexo:

* **Decisão Condicional:** `se (condicao) entao { comandos } senao { comandos }`.
* **Laço Enquanto (While):** `enquanto (condicao) faca { comandos }`.
* **Laço Para (For):** `para ID = inicio ate fim passo incremento faca { comandos }`.

### Funções e Modularização

O suporte a subprogramas permite modularização e gerenciamento de escopo:

* **Funções com Retorno:** Implementação com palavra-chave `retorna` e tipo de retorno explícito.
* **Procedimentos:** Funções sem valor de retorno (`vazio`).
* **Sistema de Chamadas:** Gerenciamento de pilha de chamadas e escopo de variáveis locais para funções.

### Análise Semântica Avançada (Extensão)

O projeto inclui funcionalidades críticas de análise semântica:

* **Verificação de Tipos:** Validação de compatibilidade em expressões e atribuições.
* **Verificação de Escopo:** Mecanismo para validar a acessibilidade e resolver conflitos de nomes (essencial para funções).
* **Operadores Lógicos:** Suporte aos operadores `e`, `ou`, `nao` para expressões booleanas complexas.

---

## ⚙️ Estrutura Técnica e Fases do Compilador

### Estruturas de Dados Internas

Estruturas fundamentais que dão suporte ao compilador:

* **`EasySymbolTable`**: Implementada como um `HashMap`, armazena variáveis, constantes e funções.
* **Lista de Comandos**: `ArrayList` de objetos que formam a representação intermediária para execução.
* **Pilha de Escopos**: Gerenciamento hierárquico de variáveis para suportar funções.
* **Árvore Sintática Abstrata (AST)**: Representação em árvore para facilitar análises e otimizações.

### Geração de Código

O projeto vai além da interpretação, implementando um *backend* que traduz o código EasyLanguage para o código alvo:

`Código-Fonte EasyLanguage → Parser/Semântica → Lista de Comandos → Gerador Java`

### Definição de Gramática (BNF/EBNF)

A gramática é definida no arquivo `EasyLanguage.g4` (ANTLR) e segue regras livres de contexto.

```BNF
programa: 'programa' ID (declaracao)* 'inicio' bloco 'fim;'
declaracao: declaravar | declarafuncao | declaraconst
tipo: 'inteiro' | 'real' | 'texto' | 'caractere' | 'logico' | 'vetor'
cmd: cmdleitura | cmdescrita | cmdattrib | cmdselecao | cmdrepeticao | cmdfor | cmdretorno | cmdchamada

cmdrepeticao: 'enquanto' '(' expr_logica ')' 'faca' '{' (cmd)* '}'

cmdfor: 'para' ID '=' expr 'ate' expr ('passo' expr)? 'faca' '{' (cmd)* '}'

declarafuncao: (tipo | 'vazio') 'funcao' ID '(' (parametros)? ')' 'inicio' bloco 'fim' ';'
```

## 🧰 Tecnologias Utilizadas

- **Backend**: Spring Boot 3.x (Java 17+)
- **Frontend**: Thymeleaf + JavaScript
- **Parser Generator**: ANTLR 4.x
- **Build Tool**: Maven 3.6+
- **Target Platform**: JVM (bytecode Java)

## 🚀 Como Iniciar

### Pré-requisitos

- Java 17+
- Maven 3.6+

### Instalação

```bash
git clone git@github.com:guileermio/Compilador_EasyLanguage.git
cd Compilador_EasyLanguage
mvn clean compile
```

### Execução

```bash
mvn spring-boot:run
```

Acesse a IDE em http://localhost:8080 para testar a EasyLanguage.

## 💡 Exemplos de Uso

### 📝 Programa Básico com Entrada/Saída

```bash
programa Calculadora;
inteiro a, b;
logico status;

inicio
    leia(a);
    leia(b);
    status = a > b;
    escreva("A é maior que B?", status);
fim;
```

### 🔁 Estruturas de Controle (Loop Para e Condicional)

```bash
programa LoopExample;
inteiro i;
inteiro soma;

inicio
    soma = 0;
    // Loop de 1 a 10, passo 2
    para i = 1 ate 10 passo 2 faca
        soma = soma + i;
    fimpara

    se soma > 20 entao
        escreva("Soma é grande!");
    senao
        escreva("Soma é pequena.");
    fimse
fim;
```

### 🔢 Função e Retorno

```bash
inteiro funcao fatorial(n: inteiro)
inicio
    se n <= 1 entao
        retorna 1;
    senao
        retorna n * fatorial(n - 1);
    fimse
fim;

programa FuncaoExample;
inteiro resultado;

inicio
    resultado = fatorial(5);
    escreva("Fatorial de 5 é: ", resultado);
fim;
```

## 👨‍💻 Autores

Projeto desenvolvido por estudantes da**Faculdade Engenheiro Salvador Arena**

- Adriana Kaori Kakazu - RA: 082220004
- Beatriz dos Santos Buglio - RA: 082220028
- Tainara do Nascimento Casimiro - RA: 082220011
