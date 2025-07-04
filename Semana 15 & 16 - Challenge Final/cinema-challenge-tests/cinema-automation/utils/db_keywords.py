from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
from pymongo import MongoClient
from bson.objectid import ObjectId
import bcrypt
import os

# Carrega .env se estiver local
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

# Conexão MongoDB
MONGO_URI = os.getenv("MONGO_URI")
if not MONGO_URI:
    raise ValueError("❌ MONGO_URI não definida. Configure no .env ou GitHub Secrets.")

client = MongoClient(MONGO_URI)
db = client["cinemaapp"]
users = db["users"]

@keyword("Remover Usuário do Banco de Dados")
def remove_user(email):
    result = users.delete_many({"email": email})
    msg = f"🧹 Usuário(s) com email '{email}' removido(s): {result.deleted_count}"
    print(msg)
    BuiltIn().log(msg, level="INFO")

@keyword("Inserir Usuário no Banco de Dados")
def insert_user(name, email, password):
    hashed_password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt(8))

    doc = {
        "name": name,
        "email": email,
        "password": hashed_password
    }

    result = users.insert_one(doc)

    # Armazena os dados para uso posterior no Robot
    BuiltIn().set_suite_variable("${TEST_USER_EMAIL}", email)
    BuiltIn().set_suite_variable("${TEST_USER_PASSWORD}", password)

    msg = f"✅ Usuário '{email}' inserido com ID: {result.inserted_id}"
    print(msg)
    BuiltIn().log(msg, level="INFO")