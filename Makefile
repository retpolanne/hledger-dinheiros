init:
	touch private.rules
	brew bundle

clean:
	-rm ${HOME}/.hledger.journal ${HOME}/Documents/extrato_nu/.latest*

import: clean
	hledger import --rules=rules.rules ${HOME}/Documents/extrato_nu/*.csv
