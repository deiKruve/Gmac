
package Sim.Calc is
   
   --type Enc_Pos is range -2 ** 31 .. +2 ** 31 - 1;
   
   task Simulate is -- motor
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
   
   
   task Drive_Sim is
      entry Start (VPeriod : Duration;
		   Vvcc, Vmax_Current, Vhrpm, Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float; 
		   Vn : Positive);
      entry Stop;
      entry Ch_Pars (VPeriod : Duration;
		     Vvcc, Vhrpm, Va1, Vkrho, Vki, Vg1 : Long_Float;
		     Vn : Positive);
      entry Update_dest (Position : Long_Float);
      entry Get_Position (Position : in out Long_Float);
   end Drive_Sim;
   
   
   task Cnc_Sim is
   --begin
      --null;
   end Cnc_Sim;

      
   
end Sim.Calc;
