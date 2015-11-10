
import java.security.NoSuchAlgorithmException;
import org.mindrot.jbcrypt.BCrypt;

// javac -cp jbcrypt.jar Password.java

public class Password
{
	public static void main(String[] args) throws NoSuchAlgorithmException
	{
		String originalPassword = args[0];
		System.out.println(args[0]);
		String generatedSecuredPasswordHash = BCrypt.hashpw(originalPassword, BCrypt.gensalt(10));
		System.out.println(generatedSecuredPasswordHash);

		boolean matched = BCrypt.checkpw(originalPassword, generatedSecuredPasswordHash);
		System.out.println(matched);
	}
}
