-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_asset_list title_alias_unq
-- Type: CONSTRAINT

-- Name: labkc_v1_asset_list title_alias_unq; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_asset_list
    ADD CONSTRAINT title_alias_unq UNIQUE (title_alias);


--
