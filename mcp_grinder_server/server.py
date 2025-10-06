import os
import datetime
import logging
import argparse
from mcp_grinder_server import pass_mod
from mcp_grinder_server import source_mod

from typing import Any, Literal
from mcp.server.fastmcp.server import FastMCP
from pydantic import AnyHttpUrl
from pydantic_settings import BaseSettings, SettingsConfigDict

logger = logging.getLogger(__name__)

class ResourceServerSettings(BaseSettings):
    host: str = "localhost"
    port: int = 8001
    
    server_url: AnyHttpUrl = AnyHttpUrl(f"http://{host}:{port}")

    def __init__(self, **data):
        super().__init__(**data)

def main():
    print("Hello from mcp-grinder-server!")
    s = source_mod.customSource()
    pass_mod.passThrough(s)

    parser = argparse.ArgumentParser()
    parser.add_argument("host", default="localhost")
    parser.add_argument("port", default="8001")
    args = parser.parse_args()
    
    settings = ResourceServerSettings(
        host = args.host,
        port = args.port,
    )

    transport = "streamable-http"

    app = FastMCP(
        name="MCP Resource Server",
        instructions="Resource Server",
        host=settings.host,
        port=settings.port,
        debug=True
    )

    @app.tool()
    async def get_time() -> dict[str, Any]:
        now = datetime.datetime.now()

        return {
            "current_time": now.isoformat(),
            "timezone": "UTC",  # Simplified for demo
            "timestamp": now.timestamp(),
            "formatted": now.strftime("%Y-%m-%d %H:%M:%S"),
        }

    try:
        app.run(transport=transport)
        logger.info("Server stopped")
        return 0
    except Exception:
        logger.exception("Server error")
        return 1

def sum(x, y):
    return x + y;

if __name__ == "__main__":
    main()