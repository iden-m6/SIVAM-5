#!/bin/bash
# Script de inicialização rápida do servidor Flask

echo "🚀 RealTimeKin - Iniciando Servidor Web Flask"
echo "=============================================="
echo ""

# Diretório do projeto
cd /home/pebimu3/opensim-workspace/RealTimeKin

# Verificar dependências
echo "📦 Verificando dependências..."
pip3 list | grep -q Flask
if [ $? -ne 0 ]; then
    echo "⚠️  Flask não instalado. Instalando dependências..."
    pip3 install -r requirements_flask.txt
fi

# Obter IP
IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Dependências OK"
echo ""
echo "🌐 Servidor será iniciado em:"
echo "   Local:  http://localhost:5000"
echo "   Rede:   http://$IP:5000"
echo ""
echo "📱 Se estiver usando Access Point:"
echo "   AP:     http://192.168.4.1:5000"
echo ""
echo "💡 Pressione Ctrl+C para parar o servidor"
echo ""
echo "=============================================="
echo ""

# Iniciar servidor
python3 flask_server.py
