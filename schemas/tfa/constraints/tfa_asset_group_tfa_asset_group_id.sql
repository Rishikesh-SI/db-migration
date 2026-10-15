-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_asset_group tfa_asset_group_id
-- Type: CONSTRAINT

-- Name: tfa_asset_group tfa_asset_group_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_asset_group
    ADD CONSTRAINT tfa_asset_group_id PRIMARY KEY (asset_group_id);


--
