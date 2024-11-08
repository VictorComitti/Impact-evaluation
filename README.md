# Modelo de Controle Sintético

## Introdução

### O Modelo

O instrumento utilizado para avaliar o impacto do Programa de Fortalecimento do Sistema Único de Saúde de São Bernardo do Campo é o **Método de Controle Sintético (MCS)**. Proposto por Abadie & Gardeazabal (2003) e Abadie, Diamond & Hainmueller (2010), o MCS tem sido amplamente utilizado nas ciências sociais aplicadas para estimar os efeitos de políticas públicas em estudos de caso comparativo. O objetivo principal destes modelos é comparar os valores de uma variável de interesse em uma unidade tratada após a implementação de uma política pública com os valores da mesma variável em um grupo de controle formado por unidades próximas que não sofreram intervenção.

A ideia central do MCS é que uma média ponderada de várias unidades de controle pode reproduzir as características da unidade tratada melhor do que qualquer unidade isolada. Os pesos de cada unidade do grupo doador na unidade sintética são determinados de forma a reproduzir da melhor forma possível a trajetória da variável de interesse na unidade tratada durante o período pré-tratamento.

A escolha do vetor ótimo de pesos é realizada com o auxílio de variáveis preditoras, que ajudam a explicar a variável de interesse. O procedimento consiste em selecionar covariáveis capazes de explicar a variável de interesse e, em seguida, determinar os pesos que minimizam a distância entre as variáveis preditoras na unidade tratada e nas unidades de controle no período pré-tratamento. Assim, a magnitude do efeito do tratamento é dada pela diferença entre os valores observados da variável de interesse na unidade tratada durante o período pós-tratamento e a média ponderada dos valores observados nas unidades de controle:

$$
Y_{T} - \sum_{i} W_{i} Y_{C_{i}}
$$

onde $Y_{T}$ é o valor da variável de interesse na unidade tratada, $Y_{C_{i}}$ o valor da mesma variável nas unidades não tratadas e $W_{i}$ os pesos de cada elemento do grupo controle na unidade sintética.

De acordo com Abadie (2021), o Estimador de Controle Sintético tem vantagens em relação a técnicas de regressão, como a transparência do cenário contrafactual e a interpretabilidade, uma vez que o efeito do tratamento pode ser visualizado graficamente.

## Estratégia Empírica

Foram consideradas duas estratégias empíricas para ajustar o MCS aos treze indicadores de impacto e resultados previstos no projeto:

1. Ajustar o MCS para todos os indicadores utilizando a mesma coorte sintética e os mesmos indicadores de recursos (covariáveis);
2. Ajustar o MCS considerando coortes e covariáveis únicas para cada indicador.

A primeira abordagem é preferível por resultar em uma análise mais interpretável, mas enfrenta o desafio de encontrar uma coorte que aproxime todos os indicadores. Conforme Abadie (2003), a coorte ideal deve ser composta por unidades semelhantes à tratada e que não tenham sido submetidas a tratamentos similares. Efeitos de transbordamento (spillover) foram considerados e julgados pouco relevantes.

O MCS permite alguma discricionariedade na escolha das unidades do grupo doador. É importante que a unidade tratada e as de controle sejam semelhantes em atributos observados. Caso fatores não observados influenciem a variável de interesse, o MCS pode produzir estimativas viesadas. Abadie (2020) recomenda uma seleção cuidadosa para evitar problemas de sobreajustamento (overfitting).

Para este estudo, foram consideradas 40 cidades da Região Metropolitana de São Paulo como unidades doadoras. A seleção seguiu os seguintes passos:

1. Ajustamos o MCS para todos os indicadores sem restrições nas unidades doadoras, estabelecendo um benchmark.
2. Filtramos os municípios com maior peso em cada coorte.
3. Agregamos esses municípios para formar um conjunto final.

Após essa seleção, a coorte final inclui: Barueri, Biritiba-Mirim, Cotia, Diadema, Ferraz de Vasconcelos, Franco da Rocha, Itapecerica da Serra, Mauá, Mogi das Cruzes, Osasco, Poá, Ribeirão Pires, Santa Bárbara d’Oeste, Santana de Parnaíba, São Caetano do Sul e Santo André.

A escolha das covariáveis considerou a disponibilidade de dados para todos os municípios. As variáveis de recursos incluídas são: cobertura do SUS, despesas per capita com saúde, densidade de leitos, densidade de médicos, e densidade de UBS. Incluímos também variáveis demográficas e socioeconômicas, como a proporção da população com mais de 30 anos, IDH e renda per capita. Os detalhes da coleta estão no Produto XX.

Além das variáveis de recursos, adicionamos valores defasados da variável de interesse, conforme recomendado por Ferman, Pinto & Possebom (2020), para garantir a robustez assintótica do modelo.

## Resultados e Discussão

A estimação do MCS foi realizada com o pacote `synth` do R (Abadie, A., Diamond, A., Hainmueller, J., 2011). O código para o ajuste da variável `cob_sus` está disponível neste projeto.

## Referências

- Abadie, A., & Gardeazabal, J. (2003). *The Economic Costs of Conflict: A Case Study of the Basque Country*. American Economic Review.
- Abadie, A., Diamond, A., & Hainmueller, J. (2010). *Synthetic Control Methods for Comparative Case Studies: Estimating the Effect of California’s Tobacco Control Program*. Journal of the American Statistical Association.
- Abadie, A. (2021). *Using Synthetic Controls: Feasibility, Data Requirements, and the Use of Covariates*. Econometrica.
- Ferman, B., Pinto, C., & Possebom, V. (2020). *Simulation Evidence on the Use of Lagged Dependent Variables in Synthetic Controls*. Journal of Applied Econometrics.
