package model.dao;

import com.jfinal.plugin.activerecord.ActiveRecordPlugin;

/**
 * Generated by JFinal, do not modify this file.
 * <pre>
 * Example:
 * public void configPlugin(Plugins me) {
 *     ActiveRecordPlugin arp = new ActiveRecordPlugin(...);
 *     _MappingKit.mapping(arp);
 *     me.add(arp);
 * }
 * </pre>
 */
public class _MappingKit {

	public static void mapping(ActiveRecordPlugin arp) {
		arp.addMapping("t_animal", "animalId", Animal.class);
		arp.addMapping("t_animal_income", "incomeId", AnimalIncome.class);
		arp.addMapping("t_ask_cash", "askCashId", AskCash.class);
		arp.addMapping("t_cash_message", "cashMessageId", CashMessage.class);
		arp.addMapping("t_land", "landId", Land.class);
		arp.addMapping("t_land_tree", "landTreeId", LandTree.class);
		arp.addMapping("t_open_land", "openLandId", OpenLand.class);
		arp.addMapping("t_steal", "stealId", Steal.class);
		arp.addMapping("t_temp_pick", "tempPickId", TempPick.class);
		arp.addMapping("t_user", "userId", User.class);
	}
}
