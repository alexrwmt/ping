from fastapi import FastAPI
from datetime import datetime

app = FastAPI(title="Ping-Pong API")

@app.get("/ping")
async def ping():
    return {"message": "pong", "time": datetime.now().isoformat()}

def start_application():
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

if __name__ == "__main__":
    start_application() 