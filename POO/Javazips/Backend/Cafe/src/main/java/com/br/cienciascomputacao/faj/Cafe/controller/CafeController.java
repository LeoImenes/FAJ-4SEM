package com.br.cienciascomputacao.faj.Cafe.controller;

import java.util.ArrayList;


import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.br.cienciascomputacao.faj.Cafe.model.Cafe;


@RestController
@CrossOrigin
public class CafeController {

	ArrayList<Cafe> listacafe = new ArrayList<>();

	
	@PostMapping("/cafe")
	public void novoCafe(@RequestBody Cafe cafeobj) {

		listacafe.add(cafeobj);

	}

	
	@GetMapping(path = "/cafe")
	public ArrayList<Cafe> listarCafe() {
		
			return listacafe;
		
	}

	@DeleteMapping("/cafe/{id}")
	public void delete(@PathVariable("id") int id) {
		for (Cafe i : listacafe) {
			if (i.getId() == id) {
				listacafe.remove(i);
				return;
			}
		}

	}
}
