package;

/**
 * ...
 * @author bb
 */
class CollectionData 
{
	static public function GET_EVENTS_COLOR(id:String)
	{
		return COLORS[Std.parseInt(EVENT_SETTINGS.get(id).get("criticality"))];
	}
	static public var COLORS:Array<Int> = [0x65a63c, 0xf7941d, 0xed1c24, 0x4fd1d9 ];
	static public var EVENT_SETTINGS:Map<String,Map<String,Dynamic>> = 
	[
		"invoice" => [
			"days" => ["normal"=>"0","new"=>"0","canceled"=>"0"],
			"criticality"=>"0",
			"process"=>["normal","new","canceled"],
			"contract"=>["b2c","b2b"]
			],	
		"dueDate"=> [
			"days" => ["normal"=>"28","new"=>"28","canceled"=>"28"],
			"criticality"=>"0",
			"process"=>["normal","new","canceled"],
			"contract"=>["b2c","b2b"]
			],
		"firstSMS"=> [
			"days" => ["normal"=>"6","new"=>"6","canceled"=>""],
			"criticality"=>"0",
			"process"=>["normal","new"],
			"contract"=>["b2c"]
			],
		"firstLetter"=> [
			"days" => ["normal"=>"16","new"=>"11","canceled"=>""],
			"criticality"=>"0",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"premiumBarring"=> [
			"days" => ["normal"=>"19","new"=>"","canceled"=>""],
			"criticality"=>"0",
			"process"=>["normal"],
			"contract"=>["b2c","b2b"]
			],
		"secondSMS" => [
			"days" => ["normal"=>"26","new"=>"","canceled"=>""],
			"criticality"=>"0",
			"process"=>["normal"],
			"contract"=>["b2c"]
			],
		"hotlineBarring"=> [
			"days" => ["normal"=>"31","new"=>"16","canceled"=>""],
			"criticality"=>"1",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"suspensionFees"=> [
			"days" => ["normal"=>"32","new"=>"17","canceled"=>""],
			"criticality"=>"1",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"secondLetter"=> [
			"days" => ["normal"=>"43","new"=>"","canceled"=>""],
			"criticality"=>"1",
			"process"=>["normal"],
			"contract"=>["b2c"]
			],
		"hardBarring"=> [
			"days" => ["normal"=>"46","new"=>"28","canceled"=>""],
			"criticality"=>"1",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"cancelationLetter"=> [
			"days" => ["normal"=>"58","new"=>"31","canceled"=>""],
			"criticality"=>"2",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"finalInvoice"=> [
			"days" => ["normal"=>"72","new"=>"?","canceled"=>""],
			"criticality"=>"2",
			"process"=>["normal","new"],
			"contract"=>["b2c","b2b"]
			],
		"remimderLetterBlackList"=> [
			"days" => ["normal"=>"","new"=>"","canceled"=>"6"],
			"criticality"=>"2",
			"process"=>["canceled"],
			"contract"=>["b2c","b2b"]
			],
		"warningLetter"=> [
			"days" => ["normal"=>"","new"=>"","canceled"=>"16"],
			"criticality"=>"2",
			"process"=>["canceled"],
			"contract"=>["b2c","b2b"]
			],
		"creditLoss"=> [
			"days" => ["normal"=>"95","new"=>"?","canceled"=>"?"],
			"criticality"=>"2",
			"process"=>["normal","new","canceled"],
			"contract"=>["b2c","b2b"]
			],
		"today"=> [
			"days" => ["normal"=>"","new"=>"","canceled"=>""],
			"criticality"=>"3",
			"process"=>["normal","new","canceled"],
			"contract"=>["b2c","b2b"]
			]
	]; 
	public static var LANGUAGE_MAP:Map<String,Map<String,Dynamic>>= [
			"fr" => [
				"desc" => "En passant la souris sur un événement, tu pourra lire le détail des actions de recouvrement faites par Salt envers le client.",
				"event" => "Evénements\n==========",
				"detail"=>"Détails\n=======",
				"month" => ["jan", "fev", "mar", "apr", "mai", "jun", "jul", "aou", "sep", "oct", "nov", "dec"],
				"day" => ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Un jour"],
				"in" => "en",
				"dateApprox"=> "Date approximative de l´évènement",
				"afterDueDate"=> " jour(s) depuis ",
				"afterDate"=> " jours ouvrés après ",
				"beforeDuedate"=> " jour(s) avant ",
				"contract"=> "Type de contrat",
				"process"=> "Type de processus",
				"invoiceMonth" => "Mois de la facture",
				"events" => [
					"invoice" => [
						"title" => "facture",
						"desc" => ""
						],	
					"dueDate"=> [
						"title" => "échéance",
						"desc" => ""
						],
					"firstSMS"=> [
						"title" => "1er SMS de rappel",
						"desc" => "Bonjour.\nVous avez des factures échues pour un montant total de CHF 12.95. Ce n'est peut-être qu'un oubli de votre part. Si vous avez déjà réglé ce montant, vous pouvez ignorer ce SMS. Si ce n'est pas le cas, veuillez payer dans les 3 jours afin de continuer à profiter de l'ensemble de nos services et éviter des frais supplémentaires. \nVous pouvez payer en ligne sur myaccount.salt.ch ou trouver plus d’informations sur les moyens de paiements sur www.salt.ch/pay. \nMerci \nSalt Customer Finance Team - 0800 700 700 (depuis l'étranger +41 78 700 700)"
						],
					"firstLetter"=> [
						"title" => "1ère lettre de rappel",
						"desc" => "Montant total dû + la liste des factures échues (numéro de facture, période de facturation, montant total de la facture, montant ouvert restant) + bulletin de versement pré-rempli.\nUne charge de CHF 30.- est facturée."
						],
					"premiumBarring"=> [
						"title" => "Blocage de tous les services coûteux",
						"desc" => "- Roaming\n- Appels internationaux\n- Services premium\nLe blocage de ces services est levé en temps réel dès que le montant dû est enregistré."
						],
					"secondSMS"=> [
						"title" => "2ème SMS de rappel",
						"desc" => "Bonjour.\nMalgré plusieurs rappels, la somme de CHF 203.60 n'a toujours pas été payée. \nSi vous avez déjà réglé ce montant, vous pouvez ignorer ce SMS. \nSi ce n'est pas le cas, veuillez payer dans les 2 jours afin d'éviter la suspension de vos appels sortants et de vos transferts de données ainsi que CHF 30.- de frais supplémentaires. \nVous pouvez payer en ligne sur myaccount.salt.ch. \nPour plus d'informations, rendez-vous sur www.salt.ch/pay. \nMerci. \nSALT Customer Finance Team - 0800 700 700 (depuis l'étranger +41 78 700 7000)"
						],
					"hotlineBarring"=> [
						"title" => "Hotline barring",
						"desc" => "- SMS/MMS sortants & trafic de données bloqués\n- Appels sortants redirigés vers notre Service clientèle.\n-- Le client entend le montant dû et peut parler à un agent.\n-- Note : Les appels d'urgence (117, 118, 144) restent possibles. Les appels entrants ne sont bloqués.\n\nBlack list :\n- Le client ne peut plus activer de souscription\n- Le client n'est pas éligible pour une offre de rétention"
						],
					"suspensionFees"=> [
						"title" => "frais de suspension",
						"desc" => "CHF 50.- de frais de suspension sont chargés et seront visibles sur la prochaine facture."
						],
					"secondLetter"=> [
						"title" => "2ème lettre de rappel",
						"desc" => "Montant total dû + liste des factures échues (numéro de facture, période de facturation, montant total de la facture, montant ouvert restant) + bulletin de versement pré-rempli.\n\nUn avertissement qu'en cas de non-paiement, le dossier sera transmis en agence de recouvrement et le numéro de mobile sera perdu\n\nUne charge de CHF 30.- est facturée"
						],
					"hardBarring"=> [
						"title" => "Hard Barring",
						"desc" => "Tous les appels sont bloqués\nUniquement les appels vers notre Service clientèle et vers les numéros d'urgence sont possibles\nPlus possible d’initier un arrangement de paiement. Et annulation d’arrangement de paiement en place."
						],
					"cancelationLetter"=> [
						"title" => "Résiliation effectuée",
						"desc" => "Lettre de résiliation envoyée."
						],
					"finalInvoice"=> [
						"title" => "Facture finale envoyée",
						"desc" => "Tous les montants ouverts à ce jour + les frais jusqu'à la fin du cycle de facturation en cours\nLes frais de résiliation anticipée (ETF)\nLes mensualités restantes (Appareils, ETF, eRet etc…)"
						],
					"remimderLetterBlackList"=> [
						"title" => "Lettre de rappel + blacklist",
						"desc" => "Envoi d’une première lettre de rappel + ajout à la blacklist.\nUne charge de CHF 30.- est facturée."
						],
					"warningLetter"=> [
						"title" => "Lettre d’avertissement",
						"desc" => "Lettre d’avertissement avant de transférer le dossier vers l’agence de recouvrement."
						],
					"creditLoss"=> [
						"title" => "Credit loss",
						"desc" => "- Pertes sur créances\n- Dossier envoyé en agence de recouvrement."
						],
						
					"today"=> [
						"title" => "Aujourd'hui",
						"desc" => ""
						]
				]
			],
			"de" => [
				"desc" => "Wenn Sie mit der Maus über ein Ereignis fahren, können Sie die Details der von Salt gegenüber dem Kunden durchgeführten Sammelaktionen lesen.",
				"event"=>"Ereignisse\n==========",
				"detail"=>"Einzelheiten\n============",
				"month" => ["Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez"],
				"day" => ["Son", "Mon", "Die", "Mit", "Don", "Fre", "Sam", "Ein Tag"],
				"in" => "im",
				"dateApprox"=> "Ungefähres Datum der Handlung",
				"afterDueDate" => " Tag(en) ab ",
				"afterDate"=> " Werktage nach ",
				"beforeDuedate" => " Tag(en) vor ",
				"contract"=> "Vertragstyp",
				"process"=> "Prozesstyp",
				"invoiceMonth"=> "Rechnungsmonat",
				"events" => [
					"invoice" => [
						"title" => "Rechn.",
						"desc" => ""
						],	
					"dueDate"=> [
						"title" => "Fälligkeit",
						"desc" => ""
						],
					"firstSMS"=> [
						"title" => "Erstes Mahn-SMS",
						"desc" => "Hallo.\nSie haben ausstehende Rechnungen über einen Gesamtbetrag von CHF 12.95. Bestimmt handelt es sich um ein Versehen Ihrerseits. Bitte beachten Sie diese SMS nicht, falls Sie den Betrag bereits bezahlt haben. Anderenfalls bitten wir Sie, den Betrag innerhalb von 3 Tagen zu bezahlen, um weiterhin alle unsere Dienstleistungen in Anspruch nehmen zu können und zusätzliche Kosten zu vermeiden. \nSie können Ihre Zahlung online auf myaccount.salt.ch tätigen. Weitere Informationen zu den Zahlungsmethoden finden Sie unter www.salt.ch/pay.\nDanke \nSalt Customer Finance Team - 0800 700 700 700 (aus dem Ausland +41 78 700 700)"
						],
					"firstLetter"=> [
						"title" => "Erster Mahnbrief",
						"desc" => "Total offener Betrag + Liste der überfälligen Rechnungen (Rechnungsnummer, Rechnungs- Periode, Rechnungsbetrag, übriger, offener Betrag) + Ausgefüllter Einzahlungsschein.\nEine Gebühr von CHF 30.- wird verrechnet."
						],
					"premiumBarring"=> [
						"title" => "Sperrung aller Kostenpflichtigen Dienste",
						"desc" => "- Roaming\n- Internationale Anrufe\n- Premium-Dienste\n\nDiese Sperrung wird in Echtzeit reaktiviert, sobald der geforderte Betrag eingetroffen ist."
						],
					"secondSMS"=> [
						"title" => "Zweites Mahn-SMS",
						"desc" => "Hallo.\nTrotz mehrerer Mahnungen ist der Betrag von CHF 126.65 noch nicht bezahlt worden. \nFalls Sie diesen Betrag bereits beglichen haben können Sie dieses SMS ignorieren. \nAndernfalls bitten wir Sie innerhalb 2 Tagen zu zahlen, um eine Sperrung Ihrer ausgehenden Anrufe, der Datendienste und zusätzliche Kosten von CHF 30.- zu vermeiden. \nSie können online unter myaccount.salt.ch bezahlen oder erfahren Sie mehr unter www.salt.ch/pay. \nBesten Dank. \nSALT Customer Finance Team - 0800 700 700 (+41 78 700 7000 aus dem Ausland)"
						],
					"hotlineBarring"=> [
						"title" => "Hotline barring",
						"desc" => "- Ausgehende SMS/MMS & Mobile-Daten werden gesperrt\n- Ausgehende Anrufe werden an unseren Kundendienst weitergeleitet.\nDer Kunde hört den geschuldeten Betrag und kann mit einem Agenten sprechen.\nMerke: Notrufe (117, 118, 144) bleiben möglich. Eingehende Anrufe werden nicht gesperrt.\nBlack list :\n- Der Kunde kann keine zusätzlichen Aktivierungen mehr machen\n- Der Kunde hat kein Anrecht auf eine Vertragserneuerung (Retention)"
						],
					"suspensionFees"=> [
						"title" => "Sperrgebühren",
						"desc" => "Gebühren von CHF 50.- für die Sperrung sind auf der nächsten Rechnung ersichtlich."
						],
					"secondLetter"=> [
						"title" => "Zweiter Mahnbrief",
						"desc" => "Total offener Betrag + Liste der überfälligen Rechnungen (Rechnungsnummer, Rechnungsperiode, totaler Rechnungsbetrag, noch überfälliger Betrag) + ausgefüllter Einzahlungsschein .\nEine Vorwarnung, dass bei nicht begleichen der Schuld das Dossier an eine Inkasso Agentur weitergeleitet wird & die Rufnummer verloren geht \nCHF 30.- Mahngebühren werden verrechnet"
						],
					"hardBarring"=> [
						"title" => "Hard Barring",
						"desc" => "Alle Anrufe werden gesperrt\nNur noch Notrufe, wie auch Anrufe an unseren Kundendienst sind möglich\nEs ist nicht mehr möglich, eine Zahlungsvereinbarung einzuleiten und/oder eine laufende Zahlungsvereinbarung zu annullieren."
						],
					"cancelationLetter"=> [
						"title" => "Kündigung wird durchgeführt",
						"desc" => "Kündigungsschreiben wird versandt"
						],
					"finalInvoice"=> [
						"title" => "Abschlussrechnung wird versandt",
						"desc" => "- Alle offenen Beträge bis zu dem Tag + die Gebühren der laufenden Rechnung des aktuellen Rechnungszyklus\n- Die Gebühr für die vorzeitige Vertragsauflösung  (ETF)\n- Die restlichen Raten (Gerät, ETF, eRet etc…)"
						],
					"remimderLetterBlackList"=> [
						"title" => "Mahnbrief + Blacklist",
						"desc" => "Versenden eines Mahnbriefes + beifügen auf der Blacklist.\nEine Gebühr von CHF 30.- wird verrechnet."
						],
					"warningLetter"=> [
						"title" => "Warnbrief",
						"desc" => "Versandt eines Warnbriefes, bevor das Dossier an eine Inkasso Angentur weitergeleitet wird."
						],
					"creditLoss"=> [
						"title" => "Credit loss",
						"desc" => "- Schuldenverlust\n- Dossier wir an eine Inkasso Agentur weitergeleitet"
						],
						"today"=> [
						"title" => "Heute",
						"desc" => ""
						]
				]
			]
		];
	
}