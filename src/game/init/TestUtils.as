/**
 * Created by marek on 22.03.2017.
 */
package game.init {
import flash.system.Capabilities;

import game.utils.ArrayUtils;

public class TestUtils {

	public static const NAMES:Array = 'Rin Sakura Hina Yua Yuna Miu Yui Aoi Miyu Misaki Hiroto Shota Ren Sota Sora Yuto Yuto Yuma Eita Sho Oliver Jack Harry Charlie Alfie Thomas Joshua William Daniel James Sophia Emma Olivia Ava Mia Isabella Riley Aria Zoe Charlotte Lily Layla Amelia Emily Madelyn Aubrey Adalyn Madison Chloe Harper Abigail Aaliyah Avery Evelyn Kaylee Ella Ellie Scarlett Arianna Hailey Nora Addison Brooklyn Hannah Mila Leah Elizabeth Sarah Eliana Mackenzie Peyton Maria Grace Adeline Elena Anna Victoria Camilla Lillian Natalie Jackson Aiden Lucas Liam Noah Ethan Mason Caden Oliver Elijah Grayson Jacob Michael Benjamin Carter James Jayden Logan Alexander Caleb Ryan Luke Daniel Jack William Owen Gabriel Matthew Connor Jayce Isaac Sebastian Henry Muhammad Cameron Wyatt Dylan Nathan Nicholas Julian Eli Levi Isaiah Landon David Christian Andrew Brayden John Lincoln'.split(' ')
	public static const LOREM_IPSUM:String = 'on the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. these cases are perfectly simple and easy to distinguish. in a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. but in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. the wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.';
	public static const LOREM_IPSUM_WORDS:Array = LOREM_IPSUM.split(/\W+/);
	private static var namesTmp:Array;
	private static var talkQuestions:Array = [];
	private static var talkAnswers:Array = [];

	static public function isAndroid():Boolean {
		return Capabilities.os.search('Linux') > -1;
	}

	static public function getRandomOneLineText(maxLength:uint = 40, baseText:String = null):String {
		if(!baseText) {
			baseText = LOREM_IPSUM;
		}
		return baseText.substr(0, int(Math.min(baseText.length, maxLength - 5) * Math.random())) + ' end.';
	}

	static public function getRandomWord():String {
		return ArrayUtils.getRandom(LOREM_IPSUM_WORDS);
	}

	static public function getRandomArticle(paragraphMax:uint = 1, minSentences:uint = 1, maxSentences:uint = 3, minWords:uint = 4, maxWords:uint = 10):String {
		var texts:Array = [];
		var paragraphs:uint = 1 + Math.random() * paragraphMax;
		while(paragraphs--) {
			texts.push('    ' + getRandomText(minSentences, maxSentences, minWords, maxWords));
		}
		return texts.join('\n\n');
	}

	static public function getRandomText(minSentences:uint = 1, maxSentences:uint = 3, minWords:uint = 4, maxWords:uint = 10):String {
		var count:uint = getCount(minSentences, maxSentences);
		var sentences:Array = [];
		while(count--) {
			sentences.push(getRandomSentence(minWords, maxWords))
		}
		return sentences.join(' ')
	}

	static public function getRandomSentence(minWords:uint = 4, maxWords:uint = 10):String {
		var wordsCount:uint = getCount(minWords, maxWords);
		var sentence:Array = [];
		while(wordsCount--) {
			sentence.push(ArrayUtils.getRandom(LOREM_IPSUM_WORDS))
		}
		sentence[0] = String(sentence[0]).substr(0, 1).toUpperCase() + String(sentence[0]).substr(1);
		return sentence.join(' ') + '.'
	}

	// [A-Z].*?\.
	static public function getRandomName():String {
		if(!namesTmp) {
			namesTmp = NAMES.concat()
		}
		if(!namesTmp.length) {
			namesTmp = NAMES.concat()
		}
		return ArrayUtils.removeRandom(namesTmp);
	}

	public static function getRandomWords(min:uint, max:uint):Array/*of String*/ {
		var words:Array = [];
		var count:uint = getCount(min, max);
		while(count--) {
			words.push(getRandomWord());
		}
		return words
	}

	private static function getCount(min:uint, max:uint):uint {
		return min + Math.round(Math.random() * (max - min));
	}

	public static function getTalkQuestion():String {
		if(!talkQuestions.length) {
			talkQuestions = [
				'Mojego ojca pobił, w d*** r**** wojak jeden. Na starszego człowieka rękę podnosi. Zwierzę! Chłopaki, zabierajcie się do niego!',
				'Idź do ludzi. W gąszczu cudzych pragnień i lęków pokaż na co cię stać. Ujarzmij ludzką naturą i spraw, żeby ludzie wyparli się samych siebie.',
				'Już w Beirn znajdziesz tego, który zaprowadzi cię do labiryntu myśli. Będzie zagubiony i będzie potrzebował twojej pomocy. Dostanie ją od ciebie i pójdzie z nim. Cel jego wędrówki to również twój cel.',
				'Zdziwisz się, że ktoś taki ma taki kłopot, z którego go wyciągniesz.',
				'Takim mądrym Duchem to nie jestem. Musisz przejść się po wiosce, zajrzeć w różne miejsca. Poradzisz sobie.',
				'Panie kapitanie. Mam zaszczyt powitać w Garnizonie Dmorther, gdzie, wbrew mroźnym wichrom, niesiemy światło Imperium Haligardu i strzeżemy naszych granic.',
				'Obywatelu, odstąp, nie wyglądasz na tutejszego, nie mieszaj się i ruszaj w swoją drogę.',
				'Jeśli będzie trzeba, wszystkich was tutaj wysieczemy. Znaczy... aresztujemy. Jesteśmy w prawie! Odstąpcie ludzie!',
				'Obywatelu, odstąp, nie wyglądasz na tutejszego, nie mieszaj się i ruszaj w swoją drogę.',
				'Słuchajcie, daruję wam winę przeciwko żołnierzom Haligardu i nawet zapłacę za bimber obywatela Wojtasa, żeby naprawić straty moralne. Dobra kobieto, przynieś wytwory swojego ojca.',
				'Idź dziecko do piwniczki i przynieś dwa dzbany.',
				'Interes imperium. Mam przygotować wizytę kapitana Felmana Jakovika w garnizonie, który znajduje się po drugiej stronie szczytu. Chciałem wynająć tutaj przewodnika, bo ścieżki zamarzniętego jeziora bywają zdradliwe...',
				'Przychodzicie tutaj, bijecie porządnych ludzi i myślicie, że złoto wszystko nam wynagrodzi. Chłopy, pokażcie, że płynie w was vorlińska krew. Za drzwi z tymi mięczakami z dołu!',
			];
		}
		return ArrayUtils.removeRandom(talkQuestions);
	}

	public static function getTalkAnswer():String {
		if(!talkAnswers.length) {
			talkAnswers = [
				'Co tu się stało?',
				'Wszystkich, poważnie? Dacie radę?',
				'Widzę, żeś tu obcy. Co cię sprowadza w te strony?',
				'[WSZCZYNA SIĘ BURDA.]',
				'To co? Jestem wolny?',
				'Tak, poświęceniem zadośćuczyniłeś swoim przewinom z Beirn. W imieniu Imperium, zwracam ci wolność.',
				'Bardzo dziękuję, ale wolność w tym miejscu nie znaczy zbyt wiele.',
				'Co masz na myśli?',
				'Lempo mam na myśli. Połączmy siły i razem dotrzemy do garnizonu.',
				'Dobrze, tylko pochowam moich żołnierzy. To byli dobzi ludzie.',
				'Nie wątpię. Pomogę ci tutaj i potem w garnizonie. [RZUCASZ NA NIEGO UROK, ŻEBY DOTARŁO, CO DO NIEGO MÓWISZ.]',
				'Dziękuję za zaufanie.',
				'Pan kapitan Jakovik i jego małżonka zajmą moją kwaterę - tutaj. Ja na ten czas przeniosę się do Berera.',
				'To bardzo hojnie z pana strony.',
				'Drobnostka. Córka i pan, jako jej ochrona, zajmiecie kwatery na dole.',
				'Możemy je obejrzeć?',
				'Oczywiście, proszę za mną.',
				'[IDZIESZ ZA NIMI.]',
				'[MILCZYSZ.]',
				'Muszę was niestety opuścić i przygotować resztę garnizonu do wizytacji. Do zobaczenia.',
				'Dziękuję. Do zobaczenia.',
				'Dziękuję za zaufanie.',
				'Pan kapitan Jakovik i jego małżonka zajmą moją kwaterę - tutaj. Ja na ten czas przeniosę się do Berera.',
				'To bardzo hojnie z pana strony.',
				'Drobnostka. Córka kapitana i pan, jako jej ochrona, zajmiecie kwatery na dole.',
				'Możemy je obejrzeć?',
				'Oczywiście, proszę za mną.',
				'[IDZIESZ ZA NIMI.]',
				'[JAKOVIK HONORY PRZYJĄŁ LEKKIM SKINIENIEM GŁOWY.]',
				'Ladner, niech ktoś zaprowadzi Tarę i Rozalin na swoje kwatery. Talliard, od razu zaczynamy przegląd. Nie chcę być tutaj dłużej, niż to niezbędne. Prowadź do zbrojowni.',
				'[WIDZISZ, JAK LADNER SKINĄŁ NA CIEBIE RĘKĄ.]',
				'Spokojnie. Proszę za mną. [RZUCASZ UROK NA MATKĘ.]',
				'Przecież Ladner mnie przedstawił. Panie muszą być zmęczone.',
				'Dostaniesz osobną salę w kwaterach na dole. Chodźmy.',
				'Wszyscy cali.',
				'Tarze? Nikomu nic się nie stało.',
				'A ty?',
				'A ja zaraz dam ci w pysk, jak nie przestaniesz zadawać głupich pytań. Kapitan jedzie jutro z Talliardem na objazd lodowego jeziora i wąwozu Dmorther. Pojutrze opuszczamy to miejsce. Kobiety zostają w garnizonie pod moją pieczą. Idę na kwatery. Ty rób co chcesz. Do jutra.',
				'Tak jest!',
				'Dobra, zapytam jeszcze raz. Rozalin i Tara nic dla ciebie nie znaczą? [UŻYWASZ UROKU.]',
				'Przed samymi sobą też? Właśnie wracam od Rozalin. Wydaje się zrozpaczona'
			];
		}
		return ArrayUtils.removeRandom(talkAnswers);
	}

}
}
/*
 */