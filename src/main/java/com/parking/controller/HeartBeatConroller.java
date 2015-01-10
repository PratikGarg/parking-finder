package com.parking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class HeartBeatConroller {

	@RequestMapping("/")
	public String printHelloWorld(Model model) {
		model.addAttribute("message", "Alive!");
		return "hearbeat";
	}
}
