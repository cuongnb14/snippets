"""
Requirements:

locust==1.2.3

Run:
locust --host=http://localhost:8000/api/v2
locust --host=http://localhost:8000/api/v2 --no-web -c 100 -r 10
"""

from locust import HttpUser, task, between

class DemoUser(HttpUser):
    wait_time = between(5, 15)

    @task(2)
    def index(self):
        self.client.get("/")

    @task(1)
    def about(self):
        self.client.get("/about/")