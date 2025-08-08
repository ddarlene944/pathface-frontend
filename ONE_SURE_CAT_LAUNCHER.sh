#!/data/data/com.termux/files/usr/bin/bash

echo "😼 PATHFACE ONE-SURE-CAT PACKAGE INITIATING..."

cd "$(dirname "$0")"

# Ensure backend log directory exists
mkdir -p backend

# 1. Start backend if not running
if ! lsof -i :8001 > /dev/null; then
  echo "🚀 Starting FastAPI backend..."
  nohup uvicorn main:app --host 0.0.0.0 --port 8001 > backend/backend.log 2>&1 &
else
  echo "✅ Backend already running."
fi

# 2. Start frontend if not running
if ! lsof -i :8000 > /dev/null; then
  echo "🎨 Starting Frontend (Python HTTP)..."
  nohup python3 -m http.server 8000 > frontend/frontend.log 2>&1 &
else
  echo "✅ Frontend already running."
fi

# 3. Display status
sleep 2
echo "🌐 Visit frontend at: http://127.0.0.1:8000"
echo "📡 Backend API is at: http://127.0.0.1:8001"

echo "✅ ONE-SURE-CAT LAUNCHED. Enjoy your Kingdom. 👑🔑⚡"
