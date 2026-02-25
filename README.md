<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Robô Seguidor de Linha com Desvio de Obstáculos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f6f8;
            color: #333;
        }
        h1, h2, h3 {
            color: #0a3d62;
        }
        code {
            background-color: #eaeaea;
            padding: 3px 6px;
            border-radius: 4px;
        }
        .section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        ul {
            line-height: 1.6;
        }
    </style>
</head>
<body>

    <h1>🚗 Robô Seguidor de Linha com Desvio Inteligente de Obstáculos</h1>

    <div class="section">
        <h2>📌 Visão Geral do Projeto</h2>
        <p>
            Este projeto implementa um robô autônomo capaz de seguir linha no solo utilizando 
            sensores infravelhos (IR) e, simultaneamente, detectar e desviar de obstáculos 
            utilizando um sensor de distância a laser VL53L0X (ToF).
        </p>
        <p>
            O sistema também utiliza um expansor de portas I2C (MCP23017) para gerenciar 
            sensores e LEDs indicadores, permitindo maior organização e escalabilidade do hardware.
        </p>
    </div>

    <div class="section">
        <h2>🔧 Componentes Utilizados</h2>
        <ul>
            <li><strong>Microcontrolador</strong> (ESP32 / Arduino compatível)</li>
            <li><strong>Expansor I2C MCP23017</strong> – Controle de sensores e LEDs</li>
            <li><strong>Sensor VL53L0X</strong> – Sensor de distância a laser (Time of Flight)</li>
            <li><strong>8 Sensores IR</strong> – Detecção de linha</li>
            <li><strong>4 Motores DC</strong> – Locomoção do robô</li>
            <li><strong>8 LEDs</strong> – Sinalização de direção e status</li>
        </ul>
    </div>

    <div class="section">
        <h2>⚙️ Funcionamento do Sistema</h2>

        <h3>1️⃣ Inicialização (Setup)</h3>
        <ul>
            <li>Configuração dos pinos dos motores como saída.</li>
            <li>Inicialização da comunicação I2C (<code>Wire.begin()</code>).</li>
            <li>Configuração do MCP23017.</li>
            <li>Definição dos sensores IR como entrada (Porta A).</li>
            <li>Definição dos LEDs como saída (Porta B).</li>
            <li>Inicialização do sensor VL53L0X com endereço personalizado (0x30).</li>
        </ul>

        <h3>2️⃣ Sistema de Iluminação (LEDs)</h3>
        <p>Os LEDs indicam o comportamento atual do robô:</p>
        <ul>
            <li><strong>Frente:</strong> Movimento reto</li>
            <li><strong>Trás:</strong> Parado</li>
            <li><strong>Seta esquerda:</strong> Curva à esquerda</li>
            <li><strong>Seta direita:</strong> Curva à direita</li>
        </ul>

        <h3>3️⃣ Controle de Movimento</h3>
        <p>
            A função <code>mover()</code> controla individualmente os 4 motores 
            definindo o sentido de rotação (HIGH/LOW).
        </p>

        <ul>
            <li><strong>andarReto()</strong> → Todos motores giram para frente</li>
            <li><strong>virarEsquerda()</strong> → Motores alternados para rotação</li>
            <li><strong>virarDireita()</strong> → Rotação no sentido oposto</li>
            <li><strong>parar()</strong> → Todos motores desligados</li>
        </ul>

        <h3>4️⃣ Desvio de Obstáculo</h3>
        <p>
            O sensor VL53L0X mede continuamente a distância frontal.
            Caso um obstáculo seja detectado a menos de <strong>150 mm</strong>:
        </p>

        <ol>
            <li>O robô para</li>
            <li>Gira para a direita</li>
            <li>Avança para contornar o obstáculo</li>
        </ol>
    </div>

    <div class="section">
        <h2>📏 Lógica de Seguimento de Linha</h2>

        <p>
            O sistema utiliza 8 sensores IR para identificar a posição da linha.
        </p>

        <ul>
            <li>Sensores centrais ativos → Anda reto</li>
            <li>Sensores à esquerda ativos → Vira à esquerda</li>
            <li>Sensores à direita ativos → Vira à direita</li>
            <li>Nenhum sensor detecta linha → Robô para</li>
        </ul>

        <p>
            Essa lógica permite correção contínua de trajetória com resposta rápida 
            (delay de 30ms entre leituras).
        </p>
    </div>

    <div class="section">
        <h2>🧠 Arquitetura do Sistema</h2>
        <ul>
            <li><strong>Controle Principal:</strong> Loop contínuo</li>
            <li><strong>Prioridade 1:</strong> Detecção de obstáculo</li>
            <li><strong>Prioridade 2:</strong> Seguimento de linha</li>
            <li><strong>Feedback Visual:</strong> LEDs indicam ação atual</li>
        </ul>
    </div>

    <div class="section">
        <h2>🚀 Características Técnicas</h2>
        <ul>
            <li>Leitura contínua do sensor ToF</li>
            <li>Expansão de GPIO via I2C</li>
            <li>Sistema modular (funções separadas por responsabilidade)</li>
            <li>Lógica de decisão baseada em prioridade</li>
            <li>Tempo de resposta rápido (30ms)</li>
        </ul>
    </div>

    <div class="section">
        <h2>📌 Possíveis Melhorias Futuras</h2>
        <ul>
            <li>Controle de velocidade via PWM</li>
            <li>Implementação de PID para seguimento mais preciso</li>
            <li>Mapeamento inteligente de obstáculos</li>
            <li>Interface Web para monitoramento remoto</li>
        </ul>
    </div>

    <footer>
        <p><strong>Autor:</strong> Matheus Ziravello</p>
        <p>Projeto acadêmico e de desenvolvimento em sistemas embarcados.</p>
    </footer>

</body>
</html>
