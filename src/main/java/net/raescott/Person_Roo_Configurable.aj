package net.raescott;

import org.springframework.beans.factory.annotation.Configurable;

privileged aspect Person_Roo_Configurable {
    
    declare @type: Person: @Configurable;
    
}
