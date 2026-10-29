# Controle do Botão via Web

Este documento explica como usar o controle remoto do botão IMU via requisições HTTP.

## Funcionalidades

O servidor web permite controlar o botão de gravação e seu modo de LED remotamente através de requisições HTTP simples.

## Endpoints Disponíveis

### 1. Interface Web (Navegador)
```
http://localhost:8080/
```
Abre uma interface HTML simples com botões para controle.

### 2. Pressionar o Botão
```
GET http://localhost:8080/button/press
```
Simula um pressionamento do botão físico (inicia/para gravação).

**Resposta:**
```json
{"status": "pressed", "message": "Botao acionado"}
```

### 3. Alterar Modo do LED

#### Desligar LED
```
GET http://localhost:8080/button/mode/off
```

#### LED Piscando (esperando iniciar)
```
GET http://localhost:8080/button/mode/blink
```

#### LED Sólido (gravando)
```
GET http://localhost:8080/button/mode/solid
```

**Resposta:**
```json
{"status": "ok", "mode": "off|blink|solid"}
```

### 4. Verificar Status
```
GET http://localhost:8080/button/status
```

**Resposta:**
```json
{"pressed": false, "mode": null}
```

## Exemplos de Uso

### Via Navegador
Simplesmente acesse `http://localhost:8080/` e use os botões da interface.

### Via curl (terminal)
```bash
# Pressionar o botão (iniciar/parar gravação)
curl http://localhost:8080/button/press

# Mudar modo do LED para piscando
curl http://localhost:8080/button/mode/blink

# Mudar modo do LED para sólido
curl http://localhost:8080/button/mode/solid

# Desligar LED
curl http://localhost:8080/button/mode/off

# Ver status atual
curl http://localhost:8080/button/status
```

### Via Python
```python
import requests

# Pressionar o botão
response = requests.get('http://localhost:8080/button/press')
print(response.json())

# Mudar modo
requests.get('http://localhost:8080/button/mode/blink')

# Ver status
status = requests.get('http://localhost:8080/button/status').json()
print(status)
```

### Via JavaScript (web app)
```javascript
// Pressionar o botão
fetch('http://localhost:8080/button/press')
  .then(response => response.json())
  .then(data => console.log(data));

// Mudar modo
fetch('http://localhost:8080/button/mode/solid');

// Ver status
fetch('http://localhost:8080/button/status')
  .then(response => response.json())
  .then(data => console.log(data));
```

## Configuração de Porta

Por padrão, o servidor roda na porta **8080**. Para alterar, edite o arquivo `workers.py`:

```python
# Procure por esta linha na função readIMU:
web_server = start_web_server(port=8080)  # Mude para a porta desejada
```

## Acesso Remoto

Para acessar de outro computador na mesma rede:

1. Descubra o IP do Raspberry Pi:
```bash
hostname -I
```

2. Acesse de outro dispositivo usando o IP:
```
http://192.168.X.X:8080/
```

## Notas Importantes

- O servidor web só é iniciado quando **não** está em modo offline (`fake_real_time = False`)
- O servidor roda em uma thread daemon separada, não interfere na coleta de dados
- Os logs HTTP são silenciados para não poluir a saída do terminal
- O servidor aceita conexões de qualquer IP (`0.0.0.0`), permitindo acesso remoto na rede local

## Integração com Outros Sistemas

Este servidor pode ser facilmente integrado com:
- Aplicativos móveis
- Scripts de automação
- Dashboards web
- Sistemas de controle laboratorial
- IoT e home automation (Home Assistant, Node-RED, etc.)
