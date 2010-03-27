package net.raescott.controllers;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import net.raescott.Pet;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "pet", automaticallyMaintainView = true, formBackingObject = Pet.class)
@RequestMapping("/pet/**")
@Controller
public class PetController {
}
