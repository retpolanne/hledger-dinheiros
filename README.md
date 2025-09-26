# Hledger – controle de dinheiros

**Disclaimer: o código publicado aqui é de autoria minha, Anne Isabelle Macedo, e não
contém propriedade intelectual da Nubank**

Esse é um repo que facilita o controle financeiro usando [hledger](https://hledger.org).

Com ele, é possível categorizar finanças de forma automatizada a partir de algumas regras.

*YMMV (your mileage may vary)* - esse repo foi feito com base no Nubank, iCloud e no
macOS. Se quiser, pode fazer um fork ou abrir um PR adicionando outros formatos de bancos e etc. 

## Passos

### 0 – pegue o extrato do Nubank no app

Eu fiz a seguinte automação no app Shortcuts do meu iPhone pra copiar o extrato do
Nubank automaticamente para meu drive do iCloud. Eu mantenho meus extratos no diretório `~/Documents/extrato_nu/`

![image](https://github.com/user-attachments/assets/27b6ee12-b20c-4692-9f67-493219b5f467)

![image](https://github.com/user-attachments/assets/17263b6b-8475-4fe7-91fe-707b4ea6ce99)

É possível também exportar a fatura do cartão de crédito (fechada) como CSV. 

![image](https://github.com/user-attachments/assets/716039fa-fe4b-4767-b0df-0545fb39d79e)

![image](https://github.com/user-attachments/assets/7a9b9747-d438-4730-a107-04fc7d6c6744)

Por fim, fiz a seguinte automação no Shortcuts no iPhone. 

![image](https://github.com/user-attachments/assets/333c0451-9b1e-4a31-9fdb-f4bd205de1f7)

![image](https://github.com/user-attachments/assets/f6206344-e41d-4f33-b148-49e72398b05c)



### 1 – clone esse repo e rode o make init

``` sh
make init
```

Isso vai criar o arquivo private.rules e instalar o Hledger usando Brew.
Leia as instruções para o seu sistema operacional para instalar o Hledger.

### 2 – escreva regras

Abra o arquivo `private.rules` e escreva as regras que você precisa :) 

Exemplos:

```
if OXXO
EXTRA
  comment mercado:
  account2 expenses:mercado

if UBER
  account2 expenses:transporte
  comment uber:
  
if NET SERVICOS
CLARO
  account2 expenses:servicos
  comment internet-telefonia:
```

Leia [essa doc](https://hackage.haskell.org/package/hledger-lib-1.3/src/doc/hledger_csv.5.txt) para mais regras. [Aqui](https://hledger.org/1.29/hledger.html) também tem mais informação.

### 3 – make import

``` sh
make import
```

### 4 – confira o hledger para ajustar suas regras

``` sh
hledger print | grep unknown -B 2
# Ou a partir de uma determinada data
hledger print -p "2025-08-01 to today" | grep unknown -B 2
```

## Hledger tips and tricks

### Vendo payees – pra quem eu paguei ou de quem eu recebi

``` sh
hledger payees
```

### Vendo todas as transações feitas para a Uber

``` sh
hledger print --pivot uber tag:uber
```

### Organizando transações

Eu organizo minhas transações pessoais assim: 

```
if NomeDaPsicologa
   comment cat:saude, kind:psicoterapia
   account2 expenses:saude
```

E assim eu posso filtrar: 

``` sh
hledger print --pivot cat tag:kind=psicoterapia
```

Eu tenho também uma regra em `common.rules` em que todas as transações são categorizadas como `unknown`, facilitando a conferência delas no hledger.

``` sh
hledger print --pivot cat tag:cat=unknown
```
