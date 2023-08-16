"""Return version of package."""
import pickle
import time

from .model import DummyModel


def train_pipeline() -> bool:
    """Train a model and save to a storage."""
    print("Reading data...", end="")
    time.sleep(0.5)  # no data actually being read
    print("Done")

    model = DummyModel()
    print("Training model...", end="")
    model.fit()  # no input data, just an example
    print("Done")

    print("Saving model...", end="")
    with open("model.pkl", "wb") as fm:
        pickle.dump(model, fm)
    print("Done")

    return True


def inference_pipeline() -> bool:
    """Toy inference pipeline."""
    print("Reading data...", end="")
    input_data: list[list[float]] = [[1, 2, 3], [1, 2, 3], [3, 2, 1]]
    time.sleep(0.5)  # no data actually being read
    print("Done")

    print("Reading model...", end="")
    with open("model.pkl", "rb") as fm:
        model: DummyModel = pickle.load(fm)
    time.sleep(0.3)
    print("Done")

    print("Predict...", end="")
    predict: list[float] = model.predict(input_data)
    time.sleep(0.3)
    print("Done")

    print(predict)
    return True
