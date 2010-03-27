package net.raescott.controllers;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import net.raescott.Person;
import net.raescott.Pet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect PersonController_Roo_Controller {
    
    @RequestMapping(value = "/person", method = RequestMethod.POST)
    public String PersonController.create(@Valid Person person, BindingResult result, ModelMap modelMap) {
        if (person == null) throw new IllegalArgumentException("A person is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("person", person);
            modelMap.addAttribute("pets", Pet.findAllPets());
            modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
            return "person/create";
        }
        person.persist();
        return "redirect:/person/" + person.getId();
    }
    
    @RequestMapping(value = "/person/form", method = RequestMethod.GET)
    public String PersonController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("person", new Person());
        modelMap.addAttribute("pets", Pet.findAllPets());
        modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
        return "person/create";
    }
    
    @RequestMapping(value = "/person/{id}", method = RequestMethod.GET)
    public String PersonController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
        modelMap.addAttribute("person", Person.findPerson(id));
        return "person/show";
    }
    
    @RequestMapping(value = "/person", method = RequestMethod.GET)
    public String PersonController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("people", Person.findPersonEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Person.countPeople() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("people", Person.findAllPeople());
        }
        modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
        return "person/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String PersonController.update(@Valid Person person, BindingResult result, ModelMap modelMap) {
        if (person == null) throw new IllegalArgumentException("A person is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("person", person);
            modelMap.addAttribute("pets", Pet.findAllPets());
            modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
            return "person/update";
        }
        person.merge();
        return "redirect:/person/" + person.getId();
    }
    
    @RequestMapping(value = "/person/{id}/form", method = RequestMethod.GET)
    public String PersonController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("person", Person.findPerson(id));
        modelMap.addAttribute("pets", Pet.findAllPets());
        modelMap.addAttribute("person_birthDate_date_format", org.joda.time.format.DateTimeFormat.patternForStyle("S-", org.springframework.context.i18n.LocaleContextHolder.getLocale()));
        return "person/update";
    }
    
    @RequestMapping(value = "/person/{id}", method = RequestMethod.DELETE)
    public String PersonController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Person.findPerson(id).remove();
        return "redirect:/person?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
