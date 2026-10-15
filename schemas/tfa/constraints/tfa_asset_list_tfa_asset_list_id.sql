-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_asset_list tfa_asset_list_id
-- Type: CONSTRAINT

-- Name: tfa_asset_list tfa_asset_list_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_asset_list
    ADD CONSTRAINT tfa_asset_list_id PRIMARY KEY (asset_list_id);


--
