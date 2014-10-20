
package Sim.Calc is
   
   type Unsigned32 is mod 2 ** 32;
   
   
   ---------------------
   -- motor Simulator --
   ---------------------  
   task Simulate is 
      entry Start (Jmi, Jli, Kti, Kdwi, Tfi, Tli : Long_Float; Ni : integer);
      -- start motor simulation
      --
      -- jmi : motor inertia (kg m^2 for metric)
      -- jli : load inertia
      -- kti : torque constant ( Nm / A )
      -- kdwi: damping constant (Nm / rad s^-1  or  Nm / krpm * 104.72)
      -- tfi : friction torque  (Nm ) static motor friction 
      -- Tli : load torque (Nm) like load friction, or other opposing torques)
      -- Ni  : encoder lines per revolution. 
      --       Must be multiplied by 4 if there is 4x decoding in the drive. 
      
      entry Stop;
      
      entry Get_Pos (Encpos : in out Long_Integer);
      -- returns the present encoder readout
      
      entry Set_Current (Inow : in Long_Float);
      -- sets the simulation current. 
      --   so for a static current the simmotor will run away.
      --   be sure to toggle it.
   end Simulate;
   
   
   ---------------------
   -- Drive simulator --
   ---------------------
   
   procedure Set_Init_Pars (NMT_CycleLen_U32 : Unsigned32; Vperiod : Duration);
   -- init request, must happen in pre-op state 1 --
   -- NMT_CycleLen_U32 : EPL scan period in usec, this is a CAN object
   -- vPeriod          : sets the scan period of the drive. 
   --            NMT_CycleLen_U32 must be a multiple of this, to aid syncronization.
   
   procedure Set_New_Pars (Vvcc, Vmax_Current, Vmax_limt, 
			     Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float);
   -- parameter  change. They will become effective on the next sync.
   -- meaning of the symbols as for 'entry start' below.

   procedure Set_New_Dest (Position : Long_Float);
   -- give the new destination for the end of the next EPL period.
   -- it will become effective on the next sync
   -- NOTE: speed runaway can only be caught in the cnc. 
   --       The only useful safty feature here is to guard the 
   --       controller output current. 
   --       It will go into saturation when there is a short or an open in 
   --       the bridge or when there is a motor seizure, 
   --        or when the encoder gave in.
   
   procedure Get_Position (Position : in out Long_Float);
   -- returns the encoder readout at the last sync pulse
   
   procedure Get_Errors (Drive_Limit : in out Boolean);
   -- returns any errors
   -- suppose also a temperature error belongs here
   -- and a scan error off course
   
   task Drive_Sim is
      entry Start (Vvcc, Vmax_Current, Vmax_Limt, 
		     Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float;
		   Vn : Positive);
      -- enables the drive, sets the drive parameters and 
      --  zeros the position, and other internal registers.
      --
      -- Vcc          : supply voltage, probably not needed
      -- vmax_current : maximum allowed current. 
      --                in a limit situatiuon this is where the drive will be stuck.
      --                trips the drive after a time delay.
      -- vmax_limt    : Drive saturation limit in seconds.
      -- va1          : transconductance gain in amps / 'volt'.
      --                 'volts' being internal units of the drive, its a bit fuzzy.
      -- Vkp_Phi      : proportional gain of the position error.
      -- Vki_Phi      : integral gain of the position error.
      -- Vkp          : proportional gain of the speed error,
      --                 note that this is the diff gain of the pos error.
      -- Vki          : integral gain of the speed error, 
      --                 note that Vkp_Phi has the same effect.
      -- vN           : encoder lines per revolution.
      
      entry Stop;
      -- disables the drive.
      
      
      entry Sync_Pulse;
      -- syncronizes the drive to the EPL scan period.
      --  and transfers the new destination into the drive
      --  reads the encoder
      --  transfers any parameters into the drive.
      
   end Drive_Sim;
   
   -------------------
   -- cnc simulator --
   -------------------
   
   procedure Set_Motor_Details (vJm, vJl, vKt, vKdw, vTf, vTl : Long_Float; 
				vN : integer);
   
   procedure Set_Drive_Details (Vvcc, vMax_Current, Vmax_limt, 
				 Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float;
				Vn                                : Positive);
   
   
   task Cnc_Sim is
      entry Start_Link (Dperiod, Eplperiod : Duration);
      entry Start_Sim (Runperiod, Speriod : Duration; Sspeed : Long_Float);
      entry Stop;
   end Cnc_Sim;

      
   
end Sim.Calc;
