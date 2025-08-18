import os
import pandas as pd
import pytest

@pytest.fixture(autouse=True, scope="session")
def ensure_result_files():
    # Obtener la ruta absoluta del directorio del proyecto
    test_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(test_dir, '..'))
    results_dir = os.path.join(project_root, 'results')
    
    # Crear el directorio results si no existe
    os.makedirs(results_dir, exist_ok=True)
    
    # Crear los archivos de resultados vacíos
    for forced_type in ['multimodal', 'text', 'image']:
        path = os.path.join(results_dir, f"{forced_type}_results.csv")
        if not os.path.exists(path):
            # Crear un DataFrame con algunas filas de ejemplo
            df = pd.DataFrame({
                'Predictions': [0, 1, 2],
                'True Labels': [0, 1, 2]
            })
            df.to_csv(path, index=False) 