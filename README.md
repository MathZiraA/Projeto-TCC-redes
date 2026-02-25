Este código implementa o controle de um robô móvel autônomo capaz de seguir uma linha no solo e desviar automaticamente de obstáculos frontais, operando em tempo real. O sistema integra sensores infravermelhos para navegação, um sensor de distância a laser (Time of Flight) para detecção de obstáculos, quatro motores DC para locomoção e LEDs para sinalização do estado operacional.

A lógica de controle é baseada em prioridade: a detecção de obstáculos tem precedência sobre o seguimento de linha, garantindo segurança durante o deslocamento. Sempre que um objeto é identificado abaixo da distância limite configurada, o robô interrompe o movimento e executa uma manobra de desvio antes de retomar a navegação normal.

Na ausência de obstáculos, o algoritmo analisa continuamente a posição da linha em relação aos sensores e ajusta a trajetória por meio de correções direcionais ou avanço reto. Caso a linha não seja detectada, o sistema entra em estado de parada.

A solução apresenta estrutura modular, resposta rápida e integração eficiente entre sensores e atuadores, caracterizando um sistema embarcado robusto voltado para aplicações em robótica móvel autônoma e desenvolvimento técnico profissional.
