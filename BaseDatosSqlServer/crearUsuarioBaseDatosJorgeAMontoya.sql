use master
create DATABASE preguntas_respuestas


use master
CREATE LOGIN [JorgeAMontoya] WITH PASSWORD=N'3113229014', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF


USE [preguntas_respuestas]
GO
CREATE USER [JorgeAMontoya] FOR LOGIN [JorgeAMontoya]
GO
USE [preguntas_respuestas]
GO
ALTER ROLE [db_owner] ADD MEMBER [JorgeAMontoya]
GO
