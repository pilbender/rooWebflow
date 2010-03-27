package net.raescott.controllers;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import net.raescott.Pet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect PetController_Roo_Controller {
    
    @RequestMapping(value = "/pet", method = RequestMethod.POST)
    public String PetController.create(@Valid Pet pet, BindingResult result, ModelMap modelMap) {
        if (pet == null) throw new IllegalArgumentException("A pet is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("pet", pet);
            return "pet/create";
        }
        pet.persist();
        return "redirect:/pet/" + pet.getId();
    }
    
    @RequestMapping(value = "/pet/form", method = RequestMethod.GET)
    public String PetController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("pet", new Pet());
        return "pet/create";
    }
    
    @RequestMapping(value = "/pet/{id}", method = RequestMethod.GET)
    public String PetController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("pet", Pet.findPet(id));
        return "pet/show";
    }
    
    @RequestMapping(value = "/pet", method = RequestMethod.GET)
    public String PetController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("pets", Pet.findPetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Pet.countPets() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("pets", Pet.findAllPets());
        }
        return "pet/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String PetController.update(@Valid Pet pet, BindingResult result, ModelMap modelMap) {
        if (pet == null) throw new IllegalArgumentException("A pet is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("pet", pet);
            return "pet/update";
        }
        pet.merge();
        return "redirect:/pet/" + pet.getId();
    }
    
    @RequestMapping(value = "/pet/{id}/form", method = RequestMethod.GET)
    public String PetController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("pet", Pet.findPet(id));
        return "pet/update";
    }
    
    @RequestMapping(value = "/pet/{id}", method = RequestMethod.DELETE)
    public String PetController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Pet.findPet(id).remove();
        return "redirect:/pet?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
