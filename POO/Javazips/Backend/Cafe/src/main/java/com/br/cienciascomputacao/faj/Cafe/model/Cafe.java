package com.br.cienciascomputacao.faj.Cafe.model;

public class Cafe {
	
	private int id;
	private String marca;
	private float peso;
	private String torracao;
	
	public Cafe(int id, String marca, float peso, String torracao) {
		this.id = id;
		this.marca = marca;
		this.peso = peso;
		this.torracao = torracao;
	}
	
	
	public Cafe() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public float getPeso() {
		return peso;
	}

	public void setPeso(float peso) {
		this.peso = peso;
	}

	public String getTorracao() {
		return torracao;
	}

	public void setTorracao(String torracao) {
		this.torracao = torracao;
	}
	


}
