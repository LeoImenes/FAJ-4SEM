package model;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.Scanner;

public class ComputadorMenu {

	@SuppressWarnings("unused")
	public static void main(String[] args) throws Exception {
		ComputadorDAO dao = new ComputadorDAO();
		Scanner sc = new Scanner(System.in);
		menu: while (true) {
			int opcao = getOpcao(sc);
			switch (opcao) {
			case 1:
				List<Computador> lst = dao.listar();
				exibirList(lst);
				break;
			case 2:
				Computador c = obterComputador(sc);
				dao.incluir(c);
				break;
			case 3:
				Computador cx = obterComputadorExcluir(sc);
				dao.excluirComputador(cx);
				Computador c1 = obterComputador(sc);
				dao.incluir(c1);
				break;
			case 4:
				List<Computador> pclst = dao.listar();
				exibirMaiorPreco(pclst);
				break;
			case 5:
				break;
			default:
				System.out.println("Informe apenas as opções obrigatorias");
			}
			

		}
	}

	private static Computador obterComputadorExcluir(Scanner sc) {
		Computador c = new Computador();
		System.out.println("Informe um Nome de Fornecedor para alterar:");
		c.setFornecedor(sc.nextLine());
		return c;
	}

	private static Computador obterComputador(Scanner sc) {
		Computador c = new Computador();
		System.out.println("Informe o fornecedor:");
		c.setFornecedor(sc.nextLine());
		System.out.println("CPU:");
		c.setCpu(sc.nextLine());
		System.out.println("Memoria:");
		c.setMemoria(sc.nextLine());
		System.out.println("HD:");
		c.setHd(sc.nextLine());
		System.out.println("Preco:");
		c.setPreco(sc.nextDouble());
		sc.nextLine();
		return c;
	}

	private static int getOpcao(Scanner sc) {
		System.out.println("1 - Ler arquivo");
		System.out.println("2 - Inserir no arquivo");
		System.out.println("3 - Alterar no arquivo");
		System.out.println("4 - Maior preço;");
		System.out.println("5 - Sair;");
		int opcao = sc.nextInt();
		sc.nextLine();
		return opcao;
	}

	private static void exibirList(List<Computador> lst) {
		for (Computador c : lst) {
			System.out.println(c.getFornecedor() + "   " + c.getCpu() + "    " + c.getMemoria() + "    " + c.getHd()
					+ "    " + c.getPreco());
		}
	}

	private static double exibirMaiorPreco(List<Computador> lst) {
		Comparator<Computador> comparator = Comparator.comparing(Computador::getPreco);
		Computador maxObject = lst.stream().max(comparator).get();
		System.out.println(maxObject.getFornecedor() + " " + maxObject.getCpu() + " " + maxObject.getMemoria() + " "
				+ maxObject.getHd() + " " + maxObject.getPreco());
		return 0;

	}

}
