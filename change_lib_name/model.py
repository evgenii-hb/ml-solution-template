"""Return version of package."""
import time
from typing_extensions import Self


class DummyModel:
    """Very simple linear models for demonstration purposes."""

    def __init__(self) -> None:
        self.weights: list[float] = []

    def fit(self) -> Self:
        """Fit model weights."""
        time.sleep(0.5)
        self.weights = [0.1, 0.2, 0.3]
        return self

    def predict(self, input_data: list[list[float]]) -> list[float]:
        """Predict."""
        output: list[float] = []
        for sample in input_data:
            result = 0.0
            for elem, w in zip(sample, self.weights):
                result += elem * w
            output.append(result)
        return output
