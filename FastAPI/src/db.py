from pymongo import MongoClient
from dotenv import load_dotenv
import os
import dns.resolver

load_dotenv()

# Configure DNS resolver to use Google DNS for better reliability
dns.resolver.default_resolver = dns.resolver.Resolver(configure=False)
dns.resolver.default_resolver.nameservers = ['8.8.8.8', '8.8.4.4']

MONGO_URI = os.getenv('MONGO_URI')

client = MongoClient(MONGO_URI)
db = client.neurograde

REQUIRED_COLLECTIONS = ["teachers", "students", "chats"]

def ensure_collections():
    existing = db.list_collection_names()
    for name in REQUIRED_COLLECTIONS:
        if name not in existing:
            db.create_collection(name)

ensure_collections()

teachers_collection = db.get_collection("teachers")
students_collection = db.get_collection("students")
chats_collection = db.get_collection("chats")