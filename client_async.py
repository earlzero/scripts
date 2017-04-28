import aiohttp
import asyncio
import async_timeout

addresses = ["http://localhost:8000/1", "http://localhost:8000/2"]

async def fetch(session, url):
    with async_timeout.timeout(10):
        async with session.get(url) as response:
            return await response.text()

async def fetch_all(addresses):
    async with aiohttp.ClientSession(loop=loop) as session:
        
        tasks = list(map(lambda url: asyncio.ensure_future(fetch(session, url)), addresses))
        responses = await asyncio.gather(*tasks)
        return responses
loop = asyncio.get_event_loop()
future = asyncio.ensure_future(fetch_all(addresses))
loop.run_until_complete(future)
print(",".join(future.result()))
