#!/data/data/com.termux/files/usr/bin/bash

echo -e "\n😼 PATHFACE ALL-AT-ONCE LAUNCH SEQUENCE INITIATED\n"

# Define directories
BACKEND_DIR=~/pathface/backend
FRONTEND_DIR=~/pathface/frontend
LOGFILE=$BACKEND_DIR/backend.log

# 🧹 Kill anything on ports 8000 and 8080 (safe for Termux)
echo "🛑 Cleaning up ports..."
kill -9 $(lsof -t -i:8000) 2>/dev/null
kill -9 $(lsof -t -i:8080) 2>/dev/null

# 🚀 Launch backend
echo "🚀 Launching FastAPI backend..."
cd $BACKEND_DIR
nohup uvicorn main:app --host 0.0.0.0 --port 8000 > $LOGFILE 2>&1 &
sleep 2

# 🎨 Serve frontend
echo "🌐 Launching static frontend server..."
cd $FRONTEND_DIR
nohup python3 -m http.server 8080 > /dev/null 2>&1 &
sleep 2

# 📡 Test backend
echo "📡 Testing backend endpoint..."
RESPONSE=$(curl -s http://127.0.0.1:8000/endpoint)
if [[ $RESPONSE == *"ONLINE"* ]]; then
    echo "✅ Backend is UP at http://127.0.0.1:8000"
else
    echo "❌ Backend check failed! Response: $RESPONSE"
fi

# 🌍 Open frontend in browser (Termux-friendly)
if command -v termux-open-url >/dev/null 2>&1; then
    echo "🌍 Opening frontend: http://127.0.0.1:8080"
    termux-open-url http://127.0.0.1:8080
else
    echo "📎 Open this manually: http://127.0.0.1:8080"
fi

# 📄 Tail logs
echo -e "\n📄 Tail backend.log:\n"
tail -n 10 $LOGFILE
