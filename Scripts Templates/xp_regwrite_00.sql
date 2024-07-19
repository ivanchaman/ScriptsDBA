
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- "@type" is one of the following:                                        ++
--                                                                         ++
--   REG_SZ         - text strings                                         ++
--                                                                         ++
--   REG_EXPAND_SZ  - text strings that can contain environment variables  ++
--                    that when read by a program can be expanded.  Note   ++
--                    the program will need to handle expanding the        ++
--                    environment variable.                                ++
--                                                                         ++
--   REG_MULTI_SZ   - an array of delimited text strings                   ++
--                                                                         ++
--   REG_DWORD      - a 4-byte numeric value                               ++
--                                                                         ++
--   REG_BINARY     - raw binary data                                      ++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    EXEC master..xp_regwrite
        @rootkey    = N'<hive, NVARCHAR, HKEY_LOCAL_MACHINE>',
        @key        = N'<key, NVARCHAR, SOFTWARE\Endress + Hauser\FCCACCTWFL>',
        @value_name = N'<valueName, NVARCHAR, ManagementCodeVersion>',
        @type       = N'<type, NVARCHAR, REG_SZ>',
        @value      = N'<value, NVARCHAR, >'

    SELECT @nMyErr = @@ERROR  IF @nMyErr <> 0  PRINT N'     *** @@ERROR: ' + CAST(@nMyErr AS VARCHAR)   RETURN  END
