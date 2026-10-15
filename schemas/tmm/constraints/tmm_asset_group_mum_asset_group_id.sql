-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_asset_group mum_asset_group_id
-- Type: CONSTRAINT

-- Name: tmm_asset_group mum_asset_group_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_asset_group
    ADD CONSTRAINT mum_asset_group_id PRIMARY KEY (asset_group_id);


--
