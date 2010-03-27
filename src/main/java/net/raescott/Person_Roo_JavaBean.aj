package net.raescott;

import java.lang.String;
import java.util.Date;
import net.raescott.Pet;

privileged aspect Person_Roo_JavaBean {
    
    public String Person.getName() {
        return this.name;
    }
    
    public void Person.setName(String name) {
        this.name = name;
    }
    
    public Date Person.getBirthDate() {
        return this.birthDate;
    }
    
    public void Person.setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
    
    public Pet Person.getPet() {
        return this.pet;
    }
    
    public void Person.setPet(Pet pet) {
        this.pet = pet;
    }
    
}
