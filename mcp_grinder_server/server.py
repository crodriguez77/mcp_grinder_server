import os
import datetime
import logging
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
    server_url: AnyHttpUrl = AnyHttpUrl("http://localhost:8001")

    def __init__(self, **data):
        """Initialize settings with values from environment variables."""
        super().__init__(**data)

def main():
    print("Hello from mcp-grinder-server!")
    s = source_mod.customSource()
    pass_mod.passThrough(s)

    settings = ResourceServerSettings()
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

if __name__ == "__main__":
    main()