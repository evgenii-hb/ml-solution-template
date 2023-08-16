"""Tests go here."""
import os

from change_lib_name.pipeline import inference_pipeline, train_pipeline


def test_train():
    """Dummy test for train."""
    ret = train_pipeline()
    os.remove("model.pkl")
    assert ret


def test_inference():
    """Dummy test for test."""
    train_pipeline()
    inference_pipeline()
    os.remove("model.pkl")
    assert True
