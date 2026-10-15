-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_menu_page_map tfa_menu_page_map_id
-- Type: CONSTRAINT

-- Name: tfa_menu_page_map tfa_menu_page_map_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_menu_page_map
    ADD CONSTRAINT tfa_menu_page_map_id PRIMARY KEY (menu_page_map_id);


--
