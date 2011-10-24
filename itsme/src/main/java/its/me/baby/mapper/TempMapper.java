package its.me.baby.mapper;

import its.me.baby.dto.Temp;

import java.util.List;

public interface TempMapper {

	public Temp get(int userId);

	public List<Temp> list();

	public void save(Temp temp);
}
