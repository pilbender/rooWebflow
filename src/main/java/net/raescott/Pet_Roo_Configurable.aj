package net.raescott;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Pet_Roo_Configurable {
    
    declare @type: Pet: @Configurable;
    
}
