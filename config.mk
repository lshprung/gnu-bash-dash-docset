SRC_ICON_FILE = $(SOURCE_DIR)/icon.png

MANUAL_URL  = https://www.gnu.org/software/bash/manual/bash.html_node.tar.gz
MANUAL_FILE = tmp/bash.html_node.tar.gz

$(MANUAL_FILE): tmp
	curl -o $@ $(MANUAL_URL)

$(DOCUMENTS_DIR): $(RESOURCES_DIR) $(MANUAL_FILE)
	mkdir -p $@
	tar -x -z -f $(MANUAL_FILE) -C $@

$(INDEX_FILE): $(SOURCE_DIR)/src/index-pages.py $(SCRIPTS_DIR)/gnu/index-terms-colon.py $(DOCUMENTS_DIR)
	rm -f $@
	$(SOURCE_DIR)/src/index-pages.py $@ $(DOCUMENTS_DIR)/*.html
	$(SCRIPTS_DIR)/gnu/index-terms-colon.py Builtin  $@ $(DOCUMENTS_DIR)/Builtin-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-colon.py Word     $@ $(DOCUMENTS_DIR)/Reserved-Word-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-colon.py Variable $@ $(DOCUMENTS_DIR)/Variable-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-colon.py Function $@ $(DOCUMENTS_DIR)/Function-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-colon.py Entry    $@ $(DOCUMENTS_DIR)/Concept-Index.html
