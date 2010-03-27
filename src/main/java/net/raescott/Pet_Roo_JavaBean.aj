package net.raescott;

import java.lang.String;

privileged aspect Pet_Roo_JavaBean {
    
    public String Pet.getName() {
        return this.name;
    }
    
    public void Pet.setName(String name) {
        this.name = name;
    }
    
}
