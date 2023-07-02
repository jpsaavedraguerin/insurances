from .main import app
from fastapi.testclient import TestClient

client = TestClient(app)


def test_insurances_by_id():
    response = client.get("/")
    assert response.status_code == 200
    #assert response.json() == {}
