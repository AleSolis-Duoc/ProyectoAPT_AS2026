from sqlalchemy import Column, Integer, String, Text, Boolean
from sqlalchemy import DateTime
from sqlalchemy.sql import func

from database import Base


class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True)
    nombre = Column(String(100), nullable=False)
    apellido = Column(String(100), nullable=False)
    email = Column(String(150), unique=True, nullable=False)
    password = Column(Text, nullable=False)
    telefono = Column(String(20))
    tipo_usuario = Column(String(15), nullable=False)
    fecha_registro = Column(DateTime, server_default=func.now())


class Trabajador(Base):
    __tablename__ = "trabajadores"

    id = Column(Integer, primary_key=True)
    usuario_id = Column(Integer, nullable=False)
    categoria_id = Column(Integer, nullable=False)
    nombre_publico = Column(String(100), nullable=False)
    biografia = Column(Text)
    ciudad = Column(String(100))
    disponible = Column(Boolean, default=True)
    categoria_personalizada = Column(String(100))