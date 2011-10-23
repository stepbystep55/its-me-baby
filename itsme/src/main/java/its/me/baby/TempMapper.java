package its.me.baby;

import java.util.List;

public interface TempMapper {

	public Temp get(int userId);

	public List<Temp> list();

	public void save(Temp temp);
}
