import logging
from fastapi import FastAPI, Request
from mangum import Mangum

# Configure logging for AWS Lambda environment
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize FastAPI application
app = FastAPI(
    title="FastAPI Lambda",
    description="A FastAPI application running on AWS Lambda",
    version="1.0.0"
)

@app.get("/")
async def root(request: Request):
    """
    Root endpoint that returns a simple Hello World message.
    Returns:
        dict: A JSON response containing a welcome message
    """
    logger.info(f"Processing root endpoint request from {request.url}")
    try:
        return {"message": "Hello World"}
    except Exception as e:
        logger.error(f"Error processing request: {str(e)}")
        raise

# AWS Lambda handler
handler = Mangum(app, lifespan="off") 