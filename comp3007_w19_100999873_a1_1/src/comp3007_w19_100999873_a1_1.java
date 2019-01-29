//Authorized by Roy Xu
//For COMP3007 Winter_2019
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class comp3007_w19_100999873_a1_1 {

    public static void main(String args[]){

        String snakeCase;

        System.out.println("Please enter the Snake Case words:");

        while (true) {
            Scanner S = new Scanner(System.in);
            snakeCase = S.nextLine();
            if(validate(snakeCase)) break;
            else System.out.println("Please no Upper Case!!!\nEnter Again:");
        }
        System.out.println(transListToPig(stringList(snakeCase)));
    }

    private static boolean validate(String s){

        char c = s.charAt(0);

        if((c > 'a' && c < 'z') || c == '_' ) {
            return (s.length() == 1) || validate(s.substring(1));

        } else return false;
    }

    private static int lmUnderScore (String s){

        if(s.length() > 1 && s.charAt(0) != '_')
            return lmUnderScore(s.substring(1)) + 1;

        else return 0;
    }

    private static List<String> stringList (String s){

        List<String> strings = new LinkedList<>();
        int underScoure = lmUnderScore(s);

        if (underScoure+1 != s.length()) {
            strings.add(s.substring(0, underScoure));
            for (String string:stringList(s.substring(underScoure + 1)))
                strings.add(string);
        }else strings.add(s);

        return strings;
    }

    private static int lmVowel(String s){

        if(s.length() >= 1){
            char c = s.charAt(0);

            if(c != 'a' && c!= 'e' && c!= 'i' && c != 'o' && c != 'u')
                return lmVowel(s.substring(1)) + 1;
            else return 0;
        }
        else return 0;
    }

    private static String transToPigLatin(String s){
        int numVowel = lmVowel(s);
        return s.substring(numVowel)+s.substring(0,numVowel)+"ay";
    }

    private static List<String> transListToPig(List<String> strings){
        List<String> list = new LinkedList<>();

        list.add(transToPigLatin(strings.get(0)));
        if(strings.size()>1) {
            for(String string : transListToPig(strings.subList(1, strings.size())))
            list.add(string);
        }

        return list;
    }
}
