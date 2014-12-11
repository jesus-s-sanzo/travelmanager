// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.travelmanager.web;

import com.travelmanager.domain.StartPoint;
import com.travelmanager.web.StartPointController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect StartPointController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String StartPointController.create(@Valid StartPoint startPoint, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, startPoint);
            return "startpoints/create";
        }
        uiModel.asMap().clear();
        startPoint.persist();
        return "redirect:/startpoints/" + encodeUrlPathSegment(startPoint.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String StartPointController.createForm(Model uiModel) {
        populateEditForm(uiModel, new StartPoint());
        return "startpoints/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String StartPointController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("startpoint", StartPoint.findStartPoint(id));
        uiModel.addAttribute("itemId", id);
        return "startpoints/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String StartPointController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("startpoints", StartPoint.findStartPointEntries(firstResult, sizeNo));
            float nrOfPages = (float) StartPoint.countStartPoints() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("startpoints", StartPoint.findAllStartPoints());
        }
        return "startpoints/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String StartPointController.update(@Valid StartPoint startPoint, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, startPoint);
            return "startpoints/update";
        }
        uiModel.asMap().clear();
        startPoint.merge();
        return "redirect:/startpoints/" + encodeUrlPathSegment(startPoint.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String StartPointController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, StartPoint.findStartPoint(id));
        return "startpoints/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String StartPointController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        StartPoint startPoint = StartPoint.findStartPoint(id);
        startPoint.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/startpoints";
    }
    
    void StartPointController.populateEditForm(Model uiModel, StartPoint startPoint) {
        uiModel.addAttribute("startPoint", startPoint);
    }
    
    String StartPointController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
