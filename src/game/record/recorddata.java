package game.record;

public class recorddata {
	private int score;
	private String name;
	private String time;
	public recorddata(int score,String name,String ti)
	{
		this.score=score;
		this.name=new String(name);
		this.time=new String(time);
	}
	
	public int getscore()
	{
		return score;
	}
	
	public String getname()
	{
		return name;
	}
	public String gettimme()
	{
		return name;
	}
	public int compareTo(recorddata obj)
	{
		if(score>obj.score)
			return 1;
		else if(score==obj.score)
			return 0;
		else
			return -1;
	}
	public String toString()
	{
		return "score:"+score+"name:"+name+"time:"+time+"\n";
	}
}