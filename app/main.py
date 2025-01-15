from fastapi import FastAPI

app = FastAPI(title="Ping-Pong API")

@app.get("/ping")
async def ping():
    return {"message": "pong", "time": datetime.now().isoformat()}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 