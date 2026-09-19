public class New{ 
public static void main( String[] args ){ 
Library lib = new Library( "DATA libsvm Library" ); 
Book book1 = new Book("Effective Java", "seriki Yakub "); 
Book book2 = new Book("brainfuck", "Julian"); 
lib.addBook( book1 ); 
lib.addBook( book2 ); 
Book book3 = new Book("workbook ", "seriki Walter Yakub"); 
boolean onShelf = lib.isAvailable( book3 ); 
System.out.println( lib ); 
System.out.println( """ + book3.getName() + """
* (onShelf ? "is" : "is not") + " available" ); 
* //lib.checkOut( book3 ); 
* onShelf = lib.isAvailable( book3 ); 
* System.out.println( """ + book3.getName() + """
* (onShelf ? "is" : "is not") + " available" ); 
* } 
* //Im editing this 
* }
