InterceptorConfig = {
    Range = 105.0,
    DefaultSiren = 'VEHICLES_HORNS_SIREN_1',
    
    Rank = { 
        ['C'] = 1,
       	['B'] = 2,
        ['B+'] = 3,
    	['A'] = 4,
    	['A+'] = 5,
    	['S'] = 6,
    	['S+'] = 7
    },
    
    Models = {
       	['police2'] = {
    		['S+'] = {
    			SirenLock = 'VEHICLES_HORNS_POLICE_WARNING',
    			Handling = {
    				fInitialDragCoeff = 3.0,
    				fDownforceModifier = 8.8,
    				fInitialDriveForce = 0.4,
    				fDriveBiasFront = 0.5,
    				fTractionBiasFront = 0.478,
    				fTractionCurveLateral = 26,
    				fTractionSpringDeltaMax = 0.15,
    				fTractionLossMult = 1,
    				fDriveInertia = 1,
    				fBrakeForce = 2,
    				fSteeringLock = 37,
    				fTractionCurveMax = 5,
    				fTractionCurveMin = 4.98,
    				fInitialDriveMaxFlatVel = 191
    			}
    		},
    		['A+'] = {
    			SirenLock = 'VEHICLES_HORNS_SIREN_2',
    			Handling = {
        			fInitialDragCoeff = 5.0,
       				fDownforceModifier = 8.8,
       				fInitialDriveForce = 0.34,
       				fDriveBiasFront = 0.0,
       				fTractionBiasFront = 0.485,
       				fTractionCurveLateral = 22.5,
       				fTractionSpringDeltaMax = 0.15,
       				fTractionLossMult = 1,
       				fDriveInertia = 1,
       				fBrakeForce = 1.5,
       				fSteeringLock = 34,
       				fTractionCurveMax = 4.6,
       				fTractionCurveMin = 4.15,
       				fInitialDriveMaxFlatVel = 180
    			}
    		},
    		['B+'] = {
    			SirenLock = 'VEHICLES_HORNS_SIREN_1',
    			Handling = {
    			    fInitialDragCoeff = 8.5,
       				fDownforceModifier = 8.8,
       				fInitialDriveForce = 0.34,
       				fDriveBiasFront = 0.0,
       				fTractionBiasFront = 0.476000,
       				fTractionCurveLateral = 22,
       				fTractionSpringDeltaMax = 0.15,
       				fTractionLossMult = 1,
       				fDriveInertia = 1,
       				fBrakeForce = 0.6,
       				fSteeringLock = 33,
       				fTractionCurveMax = 1.6,
       				fTractionCurveMin = 1.4,
       				fInitialDriveMaxFlatVel = 132
    			}
    		}
    	}
    }
}