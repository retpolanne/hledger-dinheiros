init:
	touch private.rules
	brew bundle

clean:
	-rm ${HOME}/.hledger.journal ${HOME}/Documents/extrato_nu/.latest*

import: clean
	hledger import --rules=checking_rules.rules ${HOME}/Documents/extrato_nu/NU_*.csv
	hledger import --rules=credit_rules.rules ${HOME}/Documents/extrato_nu/Nubank_*.csv
