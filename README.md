Desenvolver o aplicativo Previsão do Tempo, que dado uma cidade exibe as últimas previsões do clima (5 dias) e a poluição do ar. Para obter os dados deve ser utilizado a api open weather map, conforme a documentação no link: https://openweathermap.org/api

Dentre os serviços da API deverão ser utilizados três:
- Geocoding: Necessária para buscar a latitude e longitude de uma cidade.
     Entrada: Cidade
     Resultado: Latitude e Longitude
     Link de uso: https://openweathermap.org/api/geocoding-api

- Forecast: Retorna a previsão de 5 dias.
    Entrada: Latitude e Longitude
    Resultado: 5 previsões contendo informações de temperatura, situação (nublado, chuvoso, ...), humidade, etc.
    Link do uso: Link: https://openweathermap.org/forecast5

- Air Pollution: Retorna informações da qualidade do ar.
    Entrada: Latitude e Longitude    Resultado: Componentes e qualidade do ar. Qualidade do ar tem 5 categorias: 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
    Link do uso: https://openweathermap.org/api/air-pollution

Para utilizar a API é necessário criar uma conta gratuita e gerar uma API Key que será utilizado na utilização dos serviços.

O aplicativo possui 2 telas:
- Tela de Previsão de Tempo (Tela de Home).
- Tela de Qualidade do Ar.

Ao iniciar o aplicativo, a Tela de Home apresenta um campo para o usuário digitar a cidade e um botão de busca para acessar a API. Como resultado, deve-se apresentar as 5 previsões retornadas do serviço de forecast informando os seguintes dados: data, temperatura máxima, temperatura mínima, escala da temperatura (Celsius, Kelvin ou Fahrenheit) e situação do clima (ver informações do campo "weather" do arquivo JSON da resposta da chamada). 

Também deve ser acrescentado uma botão de qualidade de ar no resultado da busca da previsão de clima. Ao clicar no botão, o usuário será enviado para a Tela de Qualidade do Ar que apresentará as seguintes informações retornadas do serviço air pollution: índice de qualidade do ar (1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.) e as informações de concentração de cada componente retornados da api, como, CO2, NO, NO2, O3, SO2, NHO3, etc.

A construção do layout do app é livre e as chamadas da api podem ser tratadas com Future classes.

Deve-se entregar o arquivo compactado contendo o projeto flutter e um print da tela rodando ele com algum simulador (android, web ou desktop).

Arquivos na pasta do projeto flutter:
- Pasta lib;
- Pastas com images (caso utilizado);
- Arquivo pubspec.yaml.