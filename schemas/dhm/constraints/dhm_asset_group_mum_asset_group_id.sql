-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_group mum_asset_group_id
-- Type: CONSTRAINT

-- Name: dhm_asset_group mum_asset_group_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_group
    ADD CONSTRAINT mum_asset_group_id PRIMARY KEY (asset_group_id);


--
