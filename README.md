Robô Autônomo Seguidor de Linha com Desvio de Obstáculos
Descrição Geral

O código implementa o controle completo de um robô móvel autônomo capaz de seguir uma linha no solo e, simultaneamente, detectar e desviar de obstáculos frontais. O sistema integra sensores de linha, sensor de distância a laser, controle de quatro motores DC e sinalização visual por LEDs, operando de forma contínua e em tempo real.

O comportamento do robô é baseado em prioridade lógica: a detecção de obstáculos tem precedência sobre o seguimento de linha, garantindo segurança operacional.

Funcionamento do Sistema
1. Modo de Operação Geral

O robô executa um ciclo contínuo de:

Leitura da distância frontal.

Verificação de presença de obstáculo.

Caso não haja obstáculo, execução da lógica de seguimento de linha.

Atualização do movimento e da sinalização visual.

Repetição do processo com baixa latência.

Esse ciclo garante resposta rápida a mudanças no ambiente.

2. Detecção e Desvio de Obstáculos

O sistema monitora constantemente a distância frontal utilizando um sensor de medição a laser (Time of Flight).

Quando um objeto é detectado a menos de 150 mm:

O robô interrompe o movimento.

Executa uma manobra de rotação para a direita.

Avança por um intervalo controlado para contornar o obstáculo.

Retorna automaticamente ao modo normal de operação.

Essa rotina possui prioridade máxima, interrompendo temporariamente qualquer ação de seguimento de linha.

3. Seguimento de Linha

Na ausência de obstáculos, o robô utiliza oito sensores infravermelhos posicionados na parte inferior para identificar a presença da linha no solo.

Com base na posição da linha detectada:

Se a linha estiver centralizada, o robô avança em linha reta.

Se a linha estiver deslocada para a esquerda, o robô corrige a trajetória girando à esquerda.

Se estiver deslocada para a direita, corrige girando à direita.

Caso a linha não seja detectada, o robô interrompe o movimento.

A correção é contínua e ocorre em intervalos curtos, garantindo estabilidade e acompanhamento eficiente da trajetória.

4. Controle de Movimento

O sistema controla quatro motores DC de forma independente, permitindo:

Movimento para frente.

Rotação controlada à esquerda.

Rotação controlada à direita.

Parada total.

As manobras são realizadas por meio da combinação lógica dos sentidos de rotação dos motores.

5. Sinalização Visual

O robô utiliza LEDs para indicar seu estado operacional:

Indicação frontal durante avanço.

Indicação traseira quando parado.

Indicação lateral correspondente à direção de giro.

Essa sinalização fornece feedback visual imediato sobre o comportamento atual do sistema.

Arquitetura de Decisão

A lógica de controle segue uma estrutura hierárquica:

Segurança (desvio de obstáculo).

Navegação (seguimento de linha).

Estado de segurança (parada).

Essa abordagem garante previsibilidade, robustez e segurança no deslocamento.

Características Técnicas do Sistema

Operação em tempo real com baixa latência.

Integração simultânea de sensores digitais e sensor de distância.

Controle direto de múltiplos motores.

Expansão de entradas e saídas via comunicação I2C.

Estrutura modular e organizada.

Sistema determinístico baseado em regras.
