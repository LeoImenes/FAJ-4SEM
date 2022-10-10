package model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class ComputadorDAO {

    public static final String fileName = "Computador.csv";

    public void incluir(Computador c) throws IOException {
        FileWriter fw = new FileWriter(fileName, true);
        PrintWriter pw = new PrintWriter(fw);
        pw.println(getCSV(c));
        pw.close();
    }

    private static String getCSV(Computador c) {
        return c.getFornecedor() + ";" + c.getCpu() + ";" + c.getMemoria() + ";" + c.getHd() + ";" + c.getPreco();
    }

    public List<Computador> listar() throws Exception {
        List<Computador> lst = new ArrayList<>();
        FileReader fr = new FileReader(fileName);
        BufferedReader br = new BufferedReader(fr);
        String linha;
        while ((linha = br.readLine()) != null) {
            String[] str = linha.split(";");
            Computador p = new Computador();
            p.setFornecedor(str[0]);
            p.setCpu(str[1]);
            p.setMemoria(str[2]);
            p.setHd(str[3]);
            p.setPreco(Double.parseDouble(str[4]));
            
            
            
            lst.add(p);
        }
        br.close();
        return lst;
    }

    public void excluirComputador(Computador cx) throws Exception {
        List<Computador> list = listar();
        FileWriter fw = new FileWriter(fileName, false);
        PrintWriter pw = new PrintWriter(fw);
        for (Computador p : list) {
            if (cx.getFornecedor().equalsIgnoreCase(p.getFornecedor())) {
                continue;
            }
            pw.println(getCSV(p));
        }
        pw.close();
    }

}
