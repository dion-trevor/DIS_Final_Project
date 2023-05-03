from locust import HttpUser, task, between

class WebsiteTestUser(HttpUser):
    wait_time = between(0.5, 3.0)

    @task(1)
    def helloworld(self):
        self.client.get("http://192.168.49.2:31477")
