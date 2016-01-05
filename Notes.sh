        -- 1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7
        hwEntityFanState OBJECT-TYPE
            SYNTAX INTEGER 
            {
                normal(1),
                abnormal(2)
            }
            MAX-ACCESS read-only
            STATUS current
            DESCRIPTION
                "This object indicates the state of the fan."
            ::= { hwFanStatusEntry 7 }
			
iso.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.0 = INTEGER: 1
iso.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.1 = INTEGER: 1
iso.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.2 = INTEGER: 1




        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.11
        hwEntityTemperature OBJECT-TYPE
            SYNTAX Integer32
            MAX-ACCESS read-only
            STATUS current
            DESCRIPTION
                " The temperature for the entity. "
            ::= { hwEntityStateEntry 11 }


        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.12
        hwEntityTemperatureThreshold OBJECT-TYPE
            SYNTAX Integer32
            MAX-ACCESS read-write
            STATUS current
            DESCRIPTION
                " The threshold for the temperature. When the temperature
                exceed the threshold, a notification will be sent. "
            ::= { hwEntityStateEntry 12 }
			
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.11.67108873 = INTEGER: 36



        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.5
        hwEntityCpuUsage OBJECT-TYPE
            SYNTAX Integer32 (0..100)
            MAX-ACCESS read-only
            STATUS current
            DESCRIPTION
                " The CPU usage for this entity. Generally, the CPU usage 
                will calculate the overall CPU usage on the entity, and it 
                is not sensible with the number of CPU on the entity. "
            ::= { hwEntityStateEntry 5 }


        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.6
        hwEntityCpuUsageThreshold OBJECT-TYPE
            SYNTAX Integer32 (0..100)
            MAX-ACCESS read-write
            STATUS current
            DESCRIPTION
                " The threshold for the CPU usage. When the CPU usage exceed
                the threshold, a notification will be sent. "
            ::= { hwEntityStateEntry 6 }
			
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.5.67108873 = INTEGER: 35
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.6.67108873 = INTEGER: 95

        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.7
        hwEntityMemUsage OBJECT-TYPE
            SYNTAX Integer32 (0..100)
            MAX-ACCESS read-only
            STATUS current
            DESCRIPTION
                " The memory usage for the entity. This object point out how
                many percent of memory has been used. "
            ::= { hwEntityStateEntry 7 }


        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.8
        hwEntityMemUsageThreshold OBJECT-TYPE
            SYNTAX Integer32 (0..100)
            MAX-ACCESS read-write
            STATUS current
            DESCRIPTION
                " The threshold for the Memory usage, When the memory usage 
                exceed the threshold, a notification will be sent. "
            ::= { hwEntityStateEntry 8 }


        -- 1.3.6.1.4.1.2011.5.25.31.1.1.1.1.9
        hwEntityMemSize OBJECT-TYPE
            SYNTAX Integer32
            UNITS "bytes"
            MAX-ACCESS read-only
            STATUS current
            DESCRIPTION
                " The size of memory for the entity. "
            ::= { hwEntityStateEntry 9 }
			
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.7.67108873 = INTEGER: 50
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.8.67108873 = INTEGER: 95
iso.3.6.1.4.1.2011.5.25.31.1.1.1.1.9.67108873 = INTEGER: 128058208
