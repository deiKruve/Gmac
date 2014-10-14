
package Sim.Calc is
   
   
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
   
end Sim.Calc;
