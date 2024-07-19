
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Cia_IdCia'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ejercicio' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Ejr_CodEjr'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Per_NoPer'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de Póliza' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Tipo_For'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'N° de Póliza' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Pol_NoPol'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número de Partida de la póliza (consecutivo)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_IdDoc'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cuenta Contable' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Cct_Cta'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripción del movimiento' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_DescMov'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Referencia' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_Ref'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de Movimiento' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_FeMov'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de movimiento Cargo=1, Abono=2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_TipoMov'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cargo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_Cargo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Abono' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Cap_Documentos', @level2type=N'COLUMN',@level2name=N'Doc_Abono'
GO


