classdef AlteredBasicParticle < handle
    %ALTEREDBASICPARTICLE AlteredBasicParticle behavior for PSO
    
    properties
        position
        fitnessFunc
        personalBestFitness
        personalBestLocation
        personalFitness
        velocity
    end
    
    methods
        function obj = AlteredBasicParticle(fitnessFunc, initialPosition)
            %ALTEREDBASICPARTICLE Construct an instance of this class
            obj.fitnessFunc = fitnessFunc;
            obj.position = initialPosition;
            obj.velocity = zeros(1, length(initialPosition));
            
            % Sets initial conditions for this particle
            obj.personalFitness = fitnessFunc(obj.position);
            obj.personalBestFitness = Inf;
            obj.personalBestLocation = obj.position;
        end
        
        function [newPos, newFitness] = move(obj, gBestPos)
            % Update velocity
            inertia = (0.7) .* obj.velocity;
            pvBest = (0.4) * rand() .* (obj.personalBestLocation - obj.position);
            gvBest = (0.7) * rand() .* (gBestPos - obj.position);
            obj.velocity = inertia + pvBest + gvBest;
            
            % Cap velocity values...
            obj.velocity = sign(obj.velocity) .* min(abs(obj.velocity), 10);
            
            % Update location
            obj.position = obj.position + obj.velocity;
            
            % Calculate new values for self
            obj.personalFitness = obj.fitnessFunc(obj.position);
            if obj.personalFitness < obj.personalBestFitness
                obj.personalBestFitness = obj.personalFitness;
                obj.personalBestLocation = obj.position;
            end
            
            % Report back updated values, because that seemed like a good
            % idea at the time...
            newFitness = obj.personalFitness;
            newPos = obj.position;
        end
    end
end
