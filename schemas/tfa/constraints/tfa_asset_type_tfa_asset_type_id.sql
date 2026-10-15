-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_asset_type tfa_asset_type_id
-- Type: CONSTRAINT

-- Name: tfa_asset_type tfa_asset_type_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_asset_type
    ADD CONSTRAINT tfa_asset_type_id PRIMARY KEY (asset_type_id);


--
